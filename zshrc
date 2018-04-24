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
[%n@${HOST}]$ "

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

# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"
