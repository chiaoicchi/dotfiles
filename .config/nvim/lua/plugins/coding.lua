return {
  -- Comment
  {
    "git@github.com:numToStr/Comment.nvim",
    opts = {},
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
      })
    end,
  },

  -- Auto pair
  {
    "git@github.com:windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Increment/decrement
  {
    "git@github.com:monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          augend.constant.alias.alpha,
          augend.date.alias["%Y/%m/%d"],
        },
      })

      local map = require("dial.map")
      vim.keymap.set("n", "<C-a>", map.inc_normal(), { desc = "Dial Increment" })
      vim.keymap.set("n", "<C-x>", map.dec_normal(), { desc = "Dial Decrement" })
      vim.keymap.set("n", "<C-a>", map.inc_visual(), { desc = "Dial Increment" })
      vim.keymap.set("n", "<C-x>", map.dec_visual(), { desc = "Dial Decrement" })
    end,
  },

  -- Syntax
  {
    "git@github.com:nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensured_installed = {
          "lua",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Git
  {
    "git@github.com:lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Git diff
  {
    "git@github.com:sindrets/diffview.nvim",
    dependencies = {
      "git@github.com:nvim-lua/plenary.nvim",
      "git@github.com:nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "dv",
        function()
          local lib = require("diffview.lib")
          if next(lib.views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Toggle Diffview",
      },
    },
    config = function()
      require("diffview").setup()
    end,
  },

  -- Render markdown
  {
    "git@github.com:MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "git@github.com:nvim-treesitter/nvim-treesitter",
      "git@github.com:nvim-mini/mini.nvim",
      "git@github.com:nvim-mini/mini.icons",
      "git@github.com:nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
