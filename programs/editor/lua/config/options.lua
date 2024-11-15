local opt = vim.opt

opt.ma = true
opt.mouse = 'a'
opt.cursorline = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.number = true
opt.relativenumber = true
opt.hidden = true
opt.cmdheight = 1
opt.wrap = true
opt.breakindent = true
opt.linebreak = true

opt.ignorecase = true
opt.smartcase = true
vim.cmd [[":set nofoldenable"]]

opt.autoread = true
opt.nu = true
opt.foldlevelstart = 99
opt.scrolloff = 7
opt.backup = false
opt.writebackup = false
opt.swapfile = false
--
-- use y and p with the system clipboard
-- opt.clipboard = "unnamedplus"
opt.clipboard:append("unnamedplus")

vim.cmd.colorscheme('nano-theme')
opt.background = "light" -- or "dark".
