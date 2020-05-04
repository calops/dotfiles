" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'cespare/vim-toml'
Plug 'chaoren/vim-wordmotion'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'do': 'yarnpkg install --frozen-lockfile'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Yggdroot/indentLine'
Plug 'dag/vim-fish'

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

" Status line
let g:lightline = {
  \   'colorscheme': 'PaperColor',
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \   },
  \   'component_function': {
  \     'cocstatus': 'coc#status'
  \   },
  \ }

" Mouse
set mouse=a

" Fuzzy finder
nnoremap <C-p> :Files<CR>
nnoremap <leader><Space> :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>rg :Rg<Space>
let g:fzf_commits_log_options = '--graph --color=always --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

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

" Linter
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'python': [ 'pylama' ]}
let g:ale_python_pylama_options = '-i E501'

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
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
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
