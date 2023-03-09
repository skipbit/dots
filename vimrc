
" initialize
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

" dein plugin manager
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
"" set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': {'unix': 'gmake', 'linux': 'make', 'mac': 'make -f make_mac.mak'} })

call dein#add('vim-jp/vimdoc-ja')
call dein#add('editorconfig/editorconfig-vim')

" languages
call dein#add('vim-jp/cpp-vim')
call dein#add('vim-scripts/a.vim')
call dein#add('peterhoeg/vim-qml')

" tools/lsp
if executable('clangd')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('mattn/vim-lsp-settings')

  au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'cuda', 'objc', 'objcpp'],
        \ })
  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    let g:lsp_format_sync_timeout = 1000
  endfunction

  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
  let g:asyncomplete_auto_popup = 0
endif

" tools/explorer (nerdtree)
call dein#add('scrooloose/nerdtree')
nnoremap <C-l> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFind<CR>

" tools/explorer (fzf)
if executable('fzf')
  for s:fzf_home in ['~/.fzf', '$HOMEBREW_PREFIX/opt/fzf']
    if isdirectory(expand(s:fzf_home))
      " execute 'set runtimepath+=' . expand(s:fzf_home)
      let &runtimepath .= ',' . expand(s:fzf_home)
      nnoremap <leader><C-f> :FZF<CR>
      break
    endif
  endfor

  call dein#add('junegunn/fzf.vim')
  function! s:fzf_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{"filename": v:val}'))
    copen
    cc
  endfunction
  let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit', 'ctrl-q': function('s:fzf_quickfix_list')}
  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
  nnoremap <leader>zz :GFiles?<CR>
  nnoremap <leader>zf :GFiles --recurse-submodule<CR>
  nnoremap <leader>zF :Files<CR>
  nnoremap <leader>zb :Buffers<CR>
  nnoremap <leader>zB :Windows<CR>
  nnoremap <leader>zl :BLines<CR>
  nnoremap <leader>zL :Lines<CR>
  nnoremap <leader>zh :History<CR>
  nnoremap <leader>zc :History:<CR>
  nnoremap <leader>z/ :History/<CR>
  nnoremap <leader>zg :BCommits<CR>
  nnoremap <leader>zG :Commits<CR>
  nnoremap <leader>zm :Maps<CR>
  nnoremap <leader>zt :BTags<CR>
  nnoremap <leader>zT :Tags<CR>
  nnoremap <leader>zr :Rg<CR>

  nnoremap <silent> g<C-]> :call fzf#vim#tags(expand('<cword>'))<CR>
  " nnoremap <silent> g<C-[> :call fzf#run(fzf#wrap({'source': 'cscope -f .scope -L -3 ' . expand('<cword>') . ' $(git ls-files --recurse-submodule)'}))<CR>
  " command! -bang -nargs=? -complete=dir BLines call fzf#vim#buffer_lines(<q-args>, fzf#vim#with_preview(), <bang>0)

  " completion support
  inoremap <expr> <C-x><C-f>  fzf#vim#complete#path('fd')
  inoremap <expr> <C-x><C-f>  fzf#vim#complete#path('rg --files')
  inoremap <expr> <C-x><C-k>  fzf#vim#complete#word({'window': {'width': 0.2, 'height': 0.9, 'xoffset': 1}})
  inoremap <expr> <C-x><C-l>  fzf#vim#complete(fzf#wrap({'prefix': '^.*#', 'source': 'rg -n ^ --color always', 'options': '--ansi --delimiter : --nth 3..', 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
endif

" tools/scm/tig
if executable('tig')
  call dein#add('iberianpig/tig-explorer.vim')
  nnoremap <leader>tp :TigOpenProjectRootDir<CR>
  nnoremap <leader>th :TigOpenCurrentFile<CR>
  nnoremap <leader>tg :TigGrep<CR>
  vnoremap <leader>tg "zy:TigGrep<Space><C-r>z<CR>
  nnoremap <leader>tr :TigGrepResume<CR>
  nnoremap <leader>tb :TigBlame<CR>
  nnoremap <leader>ts :TigStatus<CR>

  nnoremap <leader>t-s :term ++close tig status<CR>
  nnoremap <leader>t-S :term ++close tig -- %<CR>
  nnoremap <leader>t-v :vert term ++close tig status<CR>
  nnoremap <leader>t-V :vert term ++close tig -- %<CR>
endif

" tools/vim-fugitive
call dein#add('tpope/vim-fugitive')

" tools/vim-gitgutter
call dein#add('airblade/vim-gitgutter')
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterRevertHunk)

call dein#end()
filetype plugin indent on     " filetype plugin (filetype 毎に固有の設定) を有効にする

if dein#check_install()
  call dein#install()
endif

" GENERIC
set fileencoding=utf-8        " 保存時の文字コード
set fileformats=unix,mac,dos  " 改行コードの自動判別
"set ambiwidth=double          " ○/ □が崩れ問題対策
set nobackup                  " backup ファイルなし
set noswapfile                " swap ファイルなし
set splitbelow                " 水平分割は下に開く
set splitright                " 垂直分割は右に開く
set history=1024              " 履歴を 1024 件保存する

" VIEWING
"set title                    " ウィンドウタイトルの設定
set number                    " 行番号表示
set ruler                     " 画面最下部にルーラー表示
set cursorline                " カーソルのある行をハイライト
set laststatus=2              " ステータスラインを常に表示

set showcmd                   " 実行したコマンドをステータスライン下に表示
set showmatch                 " 閉じカッコに対応するカッコを表示
set matchtime=1               " カッコ対応を 0.1sec にする (デフォルトは 5 で 0.5)
set showmode                  " 現在のモード表示
set wildmenu                  " コマンドモードの補完 (tab)
set foldmethod=marker         " 折りたたみ方法
set nowrap                    " 折り返ししない

" EDITING
set modeline                  " モードラインを有効にする
set modelines=5               " モードラインを読み込む行数 (/usr/share/vim/vimrc で 0 になっていたので再反映)
set expandtab                 " タブを空白に置き換える
set ts=4 sw=4 sts=0           " tabstop, softtabstop, shiftwidth=スマートインデントの増減幅
set autoindent                " 前の行のインデントを継続
set smartindent               " 構文に応じてインデントを調節
augroup GenericFileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead,FileType vim  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead,FileType sh   setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead,FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead,FileType py   setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead,FileType yml  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead,FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead,FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" w!! で強制sudo保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

" cpp/h ファイル名上で gf -> 開く / gs -> 水平分割で開く / gv -> 垂直分割で開く
nnoremap gs <C-w>f<CR>
nnoremap gv :vertical wincmd f<CR>

" COMPLETION
set dictionary=/usr/share/dict/words  " 辞書を指定 (CTRL-X CTRL-K)

if executable('ctags')
  if filereadable('.tags')
    set tags+=.tags
  endif
  if filereadable(expand('~/.qt-tags'))
    set tags+=~/.qt-tags
  endif
endif

if has('cscope') && executable('cscope')
  if filereadable('.scope')
    cs add .scope
  endif
  " CTRL + _ (shift + -)
  nnoremap <C-_>s :cs find s  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>g :cs find g  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>d :cs find d  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>c :cs find c  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>t :cs find t  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>e :cs find e  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-_>f :cs find f  <C-r>=expand('<cfile>')<CR><CR>
  nnoremap <C-_>i :cs find i ^<C-r>=expand('<cfile>')<CR><CR>
  nnoremap <C-_>a :cs find a  <C-r>=expand('<cword>')<CR><CR>
  " CTRL + @ = horizontal split cscope
  nnoremap <C-@>s :scs find s  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>g :scs find g  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>d :scs find d  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>c :scs find c  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>t :scs find t  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>e :scs find e  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>f :scs find f  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>i :scs find i ^<C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@>a :scs find a  <C-r>=expand('<cword>')<CR><CR>
  " CTRL + @ x 2 = vertical split cscope
  nnoremap <C-@><C-@>s :vert scs find s  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>g :vert scs find g  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>d :vert scs find d  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>c :vert scs find c  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>t :vert scs find t  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>e :vert scs find e  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>f :vert scs find f  <C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>i :vert scs find i ^<C-r>=expand('<cword>')<CR><CR>
  nnoremap <C-@><C-@>a :vert scs find a  <C-r>=expand('<cword>')<CR><CR>
endif

" SEARCHING
set incsearch                 " インクリメンタルサーチ (入力中に検索を開始する)
set ignorecase                " 検索パターンに大文字小文字を区別しない
set smartcase                 " 大文字を含んでいたら区別するようにする
set hlsearch                  " 結果をハイライト
" esc x 2 でハイライト切り替え (普通に消す場合は :noh)
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
" 選択部分を * で検索 (# で後方検索)
vnoremap * "zy:let @/ = @z<CR>n
vnoremap # "zy:let @/ = @z<CR>N
" \g で カーソル下の単語を git repository の登録ファイル内から検索 (vimgrep + quickfix) -> \G なら case-sensitive
nnoremap <leader>g :vimgrep /<C-r><C-w>\c/gj `git ls-files --recurse-submodule` <Bar>cwindow<CR>
nnoremap <leader>G :vimgrep /<C-r><C-w>\C/gj `git ls-files --recurse-submodule` <Bar>cwindow<CR>
" \g で 選択中の単語を git repository の登録ファイル内から検索 (vimgrep + quickfix) -> \G なら case-sensitive
vnoremap <leader>g "zy:vimgrep /<C-r>z\c/gj `git ls-files --recurse-submodule` <Bar>cwindow<CR>
vnoremap <leader>G "zy:vimgrep /<C-r>z\C/gj `git ls-files --recurse-submodule` <Bar>cwindow<CR>

syntax enable

colorscheme desert
" update/overwrite colorscheme definition
highlight Normal ctermbg=none

" paste support
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" diff support (/usr/share/vim/vim74/vimrc_example.vim)
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

" git-diff support
if executable('git')
  function GitDiff()
    :silent write
    :silent execute '!git diff --color=always -- ' . expand('%:p') . ' | less --RAW-CONTROL-CHARS'
    :redraw!
  endfunction
  "nnoremap <leader>gd :call GitDiff()<cr>
  command! Gd :call GitDiff()

  function GitVimDiff()
    :silent write
    :silent execute '!git difftool --tool=vimdiff -- ' . expand(' %:p')
    :redraw!
  endfunction
  "nnoremap <leader>vd: call GitVimDiff()
  command! Gdv :call GitVimDiff()
  command! Gvd :call GitVimDiff()
endif

" templates
augroup GnenericFileTypeTemplate
  " autocmd BufNewFile *.py 0r $HOME/.vim/templates/skel.py
  autocmd BufNewFile,BufRead *.py if getfsize(@%) <= 0 | 0r $HOME/.vim/templates/skel.py | endif
  autocmd BufNewFile,BufRead *.erb if getfsize(@%) <= 0 | 0r $HOME/.vim/templates/skel.erb | endif
augroup END

" developer tools support
"" augroup GenericDebugger
""   packadd termdebug
""   let g:termdebug_wide = 1
""   let termdebugger = 'lldb'
"" augroup END
augroup GenericDevelopment
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep cwindow
augroup END

