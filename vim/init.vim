if empty(glob('~/.vim/autoload/plug.vim'))
    silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Languages
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'rust-lang/rust.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'saltstack/salt-vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Vim-fu
Plug 'Julian/vim-textobj-variable-segment'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user'
Plug 'kshenoy/vim-signature'
Plug 'lambdalisue/reword.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

" Dev tools
Plug 'janko-m/vim-test'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/linediff.vim'

if !exists('g:vscode')
    Plug 'neoclide/coc.nvim', { 'do': 'yarnpkg install --frozen-lockfile' }
    Plug 'vim-python/python-syntax'

    " Aesthetics
    Plug 'sainnhe/edge'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/indentLine'

    " Dev tools
    Plug 'voldikss/vim-floaterm'
    Plug 'tpope/vim-eunuch'
    Plug 'puremourning/vimspector'

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-symbols.nvim'
    Plug 'nvim-telescope/telescope-vimspector.nvim'
    Plug 'fannheyward/telescope-coc.nvim'
endif

call plug#end()

" Core settings
let mapleader = ","
set inccommand=nosplit
set termguicolors
set number
set cursorline
set mouse=a
set shortmess+=c
set concealcursor=
set textwidth=120

" Colors
set background=light
colorscheme edge
set colorcolumn=120

" Fuzzy finder

lua << EOF
require('telescope').setup({
    defaults = {
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = 200,
            },
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        winblend = 30,
    },
})

require('telescope.themes').square_cursor = function()
    local opts = {
        borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
    }
    return require('telescope.themes').get_cursor(opts)
end

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
EOF

nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <leader><Space> <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>h <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader>e <cmd>Telescope symbols theme=square_cursor<cr>

nnoremap <silent> gd <cmd>Telescope coc definitions<cr>
nnoremap <silent> gy <cmd>Telescope coc type_definitions<cr>
nnoremap <silent> gi <cmd>Telescope coc implementations<cr>
nnoremap <silent> gr <cmd>Telescope coc references<cr>
nnoremap <silent> <leader>d <cmd>Telescope coc diagnostics<cr>
nnoremap <silent> <leader>ac <cmd>Telescope coc code_actions theme=square_cursor<cr>

" File browser
nnoremap <silent> <leader>n :CocCommand explorer<CR>

augroup coc_explorer_indentline
    autocmd!
    autocmd! FileType coc-explorer :IndentLinesDisable
augroup END

" Indentation
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
let g:indentLine_faster = 1
let g:indentLine_char = '│'
let g:indentLine_color_gui = '#eeeeee'

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Tests
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
let test#strategy = "neovim"

" Comments
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Completion
set updatetime=200

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
highlight CocHighlightText cterm=bold,underline gui=bold,underline
highlight CocErrorHighlight ctermbg=lightred guibg=lightred

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Special chars
set listchars=tab:→\ ,nbsp:␣,trail:~,precedes:«,extends:»
set list

" Tabs
function! NewTab()
    let view = winsaveview()
    " Have to do it this way, since airline's tabline somehow doesn't show the
    " new tab when using "tabedit %"
    let file = nvim_get_current_buf()
    tabnew
    execute 'buffer' file
    call winrestview(view)
endfunction

nnoremap <silent> <C-t> :call NewTab()<CR>
nnoremap <silent> <C-Tab> :tabnext<CR>
nnoremap <silent> <C-S-Tab> :tabprevious<CR>

" Floating terminal
nnoremap <silent> <leader>fn :FloatermNew<CR>
tnoremap <silent> <C-k> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-j> <C-\><C-n>:FloatermNext<CR>
nnoremap <silent> <C-f> :FloatermToggle<CR>
tnoremap <silent> <C-f> <C-\><C-n>:FloatermToggle<CR>

" Python
let g:python_highlight_all = 1

" Splits
set splitbelow
set splitright

" coc.nvim
let g:coc_global_extensions = [
  \   "coc-vimlsp",
  \   "coc-git",
  \   "coc-highlight",
  \   "coc-tag",
  \   "coc-html",
  \   "coc-fish",
  \   "coc-rust-analyzer",
  \   "coc-sh",
  \   "coc-css",
  \   "coc-explorer",
  \   "coc-yaml",
  \   "coc-json",
  \   "coc-tabnine",
  \   "coc-pyright",
  \ ]

" airline
let g:airline_theme = 'edge'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = ' '

let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ' '
let g:airline#extensions#coc#warning_symbol = ' '

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ' ㏑'
let g:airline_symbols.readonly = ' '
let g:airline_symbols.notexists = '?'

let g:airline_mode_map = {
    \ '__' : '--',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V-L',
    \ '' : 'V-B',
    \ 's'  : 'S',
    \ 'S'  : 'S-L',
    \ '' : 'S-B',
    \ 't'  : 'T',
    \ }

" vim help
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vert resize 80 | set winfixwidth | endif
augroup END

" coc-git
nmap <leader>gp <Plug>(coc-git-prevchunk)
nmap <leader>gp <Plug>(coc-git-nextchunk)
nmap <leader>gs <Plug>(coc-git-chunkinfo)
nmap <leader>ga :CocCommand git.chunkStage<CR>
nmap <leader>gu :CocCommand git.chunkUndo<CR>
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" file types custom settings
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

if !exists('g:vscode')
endif

let g:vimspector_install_gadgets = [ 'debugpy' ]

let g:python3_host_prog  = '~/.virtualenvs/neovim/bin/python'
