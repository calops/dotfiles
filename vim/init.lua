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
vim.o.guifont = "Iosevka Nerd Font:h10"

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
vim.o.fillchars = "diff:╱"
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
vim.o.winblend = 10
vim.o.pumblend = 10
vim.o.cmdheight = 1
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false
vim.o.signcolumn = "yes"

require("lazy").setup("plugins", {
	ui = {
		border = "rounded",
	},
})

---------- Keybindings
local nmap = require("core.utils").nmap
nmap("K", vim.lsp.buf.hover, "Show documentation")
nmap("H", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, "Show diagnostics")
nmap("<C-k>", vim.lsp.buf.signature_help, "Interactive signature help")
nmap("<space>f", vim.lsp.buf.format, "Format code")
nmap("<leader>rn", vim.lsp.buf.rename, "Interactive rename")
nmap("<leader>rf", vim.lsp.buf.format, "Format code")
nmap("<leader>a", vim.lsp.buf.code_action, "Interactive list of code actions")

-- Tabs
local function new_tab()
	vim.cmd([[
        let view = winsaveview()
        tabedit %
        call winrestview(view)
    ]])
end

nmap("<C-t>", new_tab, "Open current buffer in new tab")
nmap("<C-Tab>", ":tabnext<CR>", "View next tab")
nmap("<C-S-Tab>", ":tabprevious<CR>", "View previous tab")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "" })

-- Native vim commands
vim.cmd([[
    " Fixed size help panel
    augroup vimrc_help
        autocmd!
        autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vert resize 80 | set winfixwidth | endif
    augroup END
]])
