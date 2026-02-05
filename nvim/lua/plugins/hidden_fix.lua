return {
  -- 1. Dateibaum (Neo-tree) fixen
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { ".git" },
        },
        follow_current_file = { enabled = true },
      },
    },
  },

  -- 2. Suche (Telescope) fixen
  {
    "nvim-telescope/telescope.nvim",
    -- Die "keys" Sektion überschreibt das LazyVim-Standardverhalten für <leader><leader>
    keys = {
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Files (Root + Hidden)",
      },
    },
    -- "opts" sorgt dafür, dass auch andere Suchen (wie <leader>ff) die Dateien finden
    opts = function(_, opts)
      opts.pickers = opts.pickers or {}
      opts.pickers.find_files = {
        hidden = true,
        no_ignore = true,
      }
      -- Das hier schaltet "Hidden" auch für die Textsuche (grep) ein
      opts.defaults = opts.defaults or {}
      opts.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--no-ignore",
      }
    end,
  },
}
