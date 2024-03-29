-- file explorer
local get_icon = require("astronvim.utils").get_icon

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute { toggle = true, dir = require("user.util").get_root() }
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<C-u>",
      function()
        require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require "neo-tree"
      end
    end
  end,
  opts = {
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = get_icon "FolderClosed" .. " File" },
        { source = "buffers", display_name = get_icon "DefaultFile" .. " Bufs" },
        { source = "git_status", display_name = get_icon "Git" .. " Git" },
        { source = "diagnostics", display_name = get_icon "Diagnostic" .. " Diagnostic" },
      },
    },
    default_component_configs = {
      indent = { padding = 0, indent_size = 1 },
      icon = {
        folder_closed = get_icon "FolderClosed",
        folder_open = get_icon "FolderOpen",
        folder_empty = get_icon "FolderEmpty",
        default = get_icon "DefaultFile",
      },
      modified = { symbol = get_icon "FileModified" },
      git_status = {
        symbols = {
          added = get_icon "GitAdd",
          deleted = get_icon "GitDelete",
          modified = get_icon "GitChange",
          renamed = get_icon "GitRenamed",
          untracked = get_icon "GitUntracked",
          ignored = get_icon "GitIgnored",
          unstaged = get_icon "GitUnstaged",
          staged = get_icon "GitStaged",
          conflict = get_icon "GitConflict",
        },
      },
    },
    commands = {
      system_open = function(state)
        require("astronvim.utils").system_open(state.tree:get_node():get_id())
      end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- if not a directory just open it
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          e = { val = modify(filename, ":e"), msg = "Extension only" },
          f = { val = filename, msg = "Filename" },
          F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
          h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
          p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
          P = { val = filepath, msg = "Absolute path" },
        }

        local messages = {
          { "\nChoose to copy to clipboard:\n", "Normal" },
        }
        for i, result in pairs(results) do
          if result.val and result.val ~= "" then
            vim.list_extend(messages, {
              { ("%s."):format(i), "Identifier" },
              { (" %s: "):format(result.msg) },
              { result.val, "String" },
              { "\n" },
            })
          end
        end
        vim.api.nvim_echo(messages, false, {})
        local result = results[vim.fn.getcharstr()]
        if result and result.val and result.val ~= "" then
          vim.notify("Copied: " .. result.val)
          vim.fn.setreg("+", result.val)
        end
      end,
    },
    window = {
      width = 30,
      mappings = {
        ["[b"] = "prev_source",
        ["]b"] = "next_source",
        ["<space>"] = "none",
        ["/"] = "noop",
        ["h"] = "parent_or_close",
        ["l"] = "child_or_open",
        ["o"] = "open",
        ["O"] = "system_open",
        ["e"] = function()
          vim.api.nvim_exec("Neotree focus filesystem left", true)
        end,
        ["B"] = function()
          vim.api.nvim_exec("Neotree focus buffers left", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree focus git_status left", true)
        end,
        ["Y"] = function(state)
          local node = state.tree:get_node()
          -- relative
          local content = node.path:gsub(state.path, ""):sub(2)
          vim.fn.setreg('"', content)
          vim.fn.setreg("*", content)
        end,
      },
    },
    filesystem = {
      -- bind_to_cwd = false,
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      bind_to_cwd = true,
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          "node_modules",
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
          "*.pyc",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          ".yabs",
          ".gitignored",
          ".github",
          ".vscode",
          ".stylua.toml",
          ".venv",
          ".prettierrc.json",
          ".stylelintrc.json",
          ".djlint_rules.yaml",
          ".markdownlint.jsonc",
          ".vuepress",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
          ".git",
          ".ipynb_checkpoints",
          ".venv",
          ".mypy_cache",
          ".pytest_cache",
          "node_modules",
          "package-lock.json",
          "poetry.lock",
          "yarn.locsk",
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
    },
  },
}
