-- Install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "git@github.com:folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- Neovide configuration
vim.g.neovide_floating_blur_amount_x = 1.5
vim.g.neovide_floating_blur_amount_y = 1.5
vim.g.neovide_scroll_animation_length = 0.13
vim.g.neovide_background_color = "#000000aa"
vim.o.guifont = "Iosevka:h10"

---------- Core settings
vim.g.mapleader = ","
vim.o.inccmd = "nosplit"
vim.o.number = true
vim.o.mouse = "a"
vim.o.shortmess = "c"
vim.o.concealcursor = ""
vim.o.textwidth = 120
vim.o.listchars = "tab:→ ,nbsp:␣,trail:~,precedes:«,extends:»"
vim.o.list = true
vim.o.wrap = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 3
vim.g.rustfmt_autosave = false
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.colorcolumn = "120"
vim.o.cursorline = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.winblend = 0
vim.o.pumblend = 0
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false
vim.o.signcolumn = "yes"
vim.o.foldcolumn = '1'

require("lazy").setup("plugins", {
    ui = {
        border = "rounded",
    },
})

-- Fixed size help panel
vim.cmd([[
    augroup vimrc_help
        autocmd!
        autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vert resize 80 | set winfixwidth | endif
    augroup END
]])
