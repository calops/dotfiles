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
vim.o.guifont = "Iosevka:h9"

---------- Core settings
vim.g.mapleader = ","
vim.o.inccmd = "nosplit"
vim.o.number = true
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
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
vim.o.scrolloff = 10
vim.o.fixendofline = true

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

-- Full line error highlights
local utils = require('plugins.ui.utils')
local lines_ns = vim.api.nvim_create_namespace("diag_lines")
local underlines_ns = vim.api.nvim_create_namespace("diag_underlines")

local function clear_highlights(buf)
    vim.api.nvim_buf_clear_namespace(buf, lines_ns, 0, -1)
end

local function clear_underlines(buf)
    vim.api.nvim_buf_clear_namespace(buf, underlines_ns, 0, -1)
end

local function update_underlines(buf, diagnostics)
    clear_underlines(buf)

    for _, diagnostic in ipairs(diagnostics) do
        if diagnostic.col ~= 0 and diagnostic.end_col ~= vim.fn.col({diagnostic.lnum + 1, '$'}) then
            vim.api.nvim_buf_set_extmark(buf, underlines_ns, diagnostic.lnum, diagnostic.col, {
                hl_mode = 'combine',
                hl_group = utils.diags_underlines()[diagnostic.severity],
                end_col = diagnostic.end_col,
                priority = 14 - diagnostic.severity,
            })
        end
    end
end

local function update_highlights(buf, diagnostics)
    clear_highlights(buf)

    for _, diagnostic in ipairs(diagnostics) do
        vim.api.nvim_buf_set_extmark(buf, lines_ns, diagnostic.lnum, 0, {
            hl_mode = 'combine',
            hl_eol = true,
            hl_group = utils.diags_lines()[diagnostic.severity],
            end_row = diagnostic.lnum + 1,
            priority = 14 - diagnostic.severity,
        })
    end
end

vim.diagnostic.handlers.diagnostic_lines = {
    show = function(_, bufnr, diagnostics, _)
        update_highlights(bufnr, diagnostics)
    end,
    hide = function(_, bufnr)
        clear_highlights(bufnr)
    end,
}

-- vim.diagnostic.handlers.underline = {
--     show = function(_, bufnr, diagnostics, _)
--         update_underlines(bufnr, diagnostics)
--     end,
--     hide = function(_, bufnr)
--         clear_underlines(bufnr)
--     end,
-- }

vim.cmd [[
    autocmd FileType rust setlocal textwidth=120
]]

