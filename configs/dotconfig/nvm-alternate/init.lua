-- DISABLE LUAROCKS TO FIX INSTALL ISSUES
-- vim.g.rock_enabled = false
-- Alternatively, if the above doesn't work, try this more specific option:
vim.g.lazy_rocks_enabled = false

-- Config for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- My color scheme
vim.cmd('syntax enable')
vim.cmd('colorscheme monokai-dark')
vim.cmd('set background=dark')

-- Turn on absolute line numbers and turn off 
vim.o.number = true
vim.o.relativenumber = false

-- Tab settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Plugin dependencies (THIS IS THE ONLY setup BLOCK)
require("lazy").setup({
  -- Plugins here
  -- Explicitly set plenary
  { "nvim-lua/plenary.nvim" },
  -- Allows configuring formatter and linters as LSP sources
  { "nvimtools/none-ls.nvim" },  -- <-- This line ensures it gets installed
  -- Visually indent guides for better YAML/Ansible Indentation clarity
  { "lukas-reineke/indent-blankline.nvim" },
  -- Improved Diagnostics View
  { "folke/trouble.nvim" },
  -- Fast toggling of comments
  { "numToStr/Comment.nvim", config = true },
  -- Show git diff signs inline in the gutter
  { "lewis6991/gitsigns.nvim" },
  -- Treeseitter Syntax Highllighting & Parsing
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- Lualine Obvious Status Line
  { "nvim-lualine/lualine.nvim" },
  -- Telescope
  { "nvim-telescope/telescope.nvim" },
  -- Which key Keybindings reminders
  { "folke/which-key.nvim" },
  -- LSP LAnguage Server Support for yaml/ansible/debos
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" }, -- LSP Installer
  -- Ansible/YAML
  { "pearofducks/ansible-vim" },
  -- Autoclose brackets, quotes, and other paired
  { "windwp/nvim-autopairs" },
})
-- Yaml and Ansible syntax detection

-- Configure LSP servers using the NEW non-deprecated method
require("vim.lsp.config").setup({
  name = "yamlls",
  -- Your yamlls config here (can still be an empty table)
  -- root_dir = require('lspconfig.util').root_pattern(".git", vim.fn.getcwd()),
})

require("vim.lsp.config").setup({
  name = "ansiblels",
  -- Your ansiblels config here
})


-- autocmd for playbooks and roles
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = {"*.yml", "*.yaml"},
	  callback = function()
	  vim.bo.filetype = "yaml.ansible"
	  end,
})
	
-- Setup Mason to ensure language servers and tools are installed
require("mason").setup()
	
-- Setup none-ls with sources for ansible and yaml linting/formatting
local none_ls = require("none-ls")

-- Create a table for sources, we'll add to it conditionall
local sources = {}

-- YAML formatter (usually safe to add)
table.insert(sources, none_ls.builtins.formatting.yamlfmt)

-- YAML linter (usually safe to add)
table.insert(sources, none_ls.builtins.diagnostics.yamllint)

-- ONLY add ansiblelint if the command is actually available
-- This prevents a crash if the tool isn't installed
if vim.fn.executable("ansible-lint") == 1 then
    table.insert(sources, none_ls.builtins.diagnostics.ansiblelint)
    -- table.insert(sources, none_ls.builtins.formatting.ansiblelint) -- Uncomment this later if you want it
else
    print("ansible-lint not found, skipping...")
end

-- Now setup with our safe sources list
none_ls.setup({ sources = sources })
