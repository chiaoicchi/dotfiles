-- Visibility setting
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Coding setting
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false

-- Search setting
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indent setting
local indent_settings = {
  rust = { tabstop = 4, shiftwidth = 4, expandtab = true },
  lua = { tabstop = 2, shiftwidth = 2, expandtab = true },
  python = { tabstop = 4, shiftwidth = 4, expandtab = true },
}
for ft, opts in pairs(indent_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.opt_local.tabstop = opts.tabstop
      vim.opt_local.shiftwidth = opts.shiftwidth
      vim.opt_local.expandtab = opts.expandtab
    end,
  })
end
