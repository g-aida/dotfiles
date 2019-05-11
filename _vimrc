"
" Vim8用サンプル vimrc
"
if has('win32')					" Windows 32bit または 64bit ?
	set encoding=utf-8			" cp932 が嫌なら utf-8 にしてください
else
	set encoding=utf-8
endif
scriptencoding utf-8			" This file's encoding

" 推奨設定の読み込み (:h defaults.vim)
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

"===============================================================================
" vim-plugの設定開始（beginの引数はVimプラグインが格納されるディレクトリ）
call plug#begin('~/.vim/plugged')

" カレントディレクトリのファイル一覧を表示
Plug 'scrooloose/nerdtree'
" 複数行コメントアウト
Plug 'tomtom/tcomment_vim'
" 行末の不要な空白文字を可視化
Plug 'bronson/vim-trailing-whitespace'
" モダンでおしゃれなカラーに
Plug 'altercation/vim-colors-solarized'
" 新規ファイル作成時にテンプレートを使用
Plug 'mattn/sonictemplate-vim'
" ヴィジュアルモードで選択した文字列を検索
Plug 'thinca/vim-visualstar'
" インデントを可視化する
"Plug 'Yggdroot/indentLine'
" ステータスラインをいい感じにする
Plug 'itchyny/lightline.vim'
" インデントガイド
Plug 'nathanaelkane/vim-indent-guides'
" 複数カーソル
Plug 'terryma/vim-multiple-cursors'
" ファイルをあいまい検索
Plug 'kien/ctrlp.vim'
" HTMLタグを自動的に閉じる
Plug 'alvan/vim-closetag'
" surround関連の編集
Plug 'tpope/vim-surround'
" ソースコード中のカラーをプレビューする
Plug 'ap/vim-css-color'
" 対応するカッコに色を付ける
Plug 'luochen1990/rainbow'
" バッファ全体のテキストオブジェクトを追加する
" Plug 'kana/vim-textobj-entire'
" ランダムな時刻をINSERTする
Plug 'kebiishi/random-date'
" 補完機能拡張
" if has('nvim')
" 	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"endif
"let g:deoplete#enable_at_startup = 1

" スニペットをVimに追加
"Plug 'Shougo/neosnippet.vim'
" スニペットテンプレート
" Plug 'Shougo/neosnippet-snippets'
" vim-plugの設定終了
call plug#end()

"===============================================================================
" 設定の追加はこの行以降でおこなうこと！
" 分からないオプション名は先頭に ' を付けてhelpしましょう。例:
" :h 'helplang

packadd! vimdoc-ja					" 日本語help の読み込み
set helplang=ja,en					" help言語の設定

set whichwrap=b,s,h,l,<,>,[,],~		" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number							" 行番号を表示
set cursorline						" カーソルラインをハイライト
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

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

set relativenumber					" 相対行を表示
nnoremap <F3> :<C-u>setlocal relativenumber!<CR> :<C-u>setlocal number<CR>

" F1（ヘルプ）キーを無効に
noremap <F1> <Nop>

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
" 常にカーソル位置が画面の中心に来るように移動
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
noremap <down> gj
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

" Vim設定ファイルを開く
nnoremap <Space>. :<C-u>tabnew ~/_vimrc<CR>

" <C-p>、<C-n>でもコマンド履歴のフィルタリングをする
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" アクティブなファイルが含まれているディレクトリを手早く展開
cnoremap <expr> %% (getcmdtype() == ':') ? expand('%:h').'/' : '%%'

" カーソル下の単語をハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>
" カーソル下の単語をハイライトしてから置換する
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

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
"let &grepprg="grep -rnIH --exclude=.git --exclude-dir=.hg --exclude-dir=.svn --exclude=tags"
set showmatch						" 括弧の対応関係を一瞬表示する
"let loaded_matchparen = 1			" カーソルが括弧上にあっても括弧ペアをハイライトさせない

set backspace=indent,eol,start		" バックスペースキーの有効化
set wildmenu						" コマンドモードの補完
set history=1000					" 保存するコマンド履歴の数

set clipboard=unnamed,autoselect	" ヤンクしたテキストをクリップボードにコピー
set backupdir=~/vimfiles/tmp		" バックアップファイルの出力先を変更する
set undodir=~/vimfiles/tmp/undo		" undoファイルの出力先を変更する

set belloff=all						"ビープ音を消去

" hi SpecialKey guibg=#808080
" set list listchars=tab:\|\ 

" :grep 等でquickfixウィンドウを開く (:lgrep 等でlocationlistウィンドウを開く)
"augroup qf_win
"  autocmd!
"  autocmd QuickfixCmdPost [^l]* copen
"  autocmd QuickfixCmdPost l* lopen
"augroup END

" マウスの中央ボタンクリックによるクリップボードペースト動作を抑制する
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap! <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap! <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
noremap! <4-MiddleMouse> <Nop>

"-------------------------------------------------------------------------------
" ステータスライン設定
let &statusline = "%<%f %m%r%h%w[%{&ff}][%{(&fenc!=''?&fenc:&enc).(&bomb?':bom':'')}] "
if has('iconv')
	let &statusline .= "0x%{FencB()}"

	function! FencB()
	let c = matchstr(getline('.'), '.', col('.') - 1)
		if c != ''
			let c = iconv(c, &enc, &fenc)
			return s:Byte2hex(s:Str2byte(c))
		else
			return '0'
		endif
	endfunction
	function! s:Str2byte(str)
		return map(range(len(a:str)), 'char2nr(a:str[v:val])')
	endfunction
	function! s:Byte2hex(bytes)
		return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
	endfunction
else
	let &statusline .= "0x%B"
endif
let &statusline .= "%=%l,%c%V %P"

"-------------------------------------------------------------------------------
" ファイルエンコーディング検出設定
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" if has('iconv')
" 	if &encoding ==# 'utf-8'
" 		let &fileencodings = 'iso-2022-jp,euc-jp,cp932,' . &fileencodings
" 	else
" 		let &fileencodings .= 'utf-8,iso-2022-jp,ucs-2le,ucs-2,euc-jp'
" 	endif
" endif
" 日本語を含まないファイルのエンコーディングは encoding と同じにする
" if has('autocmd')
" 	function! AU_ReSetting_Fenc()
" 		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
" 			let &fileencoding = &encoding
" 		endif
" 	endfunction
" 	augroup resetting_fenc
" 		autocmd!
" 		autocmd BufReadPost * call AU_ReSetting_Fenc()
" 	augroup END
" endif

"-------------------------------------------------------------------------------
" カラースキームの設定
colorscheme torte

try
	silent hi CursorIM
catch /E411/
	" CursorIM (IME ON中のカーソル色)が定義されていなければ、紫に設定
	hi CursorIM ctermfg=16 ctermbg=127 guifg=#000000 guibg=#af00af
endtry

" vim:set et ts=2 sw=0:

"-------------------------------------------------------------------------------
" mattn/sonictemplate-vim の設定
let g:sonictemplate_vim_template_dir = [
	\ '~/GitHub/template',
	\ ]

"-------------------------------------------------------------------------------
" itchyny/lightline.vim の設定
"
let g:lightline = {
		\ 'colorscheme': 'solarized',
	\ 'mode_map': {'c': 'NORMAL'},
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
	\ },
	\ 'component_function': {
	\   'modified': 'LightlineModified',
	\   'readonly': 'LightlineReadonly',
	\   'fugitive': 'LightlineFugitive',
	\   'filename': 'LightlineFilename',
	\   'fileformat': 'LightlineFileformat',
	\   'filetype': 'LightlineFiletype',
	\   'fileencoding': 'LightlineFileencoding',
	\   'mode': 'LightlineMode'
	\	}
	\ }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
		\  &ft == 'unite' ? unite#get_status_string() :
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
		\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		return fugitive#head()
	else
		return ''
	endif
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"-------------------------------------------------------------------------------
" Shougo/snippet-snippets の設定
" 自作スニペットを置くフォルダ指定
let g:neosnippet#snippets_directory='~/vimfiles/my_snippets/'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"-------------------------------------------------------------------------------
" nathanaelkane/vim-indent-guides の設定
let g:indent_guides_enable_on_vim_startup = 1

"-------------------------------------------------------------------------------
" ctrlp/.vim の設定
" キャッシュディレクトリ
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" キャッシュを終了時に削除しない
let g:ctrlp_clear_cache_on_exit = 0
" 遅延再描画
let g:ctrlp_lazy_update = 1
" ルートパスと認識させるためのファイル
" let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']
" CtrlPのウィンドウ最大高さ
let g:ctrlp_max_height = 20
" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"-------------------------------------------------------------------------------
" scrooloose/nerdtree の設定
" <C-e>でツリーを開く
nnoremap <silent><C-e> :<C-u>NERDTreeToggle<CR>
" ブックマークを初期表示
let g:NERDTreeShowBookmarks=1

" Vimを起動したときに自動でNERDTreeを表示
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" ディレクトリ表示記号を変更する
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

"-------------------------------------------------------------------------------
" alvan/vim-closetag の設定
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'xml,html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

"-------------------------------------------------------------------------------
" luochen1990/rainbow の設定
let g:rainbow_conf = {
    \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \	'operators': '_,_',
    \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \	'separately': {
    \		'*': {},
    \		'tex': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \		},
    \		'lisp': {
    \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \		},
    \		'vim': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \		},
    \		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \		},
    \		'css': 0,
    \	}
    \}
