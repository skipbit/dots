
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
call dein#add('leafgarland/typescript-vim')

" tools/file
call dein#add('scrooloose/nerdtree')
map <C-l> :NERDTreeToggle<CR>
map <C-n> :NERDTreeFind<CR>

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

" COMPLETION
set dictionary=/usr/share/dict/words  " 辞書を指定 (CTRL-X CTRL-K)

" w!! で強制sudo保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

" cpp/h ファイル名上で gf -> 開く / gs -> 水平分割で開く / gv -> 垂直分割で開く
nnoremap gs <C-w>f<CR>
nnoremap gv :vertical wincmd f<CR>

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

syntax enable
colorscheme desert

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

" templates
augroup GnenericFileTypeTemplate
  " autocmd BufNewFile *.py 0r $HOME/.vim/templates/skel.py
  autocmd BufNewFile,BufRead *.py if getfsize(@%) <= 0 | 0r $HOME/.vim/templates/skel.py | endif
  autocmd BufNewFile,BufRead *.erb if getfsize(@%) <= 0 | 0r $HOME/.vim/templates/skel.erb | endif
augroup END

