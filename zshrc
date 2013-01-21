#補間
autoload -U compinit
compinit

#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload colors
colors

PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} 
[%n]$ "

PROMPT2='[%n]> ' 

#履歴
#履歴を保存するファイル指定
HISTFILE="$HOME/.zsh_history"

#履歴の件数
HISTSIZE=100000
SAVEHIST=100000

# 直前のコマンドの重複を削除する。 
setopt hist_ignore_dups 
# 重複するコマンドが記録される時、古い方を削除する。 
setopt hist_ignore_all_dups 
# 重複するコマンドが保存される時、古い方を削除する。 
setopt hist_save_no_dups 

#古い履歴を削除する必要がある場合、まず重複しているものから削除する。 
setopt hist_expire_dups_first

#履歴検索で重複しているものを表示しない。 
setopt hist_find_no_dups 


#履歴を共有する
#setopt share_history

#先頭にスペースを入れると履歴に残さない
setopt hist_ignore_space

#履歴の検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

#cdの設定
#ディレクトリ名だけで移動する。
setopt auto_cd

#自動でpushdする
setopt auto_pushd

#pushdの履歴は残さない。
setopt pushd_ignore_dups

#ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac 

#色の設定
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# リターンを押す度にスペルチェックをする。
#setopt correct
#setopt correct_all

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'

alias javac="/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/bin/javac -J-Dfile.encoding=UTF-8"
alias java="/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home/bin/java -Dfile.encoding=UTF-8"

alias ccgl="cc -framework GLUT -framework OpenGL"

#w3mでALC検索
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    w3m "http://www.alc.co.jp/"
  fi
}

#その他
#キーバインド
bindkey -e

#ビープ音ならなさない
setopt nobeep

#エディタ
export EDITOR=emacs

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# 補完侯補をEmacsのキーバインドで動き回る
zstyle ':completion:*:default' menu select=1
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm
export PATH=/usr/gcc-4.7.1/bin:$PATH
alias gcc='gcc-4.7'
alias g++='g++-4.7 -std=c++11'
alias c++='c++-4.7 -std=c++11'
#export PATH=/usr/local/Cellar/wget/1.14/bin:$PATH
alias wget='wget'
export PATH=/usr/bin:$PATH
alias gcv='g++ -I/usr/local/Cellar/opencv/2.4.2/include/opencv -L. -L/usr/local/Cellar/opencv/2.4.2/lib -lcv -lcvaux -lcxcore -lhighgui'
alias platex='/usr/local/teTex/bin/platex'
alias dvipdfmx='/usr/local/teTex/bin/dvipdfmx'
alias pdfconv='sh ~/Dropbox/zsh/pdfconv.sh'
alias ruby='ruby-1.9.3-p286'
alias gnuplot='/usr/local/Cellar/gnuplot/4.6.1/bin/gnuplot'
