-- My favorite color scheme
-- This going to sound silly but do yourself a favor and customize
-- you color schemes in your work place, your eyes and brain
-- will thank you
vim.cmd('syntax enable')
vim.cmd('colorscheme monokai-dark')
vim.cmd('set background=dark')

-- Turn on absolute file numbers and turn off relative
vim.o.number = true
vim.o.relativenumber = false

-- Bootstrapping LazyNvim, only if it doesn't already exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

