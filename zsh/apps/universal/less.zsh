#: - [Qiita - あなたの知らない less の世界](http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9)
#: - [Qiita - lessコマンドを少し便利にしておく](http://qiita.com/hatchinee/items/586fb1c4915e2bb5c03b)
#: - [Qiita - catやlessをシンタックスハイライト+行番号表示してコードを見やすくする](http://qiita.com/zaru/items/4a7811ac21f74a13481c)

export LESS=-Ix4MR
export LESSCHARSET="utf-8"

if type pygmentize > /dev/null 2>&1; then
    export LESSCOLORIZER="$(which pygmentize)"
fi

if type lesspipe.sh > /dev/null 2>&1; then
    ## macOS + brew
    export LESS_ADVANCED_PREPROCESSOR=1
	export LESSOPEN="| lesspipe.sh %s 2>&-"
    if type src-hilite-lesspipe.sh > /dev/null 2>&1; then
        ## required: `brew install source-highlight` (dependency for boost)
        LESSOPEN="| lesspipe.sh | src-hilite-lesspipe.sh %s 2>&-"
    fi
    if type pygmentize > /dev/null 2>&1; then
        ## required: `sudo easy_install Pygments`
        LESSOPEN="| lesspipe.sh | pygmentize -g -O style=native -f terminal256 %s"
    fi
elif [[ -x /usr/bin/lesspipe ]]; then
    ## ubuntu
    eval "$(SHELL=/bin/sh lesspipe)"
    if [[ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
        ## required: `sudo apt-get install source-highlight`
        export LESSOPEN="| /usr/bin/lesspipe | /usr/share/source-highlight/src-hilite-lesspipe.sh %s 2>&-"
    fi
fi

if type jless > /dev/null 2>&1; then
	[ -z ${LANG} ] && export JLESSCHARSET="utf-8"
	export JLESS=${LESS}
fi

