set number
set mouse=a
set hlsearch
set ignorecase
set incsearch
set smartcase
set autoindent
set wildmenu
set showmatch
set noerrorbells
set noswapfile
set cursorline
hi Comment ctermfg=3
set nowritebackup
set nobackup
set shiftwidth=2
set cindent
set laststatus=2 
set showcmd
set clipboard+=unnamedplus
filetype on

cmap w!! w !sudo tee > /dev/null %
cmap syn SyntasticCheck

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k

nnoremap J o<Esc>k
nnoremap K O<Esc>j

map H ^
map L $

map W "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
map # W:%s/<C-r>///g<Left><Left>

map F %
map <Space> :split \| :LspDefinition<CR>
map <Enter> :LspHover<CR>


" 行を移動
nnoremap <C-k> "zdd<Up>"zP
nnoremap <C-j> "zdd"zp
" 複数行を移動
vnoremap <C-k> "zx<Up>"zP`[V`]
vnoremap <C-j> "zx"zp`[V`]


nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"dein Scripts-----------------------------
" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#load_toml('$HOME/.vim/dein.toml')
  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

let g:dein#auto_recache = 1

if argc() == 0
	autocmd VimENTER * NERDTree
endif 
let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

let g:clang_format_style = 'llvm'
let g:clang_format_auto = 1
let g:clang_check_sysntax_auto = 1

let g:syntastic_haskell_checkers = ["hlint"]
let g:syntastic_c_checkers   = ["vim-clang"]
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_cpp_checkers   = ["vim-clang"]

filetype plugin on 
"mdファイル用
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
" Need: kannokanno/previm
autocmd BufRead,BufNewFile *.md  nnoremap <silent> <C-p> :PrevimOpen<CR> 

" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000



""syntastic-----------------
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq=0
"----------------------------------------

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_auto_completeopt = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END




" ---------------Coq-----------
autocmd BufNewFile,BufRead *.v set filetype=coq

function! MyCoqMaps()
  nnoremap <silent> <C-C>        :CoqLaunch<CR>
  nnoremap <silent> <Leader>j    :CoqNext<CR>
  nnoremap <silent> <Leader>k    :CoqBack<CR>
  nnoremap <silent> <Leader>l    :CoqToCursor<CR>
  nnoremap <silent> <Leader>G    :CoqToLast<CR>
  nnoremap <silent> <Leader>g    :CoqRerun<CR>
  nnoremap <silent> <Leader>t    :MoveToTop<CR>
  nnoremap <silent> <Leader><F5> :CoqRefresh<CR>
  nnoremap <silent> <Leader>T    :CoqStop<CR> :CoqLaunch<CR>

  nnoremap <C-n>                 :CoqStop<CR> :NERDTreeToggle<CR>
  nnoremap <C-Down>  :CoqNext<CR>
  nnoremap <C-Up> :CoqBack<CR>

  nnoremap <Leader>compute :CoqQuery Compute .<Left>
  nnoremap <Leader>print :CoqQuery Print .<Left>
  nnoremap <Leader>check :CoqQuery Check .<Left>
  nnoremap <Leader>se :CoqQuery Search ().<Left><Left>
  colorscheme hybrid
  set background=dark
endfunction


augroup my_coq
  au!
  au FileType coq :call MyCoqMaps()
augroup END

hi CoqChecked      ctermbg=17
hi CoqCheckedAxiom ctermbg=58
hi CoqQueued       ctermbg=22
hi CoqMarkedWarn   ctermbg=64
hi CoqCheckedWarn  ctermbg=64
hi CoqMarkedError  ctermbg=160
hi CoqCheckedError ctermbg=160
" --------------------------------


" rus.vim
let g:rustfmt_autosave = 1

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
let g:neosnippet#enable_snipmate_compatibility = 1

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif


set hidden

let g:ale_linters = { 'haskell': ['hie'], }

if executable('hie')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'hie',
      \ 'cmd': {server_info->['hie']},
      \ 'whitelist': ['haskell'],
      \ })
endif

