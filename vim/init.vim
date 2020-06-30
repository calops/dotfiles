call plug#begin('~/.config/nvim/plugged')

" Languages
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'

" Vim-fu
Plug 'chaoren/vim-wordmotion'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

" Aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" Dev tools
Plug 'antoinemadec/coc-fzf'
Plug 'janko-m/vim-test'
Plug 'neoclide/coc.nvim', { 'do': 'yarnpkg install --frozen-lockfile' }
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'

" File browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

call plug#end()

" Core commands
let mapleader = ","

" Colors
set background=light
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \         'cursorline' : ['#080808', '233'],
  \         'linenumber_bg' : ['#080808', '233'],
  \         'cursorcolumn' : ['#080808', '233'],
  \         'visual_fg' : ['NONE', 'NONE'],
  \         'visual_bg' : ['#8787af', '237']
  \       }
  \     }
  \   }
  \ }
colorscheme PaperColor
set colorcolumn=120

" Mouse
set mouse=a

" Fuzzy finder
nnoremap <C-p> :Files<CR>
nnoremap <leader><Space> :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>rg :Rg<Space>

let g:fzf_commits_log_options = '--graph --color=always --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': 'call Centered_floating_window(v:true)' }
let g:coc_fzf_preview = 'right:50%'
let g:coc_fzf_opts = [ '--preview="bat --line-range :300 {}"' ]

function! Centered_floating_window(border)
    let width = min([&columns - 4, max([80, &columns - 30])])
    let height = min([&lines - 4, max([20, &lines - 20])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    if a:border == v:true
        let top = "┌" . repeat("─", width - 2) . "┐"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "└" . repeat("─", width - 2) . "┘"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Normal
        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        au BufWipeout <buffer> exe 'bw '.s:buf
    else
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    endif
endfunction

" File browser
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>

" Line numbers
set number

" Indentation
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
let g:indentLine_faster = 1
let g:indentLine_char = '│'

" Cursor line
set cursorline

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
set shortmess+=c

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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>ac  <Plug>(coc-codeaction)

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
nnoremap <silent> <C-t> :tabnew<CR>
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
  \   "coc-python",
  \   "coc-rust-analyzer",
  \   "coc-sh",
  \   "coc-css",
  \   "coc-json"
  \ ]

" airline
let g:airline_theme = 'papercolor'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#obsession#enabled = 1

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

" vim help
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vert resize 80 | set winfixwidth | endif
augroup END

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gc <Plug>(coc-git-commit)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
