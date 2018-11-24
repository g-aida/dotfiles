"
" Vim8�p�T���v�� vimrc
"
if has('win32')					" Windows 32bit �܂��� 64bit ?
	set encoding=utf-8			" cp932 �����Ȃ� utf-8 �ɂ��Ă�������
else
	set encoding=utf-8
endif
scriptencoding utf-8			" This file's encoding

" �����ݒ�̓ǂݍ��� (:h defaults.vim)
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

"===============================================================================
" vim-plug�̐ݒ�J�n�ibegin�̈�����Vim�v���O�C�����i�[�����f�B���N�g���j
call plug#begin('~/.vim/plugged')

" �J�����g�f�B���N�g���̃t�@�C���ꗗ��\��
Plug 'scrooloose/nerdtree'
" �����s�R�����g�A�E�g
Plug 'tomtom/tcomment_vim'
" �s���̕s�v�ȋ󔒕���������
Plug 'bronson/vim-trailing-whitespace'
" ���_���ł������ȃJ���[��
Plug 'altercation/vim-colors-solarized'
" �V�K�t�@�C���쐬���Ƀe���v���[�g���g�p
Plug 'mattn/sonictemplate-vim'
" ���B�W���A�����[�h�őI�����������������
Plug 'thinca/vim-visualstar'
" �C���f���g����������
"Plug 'Yggdroot/indentLine'
" �X�e�[�^�X���C�������������ɂ���
Plug 'itchyny/lightline.vim'
" vim-plug�̐ݒ�I��
call plug#end()

"===============================================================================
" �ݒ�̒ǉ��͂��̍s�ȍ~�ł����Ȃ����ƁI
" ������Ȃ��I�v�V�������͐擪�� ' ��t����help���܂��傤�B��:
" :h 'helplang

packadd! vimdoc-ja					" ���{��help �̓ǂݍ���
set helplang=ja,en					" help����̐ݒ�

set whichwrap=b,s,h,l,<,>,[,],~		" �J�[�\���̍��E�ړ��ōs�����玟�̍s�̍s���ւ̈ړ����\�ɂȂ�
set number							" �s�ԍ���\��
set cursorline						" �J�[�\�����C�����n�C���C�g
" ESC�L�[2�x�����Ńn�C���C�g�̐؂�ւ�
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

set scrolloff=999					" �J�[�\���s����ɉ�ʒ����ɕ\��
set tabstop=4						" ��ʏ�Ń^�u��������߂镝
set softtabstop=4					" �A�������󔒂ɑ΂��ă^�u�L�[��o�b�N�X�y�[�X�L�[�ŃJ�[�\����������
set autoindent						" ���s���ɑO�̍s�̃C���f���g���p������
set smartindent						" ���s���ɑO�̍s�̍\�����`�F�b�N�����̍s�̃C���f���g�𑝌�����
set shiftwidth=4					" smartindent�ő������镝

set incsearch						" �C���N�������^���T�[�`. �P�������͖��Ɍ������s��
set ignorecase						" �����p�^�[���ɑ啶������������ʂ��Ȃ�
set smartcase						" �����p�^�[���ɑ啶�����܂�ł�����啶������������ʂ���
set hlsearch						" �������ʂ��n�C���C�g

" �s���܂�Ԃ��\������Ă����ꍇ�A�s�P�ʂł͂Ȃ��\���s�P�ʂŃJ�[�\�����ړ�����
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set laststatus=2					" ��ɃX�e�[�^�X�s��\������
set cmdheight=2						" hit-enter�񐔂����炷�̂��ړI
if !has('gui_running')				" gvim�ł͂Ȃ��H (== �[��)
	set mouse=						" �}�E�X���� (macOS���͕s�ւ����H)
	set ttimeoutlen=0					" ���[�h�ύX���̕\���X�V���ő���
	if $COLORTERM == "truecolor"		" True Color�Ή��[���H
		set termguicolors
	endif
endif
set nofixendofline					" Windows�̃G�f�B�^�̐l�B�Ɍ����Ȃ��ݒ�
set ambiwidth=double				" ��, ��, �����̕�������ASCII�����̔{�ɂ���
set directory-=.					" swap�t�@�C���̓��[�J���쐬���g���u�����Ȃ�
set formatoptions+=mM				" ���{��̓r���ł��܂�Ԃ�
"let &grepprg="grep -rnIH --exclude=.git --exclude-dir=.hg --exclude-dir=.svn --exclude=tags"
set showmatch						" ���ʂ̑Ή��֌W����u�\������
"let loaded_matchparen = 1			" �J�[�\�������ʏ�ɂ����Ă����ʃy�A���n�C���C�g�����Ȃ�

set backspace=indent,eol,start		" �o�b�N�X�y�[�X�L�[�̗L����
set wildmenu						" �R�}���h���[�h�̕⊮
set history=1000					" �ۑ�����R�}���h�����̐�

set clipboard=unnamed,autoselect	" �����N�����e�L�X�g���N���b�v�{�[�h�ɃR�s�[
set backupdir=~/vimfiles/tmp		" �o�b�N�A�b�v�t�@�C���̏o�͐��ύX����
set undodir=~/vimfiles/tmp/undo		" undo�t�@�C���̏o�͐��ύX����

hi SpecialKey guibg=#808080
set list listchars=tab:\|\ 

" :grep ����quickfix�E�B���h�E���J�� (:lgrep ����locationlist�E�B���h�E���J��)
"augroup qf_win
"  autocmd!
"  autocmd QuickfixCmdPost [^l]* copen
"  autocmd QuickfixCmdPost l* lopen
"augroup END

" �}�E�X�̒����{�^���N���b�N�ɂ��N���b�v�{�[�h�y�[�X�g�����}������
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap! <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap! <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
noremap! <4-MiddleMouse> <Nop>

"-------------------------------------------------------------------------------
" �X�e�[�^�X���C���ݒ�
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
" �t�@�C���G���R�[�f�B���O���o�ݒ�
let &fileencoding = &encoding
if has('iconv')
	if &encoding ==# 'utf-8'
		let &fileencodings = 'iso-2022-jp,euc-jp,cp932,' . &fileencodings
	else
		let &fileencodings .= ',iso-2022-jp,utf-8,ucs-2le,ucs-2,euc-jp'
	endif
endif
" ���{����܂܂Ȃ��t�@�C���̃G���R�[�f�B���O�� encoding �Ɠ����ɂ���
if has('autocmd')
	function! AU_ReSetting_Fenc()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding = &encoding
		endif
	endfunction
	augroup resetting_fenc
		autocmd!
		autocmd BufReadPost * call AU_ReSetting_Fenc()
	augroup END
endif

"-------------------------------------------------------------------------------
" �J���[�X�L�[���̐ݒ�
colorscheme torte

try
	silent hi CursorIM
catch /E411/
	" CursorIM (IME ON���̃J�[�\���F)����`����Ă��Ȃ���΁A���ɐݒ�
	hi CursorIM ctermfg=16 ctermbg=127 guifg=#000000 guibg=#af00af
endtry

" vim:set et ts=2 sw=0:

"-------------------------------------------------------------------------------
" mattn/sonictemplate-vim �̐ݒ�
let g:sonictemplate_vim_template_dir = [
	\ '~/GitHub/template',
	\ ]

"-------------------------------------------------------------------------------
" itchyny/lightline.vim �̐ݒ�
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
