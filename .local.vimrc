" 設定ファイルのあるディレクトリへ移動する。
lcd <sfile>:h

" ctrlpの探索ルートパスを指定する。
let ctrlpRootPath = 'C:\ESP'
exec 'nnoremap <silent> <C-p> :<C-u>CtrlP ' . ctrlpRootPath . '<CR>'

" pathの設定
setlocal path+=

" タブ周りの設定
" setlocal tabstop=4
" 挿入モードで<Tab>を挿入するとき、代わりに適切な数の空白を使う。
" setlocal noexpandtab
