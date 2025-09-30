return {
  -- Status line
  {
    "git@github.com:nvim-lualine/lualine.nvim",
    dependencies = {
      "git@github.com:nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup()
    end,
  },

  -- Color scheme
  {
    "git@github.com:navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "cool",
      })
      require("onedark").load()
    end,
  },

  -- Indent guide
  {
    "git@github.com:shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
          },
        },
        indent = {
          enable = true,
        },
        line_num = {
          enable = true,
        },
        blank = {
          enable = true,
        },
      })
    end,
  },

  -- File tree
  {
    "git@github.com:nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "git@github.com:nvim-lua/plenary.nvim",
      "git@github.com:MunifTanjim/nui.nvim",
      "git@github.com:nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnositcs = true,
        window = {
          width = 30,
          mappings = {
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["q"] = "close_window",
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignores = false,
          },
        },
        default_component_configs = {
          indent = {
            with_markers = true,
          },
          git_status = {
            symbols = {
              added = "A",
              modified = "M",
              deleted = "D",
              renamed = "R",
              untracked = "?",
            },
          },
        },
      })
    end,
  },

  -- Tab line
  {
    "git@github.com:romgrk/barbar.nvim",
    dependencies = {
      "git@github.com:lewis6991/gitsigns.nvim",
      "git@github.com:nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false;
    end,
    opts = {
      sidebar_filetypes = {
        ["neo-tree"] = { event = "BufWipeout" },
      },
    },
    version = "^1.0.0",
  },
}
