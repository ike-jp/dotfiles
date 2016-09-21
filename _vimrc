" windows vim 開発環境構築メモ(gvim + neobundle)
" http://qiita.com/hikachan/items/a189f3051dd94f551cc9
" Vim のカスタマイズ - set コマンド オススメまとめ
" http://vimblog.hatenablog.com/entry/vimrc_set_recommended_options
" 自作Vimカラースキーム「Iceberg」の配色戦略
" http://cocopon.me/blog/?p=5944
" Windows7 64bit で Vim 環境を整えてみた
" http://tips.hecomi.com/entry/20120106/1325916320
" 【Vim】gVimでneobundle環境を整える(vimproc用)
" http://www.jonki.net/entry/20140406/1396773150
" .vimrcのシンプル設定
" http://fa11enprince.hatenablog.com/entry/2014/04/05/031909

"---------------------------------------------------------------------------
" プラグインマネージャ(NeoBundle):
"
:source $VIMRUNTIME/mswin.vim
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible
	endif

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Unix環境では自動ダウンロードする
if has("unix")
	let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
	if !filereadable(neobundle_readme)
		echo "Installing NeoBundle..."
		echo ""
		silent !mkdir -p ~/.vim/bundle
		silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
		let g:not_finsh_neobundle = "yes"

		" Run shell script if exist on custom select language
	endif
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle 設定
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: neobundle の設定を.gvimrcに書かないこと！

    " --- インストールプラグイン ---
    "
    " 自動補完
    NeoBundle 'https://github.com/Shougo/neocomplete.git'
    " 自動補完(PHP)
    NeoBundle 'shawncplus/phpcomplete.vim'
    " NERDTree
    NeoBundle 'scrooloose/nerdtree'
    " 小文字エイリアスが作れるようになる
    NeoBundle 'https://github.com/tyru/vim-altercmd.git'
    " Uniteファイラ
    NeoBundle 'https://github.com/Shougo/unite.vim.git'
    " VimProc
    if has("unix")
        NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'gmake -f make_unix.mak',
            \    },
            \ }
    else
        NeoBundle 'Shougo/vimproc'
    endif
    " VimShell
    NeoBundle 'https://github.com/Shougo/vimshell.git'
    " カラースキーム
    NeoBundle 'https://github.com/cocopon/iceberg.vim'
    NeoBundle 'https://github.com/vim-scripts/Wombat.git'
    NeoBundle 'https://github.com/vim-scripts/rdark.git'
    NeoBundle 'https://github.com/jpo/vim-railscasts-theme.git'
    "NeoBundle 'https://github.com/fcpg/vim-fahrenheit.git'
    NeoBundle 'https://github.com/djjcast/mirodark.git'
    NeoBundle 'nanotech/jellybeans.vim'
    " Unite colorscheme -auto-previewでカラースキームをプレビュー
    NeoBundle 'ujihisa/unite-colorscheme'
    " コードチェッカ
    if has('gui_running')
        " Syntastic
        NeoBundle 'scrooloose/syntastic.git'
    else
        " CUIのときは軽いほうがいいのでWatchDocsを使う
    	NeoBundle "thinca/vim-quickrun"
    	NeoBundle "osyo-manga/vim-watchdogs"
    	NeoBundle "osyo-manga/shabadou.vim"
        " エラー箇所の行にカーソルが当たった時に詳細を表示する
    	NeoBundle "dannyob/quickfixstatus"
        " エラーのラインをマーク
    	NeoBundle "KazuakiM/vim-qfsigns"
    endif
    " リッチなステータスバー
    NeoBundle 'itchyny/lightline.vim'
    " 行末の半角スペースを可視化 / FixWhitespaceで行末の余計な空白を掃除できる
    NeoBundle 'bronson/vim-trailing-whitespace'
    " ミニマップを表示(Python拡張が必要)
    if has('gui_running')
        NeoBundle 'severin-lemaignan/vim-minimap'
    endif
    " アイコンをかっこ良くする
    if has('gui_running')
        NeoBundle 'istepura/vim-toolbar-icons-silk'
    endif
    " バッファ上、もしくはビジュアルモードで選択した範囲の文字列を翻訳する
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'mattn/excitetranslate-vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
 NeoBundleCheck

"---------------------------------------------------------------------------
" プラグイン設定：Neocomplete
"
if neobundle#is_installed('neocomplete')

	" NeocompleteはNeocomplcacheの後継。
	" Vim7.4以降でLua拡張がないと動かないので注意

	" 起動時からneocompleteを有効に
	let g:neocomplete#enable_at_startup = 1

	" smart_caseを使用する
	let g:neocomplete#enable_smart_case = 1

	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

endif

"---------------------------------------------------------------------------
" プラグイン設定：NERDTree
"
if neobundle#is_installed('nerdtree')

	" ファイルが指定されているときは自動的にNERDTreeを起動する。
	" そうでなければコマンドで:NERDTreeで起動。
	autocmd vimenter * if !argc() | NERDTree | endif

	" 他のバッファを全て閉じたときにNERDTreeが開いていたら一緒に閉じる
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" 隠しファイルをデフォルトで表示させる
	let NERDTreeShowHidden=1

	" ブックマークを最初から表示する
	let g:NERDTreeShowBookmarks=1

	" マウス操作方法
	let g:NERDTreeMouseMode=3

	" 表示を見やすくする
	"let g:NERDTreeMinimalUI=1

	" NERDTreeウィンドウに行番号を表示する
	"let NERDTreeShowLineNumbers=1

    let g:NERDTreeWinSize=24

endif

"---------------------------------------------------------------------------
" プラグイン設定：Syntastic
"
if neobundle#is_installed('syntastic')

	":SyntasticToggleで切り替え
    "
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

"	"--- Python用の設定 ---
	let g:syntastic_python_checkers = ['pylint']

"	"--- PHP用の設定 ---
"	let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
"	"Vimを起動したディレクトリにあるruleset.xmlを見にいく
"	let g:syntastic_php_phpcs_args = '--standard=ruleset.xml'
"	"let g:syntastic_php_phpmd_post_args = 'phpmd_ruleset.xml'

"	"ファイルを開いたときにチェックする
"	"falseだと保存したときにチェックされる
"	let g:syntastic_check_on_open = 1
	let g:syntasitc_enable_signs = 1
	let g:syntastic_ignore_files = ['\.ctp$']
"	let g:syntastic_aggregate_errors = 1
"	let g:syntastic_always_populate_loc_list = 1
"	let g:syntastic_auto_loc_list = 2
"	let g:syntastic_check_on_wq = 0
	let g:syntastic_echo_current_error = 1
	let g:syntastic_enable_highlighting = 1
	let g:syntastic_error_symbol = '?'
	let g:syntastic_warning_symbol = '!'

endif

"---------------------------------------------------------------------------
" プラグイン設定：Watchdocs
"
if neobundle#is_installed('vim-watchdogs')

	if !exists("g:quickrun_config")
		let g:quickrun_config = {}
	endif

	"#### Global

	" 書き込み後に構文チェックを行う
	let g:watchdogs_check_BufWritePost_enable = 0

	" 一定時間キー入力がなかった場合に構文チェックを行う
	let g:watchdogs_check_CursorHold_enable = 0

	" falseのとき:wq時に実行しない
	let g:watchdogs_check_BufWritePost_enable_on_wq = 0

	" vim-hierでエラー箇所がハイライトされるので:WathcdogsRun後にquickfixウィンドウを自動的に閉じる
	let g:quickrun_config['watchdogs_checker/_'] = {
		\	'outputter/quickfix/open_cmd': '',
		\	'hook/qfsigns_update/enable_exit': 1,
		\	'hook/qfsigns_update/priority_exit': 3
		\ }

	"#### PHP
	" ※ruleset.xmlはvimを開いたディレクトリにあるものが使われる
	let phpcs_command = "phpcs"
	if executable(phpcs_command)
		let error_format =
			\ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
			\ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#'

		let g:quickrun_config["watchdogs_checker/phpcs"] = {
			\ "quickfix/errorformat": error_format,
			\ "command" : phpcs_command,
			\ "cmdopt" : "--report=csv --standard=ruleset.xml",
			\ "exec" : '%c %o %s:p',
			\ }

		unlet phpcs_command
		unlet error_format

		let g:quickrun_config["php/watchdogs_checker"] = {
			\ "type" : "watchdogs_checker/phpcs",
			\ }
	endif

	" 作成した設定をWatchDogsに
	call watchdogs#setup(g:quickrun_config)

	"### Watchdogs エイリアス

	" :CSで構文チェックを行う
	command! CS WatchdogsRun

	" :CEでWatchDogsとハイライトを止める
	function! WatchdogsEnd()
		:WatchdogsRunSweep
		:QfsignsClear
	endfunction
	command! CE call WatchdogsEnd()

	"### Optional

	" If syntax error, cursor is moved at line setting sign.
	let g:qfsigns#AutoJump = 1

	" If syntax error, view split and cursor is moved at line setting sign.
	"let g:qfsigns#AutoJump = 2

endif

"---------------------------------------------------------------------------
" プラグイン設定：lightline
"
if neobundle#is_installed('lightline.vim')

	let g:lightline = {
		\ 'colorscheme': 'jellybeans',
		\ 'active': {
		\ 		'left': [
		\ 			['mode', 'paste'],
		\ 			['readonly', 'filename', 'modified'],
		\ 		],
		\		'right': [
		\			['lineinfo'],
		\			['percent'],
		\			['fileformat', 'fileencoding', 'filetype'],
		\			['kotori']
		\		]
		\ },
		\ 'component_function': {
		\		  'mode': 'MyMode',
		\ 		'kotori': 'KotoriForLightLine'
		\ }
	\ }

	"任意のプラグインが実行されている時、その名前をModeに表示する
	function! MyMode()
		return &ft == 'unite' ? 'Unite' :
			\ winwidth(0) > 60 ? lightline#mode() : ''
	endfunction

	"KotoriをLightLineで表示する
	function! KotoriForLightLine()
		if winwidth(0) > 70
			return '(･e･)'
		else
			return ''
		endif
	endfunction

endif

"---------------------------------------------------------------------------
" プラグイン設定：VimShell
"
let g:vimshell_prompt = "% "
let g:vimshell_secondary_prompt = "> "
let g:vimshell_user_prompt = 'getcwd()'

"---------------------------------------------------------------------------
" プラグイン設定：ExciteTranslate
"
" 翻訳が終わって開いたウィンドウをqで閉じられるようにする
autocmd BufEnter ==Translate==\ Excite nnoremap <buffer> <silent> q :<C-u>close<CR>

"---------------------------------------------------------------------------
" カラースキーム(CUI):
"
"正しく表示されないときは
"export TERM=xterm-256colorを.bashrcなどに記述する必要がある。
colorscheme Iceberg
"colorscheme Wombat
"colorscheme rdark
"colorscheme railscasts
"colorscheme jerrybeans
"colorscheme fahrenheit

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" インクリメンタルサーチ
set incsearch
" 検索ハイライト
set hlsearch
" ファイル末尾まで検索したら行頭へループ
"set wrapscan

" /での検索時、/や?を検索するには\/、もしくは\?と書く必要がある。
" いちいちエスケープ文字を入力するのは面倒なので自動的に\を付加する。
noremap <expr> /
	\	getcmdtype() == '/' ? '\/' : '/'

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" 文字エンコード
set encoding=UTF-8
" ファイルフォーマット(Windows=dos, MacOS=mac)
set fileformat=unix
" ファイルが変更されたら自動的に読み込む
set autoread
" タブの画面上での幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 自動インデントでずれる幅
set shiftwidth=4
" タブをスペースに展開する/ しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" unicodeで行末が変になる問題を解決
set ambiwidth=double

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" タイトルを表示する
set title
" 行番号を表示 (nonumber:非表示)
set number
" ルーラー(カーソルが何行何列目にあるか)を表示 (noruler:非表示)
set ruler
" タブや改行を表示 (nolist:非表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:\|\-,trail:~
" 長い行を折り返して表示 (wrap:折り返えす)
set nowrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" モードを表示する
set showmode
" 対応する括弧を強調表示する
set showmatch
" 行を強調表示
set cursorline
" 列を強調表示
set cursorcolumn
" ターミナルで256色表示を使う
set t_Co=256
" ターミナル接続を高速化する
set ttyfast

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" スワップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set noswapfile
" 履歴の数
set history=1000

"カラムの80列目に色をつける
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" シンタックスハイライト
syntax on

"---------------------------------------------------------------------------
" エイリアス
"
" 小文字エイリアスを有効にする
call altercmd#load()

" :NTでNERDTreeを開く
command! NT NERDTree
CAlterCommand nt NERDTree

" vimrcを読み直す
CAlterCommand rc source $MYVIMRC

" :isでVimShellを開く
if has('win32')
    CAlterCommand sh2 VimShell $HOME
endif

" trでエキサイト翻訳する
CAlterCommand tr ExciteTranslate

"---------------------------------------------------------------------------
" Python
"
" Pythonはスペース4つでインデントすることが推奨されている
" TABのインデントはスペース8個分になるので、基本はスペースでインデントする
" tabが押された場合などにTAB文字ではなく、スペースを差し込む設定
" また、スペースが4つ続いた場所でbackspaceを押した際にインデント分のスペースを削除する
" http://d.hatena.ne.jp/over80/20090305/1236264851
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

"---------------------------------------------------------------------------
" PHP
"
"プラグインを使わないPHP構文エラーチェック
augroup PHP_SyntaxCheck
    autocmd!
    "WatchDogsによる構文チェックは重い可能性があるので
    "単純なPHPのエラーチェックはphp -lで行う
    autocmd FileType php set makeprg=php\ -l\ %
    autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif | redraw!
augroup END

"---------------------------------------------------------------------------
" vimrc_localを読み込む
"
if filereadable(expand($HOME.'/.vimrc_local'))
  source $HOME/.vimrc_local
endif