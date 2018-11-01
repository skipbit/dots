#
# options
#

##### General #####

# ビープ音をならさないようにする
setopt NO_beep

# 指定したコマンド名が無く、ディレクトリ名と一致した場合cdする
setopt auto_cd

# cdの引数にディレクトリでなく、なおかつ'/'でないとき、頭に'~'を挿入
setopt cdable_vars

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume

# 内部コマンドのechoをBSD互換にする
setopt bsd_echo

##### Completion #####

# 補完候補が複数ある時に一覧表示する
setopt auto_list

# 補完キー(Tab,Ctrl+I)を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# 括弧の対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の/を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終っている場合、末尾の/を自動的に取り除く
setopt auto_remove_slash

# auto_listの補完候補一覧で、ls -Fのようにファイルの種別をマーク表示
setopt list_types

# {a-c}をa b cに展開する機能を使えるようにする
setopt brace_ccl

# シンボリックリンクは実態を追うようになる
setopt chase_links

# コマンド名が不正な時修正す驍ゥたずねる
setopt correct

# =command を command のパス名に展開する
setopt equals

# '#','~','^'をファイル名生成のパターンに加える
setopt extended_glob

# シェルが終了しても裏ジョブにHUPシグナルを送らないようにする
setopt NO_hup

# Ctrl+Dでは終了しないようになる(exit,logoutなどを使う)
setopt ignore_eof

# コマンドラインでも#以降をコメントとみなす
#setopt interactive_comment

# 内部コマンドjobsの出力をデフォルトでjobs -lにする
setopt long_list_jobs

# コマンドラインの引数で --prefix=/usrなどの=以降でも補完できる
setopt magic_equal_subst

# メールスプール$MAILが読まれていたらワーニングを表示する
#setopt mail_warning

# ファイル名の展開でディレクトリにマッチした場合末尾に/を付加する
setopt mark_dirs

# 補完候補が複数ある時、一覧表示(auto_list)せず、すぐに最初の候補を補完する
#setopt menu_complete

# 複数のリダイレクトやパイプなど、必要に応じてteeやcatの機能が使われる
setopt multios

# 8ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# parameter expansion,command substitution,arithmetic expansionがプロンプトで使える
setopt prompt_subst

# 戻り値が0以外の場合終了コードを表示する
#setopt print_exit_value

# ディレクトリスタックに同じディレクトリを追加しないようになる
#setopt pushd_ignore_dups

# pushdを引数無しで実行した場合pushd $HOMEと見なされる
#setopt pushd_to_home

# rm * などの際、本当に全てのファイルを消して良いかの確認をしないようになる
setopt rm_star_silent

# rm_star_silentの逆で、10秒間反応しなくなり、頭を冷ます時間が与えられる
#setopt rm_star_wait

# for,repeat,select,if,functionなどで簡略文法が使えるようになる
setopt short_loops

# デフォルトに複数行コマンドライン編集ではなく、１行編集モードになる
#setopt single_line_zle

# 括られてないパラメータを展開する時field splittingする
#setopt sh_word_split

# リダイレクトできたファイルと同じ名前のファイルが存在する時上書きしない
#setopt noclobber
#setopt clobber                                    

# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace

# 斜線の後でスペースやリターンをタイプしたら斜線を削除
setopt autoremoveslash

##### History #####

# 複数のzshを同時に使う時historyファイルに上書きせず追加する
setopt append_history

# ヒストリにタイムスタンプと持続時間を記録する
setopt extended_history

# 連続して入力したコマンドをヒストリに追加しない
setopt hist_ignore_dups

# スペースで始まるコマンドはヒストリに追加しない
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# historyを共有
setopt share_history
setopt inc_append_history

# 余分な空白を削除してヒストリに保存する
setopt hist_reduce_blanks

