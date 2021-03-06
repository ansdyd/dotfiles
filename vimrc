set nocompatible              " required
filetype off                  " required

" for fzf
set rtp+=/usr/local/opt/fzf
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'Valloric/YouCompleteMe'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
"Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/seoul256.vim'
Plugin 'tpope/vim-rhubarb'
Plugin 'morhetz/gruvbox'
Plugi 'mhinz/vim-signify'
Plugin 'leafgarland/typescript-vim'
Plugin 'owickstrom/vim-colors-paramount'

"FZF
Plugin 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'FZF'
set runtimepath +=~/.fzf
map <leader>f :FZFRg<CR>
map <leader>w :FZFWordRg<CR>
map <leader>p :FZF<CR>

command! -bang -nargs=* FZFWordRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
      \      . shellescape(expand("<cword>")), 1, {'options': '--delimiter : --nth 4..'}, <bang>0
      \ )

command! -bang -nargs=* FZFRg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
      \      . shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0
      \ )
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


autocmd FileType qf wincmd J


" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set cursorline
set nowrap

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1


" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_ale_fix_on_save = 1
let g:ale_list_window_Size = 4
map <C-b> :ALEGoToDefinition<CR>
map <leader>r :ALEFindReferences<CR>
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_linters = {
\   'typescript': ['tsserver', 'eslint'],
\   'go': ['gopls', 'golint'],
\   'cpp': ['g++', 'clang', 'clangd'],
\   'java': ['javalsp'],
\   'python': ['flake8', 'mypy', 'pylint', 'pyls'],
\}


" for YCM
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")

"map <C-b> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" for backspace
set backspace=indent,eol,start

" highlight my searches
set hlsearch

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"better go to definition navigations
nnoremap <leader>v :vsp <CR>:exe "ALEGoToDefinition" <CR>
nnoremap <leader>s :sp <CR>:exe "ALEGoToDefinition"<CR>
nnoremap <leader>t :tab split <CR>:exe "ALEGoToDefinition"<CR>

"To better follow PEP 8 guidelines
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set fileformat=unix |
    \ set colorcolumn=80

au BufNewFile,BufRead *.cpp,*.c
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set fileformat=unix |
    \ set colorcolumn=100

" For javascript development
au BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 | 
    \ set autoindent |
    \ set expandtab |
    \ set syntax=typescript |
    \ set fileformat=unix

" For html development
au BufNewFile,BufRead *.html
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set autoindent |
    \ set expandtab |
    \ set fileformat=unix

au BufNewFile,BufRead *.sls
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set autoindent |
    \ set expandtab |
    \ set fileformat=unix

"Flag unnecessary white space
highlight BadWhitespace ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8
let python_highlight_all=1

set nu
syntax on

" This is for nerdtree
map <C-n> :NERDTreeToggle<CR>

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


" syntastic
"let g:syntastic_go_checkers = ['go', 'golint']
"let g:syntastic_python_checkers = ['pyflakes', 'pylint']
"let g:syntastic_javascript_checkers=['eslint']
"let g:syntastic_check_on_wq = 0
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>c :exe "GoCallees"<CR>
au Filetype go nnoremap <leader>d :exe "GoDecls"<CR>
au Filetype go nnoremap <leader>r :exe "GoReferrers"<CR>
au Filetype go nnoremap <leader>e :exe "GoDescribe"<CR>
au Filetype go nnoremap <leader>i :exe "GoImports"<CR>
au Filetype go nnoremap <leader>a :exe "GoInfo"<CR>
au Filetype go nnoremap <leader>m :exe "GoMetaLinter"<CR>

" Use YouCompleteMe for go to definition in C++/C files
au Filetype cpp nnoremap <C-b> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" vim Fugitive hotkeys
nnoremap <leader>g :Gstatus<CR>
" colorscheme
let g:seoul256_background = 233
colo seoul256
"colorscheme paramount

" for easy searching
vnoremap // y/<C-R>"<CR>
