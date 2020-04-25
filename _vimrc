"
" Vim8用サンプル vimrc
"
if has('win32' || 'win64')		" Windows 32bit または 64bit
	set encoding=utf-8			" cp932 が嫌なら utf-8 にしてください
else
	set encoding=utf-8
endif
scriptencoding utf-8			" This file's encoding

" 推奨設定の読み込み (:h defaults.vim)
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" GitBashから起動される場合もあるので、明示的にコマンドプロンプトを指定
if has('win64')
	set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
	set shellcmdflag=/c
endif

" filetypeの設定
filetype plugin on

" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
" let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
let g:deoplete#enable_at_startup = 1
"===============================================================================
" Vim同梱のプラグインを使用

" %コマンドで対となるキーワードの組の間を移動できるように
runtime macros/matchit.vim
" 対応するペアの設定
let b:match_words="<if>:<endif>,
		\	"

" project.vim
" ファイルが選択されたら、ウィンドウを閉じる
let g:proj_flags = "imstc"
" プロジェクトをトグルで開閉する
nmap <silent> <Leader>P <Plug>ToggleProject
" デフォルトのプロジェクトを開く
nmap <silent> <Leader>p :Project<CR>
" フォールディングを展開した状態で、プロジェクトを開く
autocmd BufAdd .vimprojects silent! %foldopen!

"===============================================================================
" dein.vimの設定開始
if &compatible
	set nocompatible
endif

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand($HOME . '/.cache/dein')
" dein.vim本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければgithubから落としてくる
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" プラグインリストを収めた TOML ファイル
	let s:toml_dir  = expand($HOME . '/AppData/Local/nvim/dein/toml')
	let s:toml      = s:toml_dir . '/dein.toml'
	let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

" 未インストールプラグインがあれば起動時にインストールする
if dein#check_install()
	call dein#install()
endif

"===============================================================================
" 設定の追加はこの行以降でおこなうこと！
" 分からないオプション名は先頭に ' を付けてhelpしましょう。例:
" :h 'helplang

" 開いたファイルに合わせてカレントディレクトリを変更
augroup grlcd
	autocmd!
	" Vim起動時はとりあえずホームディレクトリに移動
	autocmd VimEnter cd ~
	" 編集ファイルディレクトリに変更
  autocmd BufEnter * if &buftype!=# 'terminal' | lcd %:p:h | endif
	" 上位階層に.local.vimrcがあればそれをloadしてディレクトリを変更
	autocmd VimEnter,BufEnter,BufNewFile,BufReadPost *
				\	call localrc#load(g:localrc_filename)
augroup END

packadd! vimdoc-ja					" 日本語help の読み込み
set helplang=en,ja					" help言語の設定

set whichwrap=b,s,h,l,<,>,[,],~		" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number							" 行番号を表示
set cursorline						" カーソルラインをハイライト

set scrolloff=999					" カーソル行が常に画面中央に表示
" set scrolloff=0						" defaults.vimで5が指定されているため
set tabstop=4						" 画面上でタブ文字が占める幅
set softtabstop=4					" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent						" 改行時に前の行のインデントを継続する

set smartindent						" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4					" smartindentで増減する幅

set incsearch						" インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase						" 検索パターンに大文字小文字を区別しない
set smartcase						" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch						" 検索結果をハイライト

set laststatus=2					" 常にステータス行を表示する
set cmdheight=2						" hit-enter回数を減らすのが目的
if !has('gui_running')				" gvimではない？ (== 端末)
	set mouse=						" マウス無効 (macOS時は不便かも？)
	set ttimeoutlen=0					" モード変更時の表示更新を最速化
	if $COLORTERM == "truecolor"		" True Color対応端末？
		set termguicolors
	endif
endif
set nofixendofline					" Windowsのエディタの人達に嫌われない設定
set ambiwidth=double				" ○, △, □等の文字幅をASCII文字の倍にする
set directory-=.					" swapファイルはローカル作成がトラブル少なめ
set formatoptions+=mM				" 日本語の途中でも折り返す
set nrformats=						" すべての数字を10進数として扱う
set showmatch						" 括弧の対応関係を一瞬表示する
"let loaded_matchparen = 1			" カーソルが括弧上にあっても括弧ペアをハイライトさせない

set backspace=indent,eol,start		" バックスペースキーの有効化
set wildmenu						" コマンドモードの補完
set history=1000					" 保存するコマンド履歴の数

set clipboard=unnamed,autoselect	" ヤンクしたテキストをクリップボードにコピー
set backupdir=~/vimfiles/tmp		" バックアップファイルの出力先を変更する
set undodir=~/vimfiles/tmp/undo		" undoファイルの出力先を変更する

set noshowmode						" 最終行に現在のモードを表示しない

set belloff=all						" ビープ音を消去

set hidden							" 保存しなくてもバッファ切り替え可能

" Windows用の日本語入力固定モードの設定
" 挿入モード終了時にIME状態を保存しない
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>
" fコマンドでのIMEをOFFにする
let g:IMState=0
autocmd InsertEnter * let &iminsert = g:IMState
autocmd InsertLeave * let g:IMState = &iminsert | set iminsert=0 imsearch=0

" ESCキー2度押しでハイライト削除（/レジスタを削除）
nnoremap <silent><Esc><Esc> :<C-u>let @/ = ''<CR>

" ファイルを保存するたびにctagsを自動的に実行する
" augroup writeCtags
" 	autocmd!
" 	autocmd BufWritePost * call system("ctags -R")
" augroup END

" grepコマンドで実行される外部コマンドを指定
let &grepprg="grep -rnIH --exclude=.git --exclude-dir=.hg --exclude-dir=.svn --exclude=tags"

" :grep 等でquickfixウィンドウを開く (:lgrep 等でlocationlistウィンドウを開く)
" vimgrep, grep, lgrepそれぞれに対応
augroup grepopen
	autocmd!
	autocmd QuickfixCmdPost vimgrep cwindow
	autocmd QuickfixCmdPost [^l]* copen
	autocmd QuickfixCmdPost l* lopen
augroup END

" 不可視文字を可視化する
set list listchars=tab:\|\ ,trail:_
" 全角スペースをハイライトする設定
augroup highlightIdegraphicSpace
	autocmd!
	autocmd ColorScheme * highlight IdeographicSpace term = underline ctermbg = DarkGreen guibg = DarkGreen
	autocmd VimEnter, WinEnter * match IdeographicSpace /　/
augroup END
" デフォルトでは可視化しない
set nolist

set relativenumber					" 相対行を表示
nnoremap <F3> :<C-u>setlocal relativenumber!<CR> :<C-u>setlocal number<CR>

" 補完ポップアップの設定
set completeopt=menuone,noinsert

" F1（ヘルプ）キーを無効に
noremap <F1> <Nop>
inoremap <F1> <Nop>

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
" 常にカーソル位置が画面の中心に来るように移動
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g^ ^
nnoremap g$ $
nnoremap <down> gj
nnoremap <up> gk

" nnoremap j gjzz
" nnoremap k gkzz
" nnoremap gj gjzz
" nnoremap gk gkzz
" nnoremap gg ggzz
" nnoremap G Gzz
" nnoremap <C-f> <C-f><C-d>zz
" nnoremap <C-b> <C-b><C-u>zz
" nnoremap <C-d> <C-d>zz
" nnoremap <C-u> <C-u>zz
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap <down> gjzz
" nnoremap <up> gkzz

" 挿入モードでカーソル移動
" inoremap <C-p> <Up>
" inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 12<Enter>を押して12行目に移動する
" nnoremap <CR> G

" ヤンク後にヤンク領域の下部に移動
vnoremap <silent> y y']

" キーワードに複数のマッチがある場合に、どこにジャンプするかを指定する
nnoremap <C-]> g<C-]>

" Vim設定ファイルを開く
nnoremap <Space>. :<C-u>tabnew ~/_vimrc<CR>

" <C-p>、<C-n>でもコマンド履歴のフィルタリングをする
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


augroup helpOpen
	autocmd!
	" ヘルプウィンドウを閉じる
	autocmd FileType help nnoremap <buffer> q <C-w>c
augroup END

" バッファリストのファイル移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" 引数リストのファイル移動
nnoremap <silent> [a :prev<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" Quickfixのファイル移動
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" タグリストのファイル移動
nnoremap <silent> [t :tprev<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

" タグファイルを再構築する
nnoremap <F5> :!ctags -R<CR>

" アクティブなファイルが含まれているディレクトリを手早くフルパスに展開
cnoremap <expr> %% (getcmdtype() == ':') ? expand('%:p:h').'/' : '%%'

" カーソル下の単語をハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>
" カーソル下の単語をハイライトしてから置換する
" nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

" 上下に空行を挿入する
imap <S-CR> <End><CR>
imap <C-S-CR> <Up><End><CR>
nnoremap <S-CR> mzo<Esc>`z
nnoremap <S-C-CR> mzO<Esc>`z

" 行ごとグリグリと移動
nnoremap <C-Down> "zddl"zp
nnoremap <C-Up> "zddk"zP
vnoremap <C-Down> "zdl"zp`[V`]
vnoremap <C-Up> "zdk"zP`[V`]

" タイポを修正
inoremap <C-t> <Esc>h"zx"zpa

" 挿入モードでのDelete
inoremap <C-d> <Del>

" xやsではヤンクしない
nnoremap x "_x
nnoremap s "_s

" クリップボードの値をヤンクレジスタにも反映する
augroup SysRegToYankReg
	autocmd!
	" ヘルプウィンドウを閉じる
	autocmd FocusGained * let @0 = getreg('*')
augroup END

" Tab補完
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" hi SpecialKey guibg=#808080

" マウスの中央ボタンクリックによるクリップボードペースト動作を抑制する
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap! <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap! <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
noremap! <4-MiddleMouse> <Nop>

"------------------------------------------------
" ":terminal 設定
" " Insertモード時のprefix
set termwinkey=<C-g>
"
" Insertモードから抜ける
tnoremap <C-[> <C-g><S-n>

" ターミナルウィンドウにfiletypeを設定する
function! s:bufnew()
  if &buftype == 'terminal' && &filetype == ''
    set filetype=terminal
  endif
endfunction

" :terminal実行直後に実行されるCB
function! s:filetype()
endfunction

augroup my-terminal
  autocmd!
  autocmd BufEnter * call timer_start(0, { -> s:bufnew() })
  autocmd FileType terminal call s:filetype()
augroup END

" popup windowでターミナルを開く
command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })

"------------------------------------------------
" vp doesn't replace paste buffer
function! RestoreRegister()
	let @" = s:restore_reg
	return ''
endfunction
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" -----------------------------------------------
" カーソル移動が遅いときにprofileして原因を調べる。
" 使い方）
"	vim +'call ProfileCursorMove()' <カーソルを動かすのが重いファイル>
function! ProfileCursorMove() abort
	let profile_file = expand('~/.cache/profile/log/vim-profile.log')
	if filereadable(profile_file)
		call delete(profile_file)
	endif

	normal! gg
	normal! zR

	execute 'profile start ' . profile_file
	profile func *
	profile file *

	augroup ProfileCursorMove
		autocmd!
		autocmd CursorHold <buffer> profile pause | q
	augroup END

	for i in range(100)
		call feedkeys('j')
	endfor
endfunction

" -----------------------------------------------
"  TODO
"  dein_lazy.tomlが読み込めるようになったら削除




" -----------------------------------------------
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
