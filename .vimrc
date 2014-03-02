" The mapleader has to be set before vundle starts loading all the plugins.
let mapleader=";"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" NeoBundleInitialisation {{{
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#rc(expand('~/.vim/bundle/'))

    " Let NeoBundle manage NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimproc', {
          \ 'build' : {
          \     'windows' : 'make -f make_mingw32.mak',
          \     'cygwin' : 'make -f make_cygwin.mak',
          \     'mac' : 'make -f make_mac.mak',
          \     'unix' : 'make -f make_unix.mak',
          \    },
          \ }

    " Syntax
    NeoBundle 'itchyny/landscape.vim'
"}}}

" Tabs & indenting {{{
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set softtabstop=4
    set shiftwidth=4

    au FileType python,ruby setl sw=2 sts=2 et
    au FileType javascript,css,less,sass,scss setl sw=2 sts=2 et
    au FileType php,phtml,html setl sw=4 sts=4 et

    filetype plugin indent on
    filetype plugin on
" }}}

" Colourscheme {{{
    syntax on
    syntax sync fromstart
    colorscheme landscape

    hi LineNr ctermbg=016
    hi MatchParen term=reverse ctermfg=027

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux'
        set t_Co=16
    endif
" }}}

" NeoBundle {{{

    " Visual
    NeoBundle 'vim-scripts/jumphl.vim', "{{{
        autocmd VimEnter * DoJumpHl " Highlight line after jump
    "}}}
    NeoBundle 'ivyl/vim-bling'
    NeoBundle 'kana/vim-narrow'
    NeoBundle 'Yggdroot/indentLine', "{{{
        let g:indentLine_color_term = 235
        let g:indentLine_char = '┊'
        nnoremap <space>i :IndentLinesToggle<CR>
    "}}}
    NeoBundle 'qstrahl/vim-matchmaker', "{{{
        let g:matchmaker_enable_startup = 0
        nnoremap <space>m :MatchmakerToggle<CR>
    "}}}

    " Indenting
    NeoBundle 'pangloss/vim-javascript'

    " Syntax
    NeoBundle 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}, "{{{
        au BufNewFile,BufRead *.less setf less
    "}}}
    NeoBundle 'rkitover/vimpager'
    NeoBundle 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
    NeoBundle 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}, "{{{
        let g:cssColorVimDoNotMessMyUpdatetime = 1
    "}}}
    NeoBundle 'othree/html5.vim', {'autoload':{'filetypes':['html', 'jinja2', 'phtml']}}
    NeoBundle 'dbakker/vim-md-noerror'
    NeoBundle 'zaiste/tmux.vim'
    NeoBundle 'evanmiller/nginx-vim-syntax'
    NeoBundle 'maksimr/vim-jsbeautify', {'autoload':{'filetypes':['javascript']}} "{{{
        nnoremap <leader>fjs :call JsBeautify()<cr>
    "}}}
    NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript', 'json']}}
    NeoBundle 'lukaszb/vim-web-indent'
    NeoBundle 'tikhomirov/vim-glsl'
        autocmd BufNewFile,BufRead *.vp,*.fp,*.gp,*.vs,*.fs,*.gs,*.tcs,*.tes,*.cs,*.vert,*.frag,*.geom,*.tess,*.shd,*.gls,*.glsl set ft=glsl
    " Images
    NeoBundle 'tpope/vim-afterimage'

    " Preview
    NeoBundle 'greyblake/vim-preview'

    " Completion
    NeoBundle 'marijnh/tern_for_vim', {
      \ 'build' : {
      \     'mac' : 'npm install --update',
      \     'unix' : 'npm install --update',
      \    },
      \ }, "{{{
        let g:tern_show_argument_hints = 1
    " }}}
    NeoBundle 'shawncplus/phpcomplete.vim'
    NeoBundle 'Shougo/context_filetype.vim'
    NeoBundle 'Shougo/neocomplete.vim', "{{{
        " brew install vim --with-python --with-ruby --with-perl --with-lua --with-tcl
        set completeopt-=preview

        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 0
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
        let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()

        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()
        inoremap <expr><C-Space> neocomplete#start_manual_complete('omni')

        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

        autocmd FileType javascript setlocal omnifunc=tern#Complete

        autocmd FileType coffee setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " }}}

    " Documentation
    NeoBundle 'heavenshell/vim-jsdoc', "{{{
        let g:jsdoc_allow_input_prompt = 1
        let g:jsdoc_default_mapping = 0
        let g:jsdoc_input_description = 1
        let g:jsdoc_allow_input_prompt = 1
        nmap <C-y>j :JsDoc<CR>
    "}}}

    " Usability
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'matze/vim-move', "{{{
        " <C-k>   Move current line/selections up
        " <C-j>   Move current line/selections down
        let g:move_key_modifier = 'C'
    "}}}
    NeoBundle 'dbakker/vim-paragraph-motion'
    NeoBundle 'justinmk/vim-sneak', " {{{
        nmap , <Plug>SneakNext
        nmap \ <Plug>SneakPrevious
    "}}}
    NeoBundle 'prendradjaja/vim-vertigo', "{{{
        nnoremap <silent> <Space>j :<C-U>VertigoDown n<CR>
        xnoremap <silent> <Space>j :<C-U>VertigoDown v<CR>
        onoremap <silent> <Space>j :<C-U>VertigoDown o<CR>
        nnoremap <silent> <Space>k :<C-U>VertigoUp n<CR>
        xnoremap <silent> <Space>k :<C-U>VertigoUp v<CR>
        onoremap <silent> <Space>k :<C-U>VertigoUp o<CR>
    "}}}
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'tpope/vim-speeddating'
    NeoBundle 'AndrewRadev/splitjoin.vim', "{{{
        nmap gS :SplitjoinSplit<cr>
        nmap gJ :SplitjoinJoin<cr>
    " }}}
    NeoBundle 'inkarkat/closetag.vim'

    " Features
    NeoBundle 'mhinz/vim-startify', "{{{
        let g:startify_show_sessions = 1
        let g:startify_list_order = ['sessions', 'bookmarks', 'dir', 'files']
        let g:startify_session_dir = expand('~/.vim/.cache/unite/session')
        let g:startify_change_to_dir = 1

        autocmd FileType startify setlocal nocursorline
        autocmd VimEnter *
                \ if !argc() |
                \   Startify |
                \   execute "normal \<c-w>w" |
                \ endif

        hi StartifyBracket ctermfg=100
        hi StartifyNumber  ctermfg=215
        hi StartifyPath    ctermfg=245
        hi StartifySlash   ctermfg=240
    " }}}
    NeoBundle 'bling/vim-airline', "{{{
        set laststatus=2
        let g:airline_theme = "dark"
        let g:airline_powerline_fonts = 1
    " }}}
    NeoBundle 'scrooloose/syntastic', "{{{
        " Show / hide location list
        noremap <silent><leader>lc :lcl<CR>
        noremap <silent><leader>lo :lw<CR>

        noremap <F6> :SyntasticCheck<CR>

        let g:syntastic_mode_map = { 'mode': 'active',
                                    \ 'active_filetypes': ['javascript', 'php'],
                                    \ 'passive_filetypes': ['css', 'html', 'xhtml', 'scss', 'sass'] }

        let g:syntastic_check_on_open = 1
        let g:syntastic_enable_signs = 1
        let g:syntastic_auto_jump = 1
        let g:syntastic_php_checkers=['php']

        let g:syntastic_javascript_checkers=['jshint']

        let g:syntastic_css_checkers=['csslint']
        let g:syntastic_auto_loc_list = 0
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_enable_highlighting = 1
        let g:syntastic_echo_current_error  = 1
    "}}}
    NeoBundle 'Shougo/unite-outline', "{{{
        nnoremap <space>o :Unite outline<CR>
    "}}}
    NeoBundle 'Shougo/unite-session'
    NeoBundle 'Shougo/unite.vim', "{{{
        let g:unite_data_directory = expand('~/.vim/.cache/unite')
        let g:unite_enable_start_insert=0
        let g:unite_source_rec_max_cache_files=5000
        let g:unite_prompt='» '

        " CTRL-P
        nnoremap <space>p :Unite -start-insert file_rec/async<cr>
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        call unite#set_profile('files', 'smartcase', 1)

        " Searching - brew install the_silver_searcher
        let g:unite_source_grep_command='ag'
        let g:unite_source_grep_default_opts='--nogroup --nocolor --column'
        nnoremap <space>/ :<C-u>Unite -buffer-name=search grep:.<cr>

        " Buffers
        nnoremap <space>b :Unite -quick-match -buffer-name=buffers buffer<cr>

        " Session
        let g:unite_source_session_enable_auto_save = 1
        nnoremap <F4> :<C-u>UniteSessionSave<space>
        noremap <space>s :Unite -quick-match -buffer-name=sessions session<CR>

        " Yank
        let g:unite_source_history_yank_enable = 1
        nnoremap <space>y :Unite -quick-match history/yank<cr>

        " Custom mappings for the unite buffer
        autocmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            " Enable navigation with control-j and control-k in insert mode
            imap <buffer> <C-j>   <Plug>(unite_select_next_line)
            imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
        endfunction

    " }}}
    NeoBundle 'sjl/gundo.vim', "{{{
        nnoremap <F5> :GundoToggle<CR>
        let g:gundo_width = 60
        let g:gundo_preview_height = 20
        let g:gundo_right = 1
        let g:gundo_close_on_revert = 1
    " }}}
    NeoBundle 'terryma/vim-expand-region'
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'hlissner/vim-multiedit'

    " Utility
    NeoBundle 'tpope/vim-unimpaired'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-eunuch'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-abolish'
    NeoBundle 'vim-scripts/bufkill.vim', "{{{
        nnoremap <space>d :BW<CR>
    "}}}
    NeoBundle 'Raimondi/delimitMate', "{{{
        let delimitMate_expand_cr = 0
        let delimitMate_jump_expansion = 0
    "}}}
    NeoBundle 'Shougo/vimfiler.vim', "{{{
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_safe_mode_by_default = 0

        autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') |
                    \ q | endif

        nmap <space>f :VimFiler -winwidth=40 -explorer -toggle<CR>
        nmap <space>n :VimFiler -winwidth=40 -explorer -find<CR>
    "}}}
    NeoBundle 'tsaleh/vim-matchit'

    " VCS
    NeoBundle 'int3/vim-extradite', "{{{
        noremap <space>e :Extradite!<CR>
        let g:extradite_width = 100
    "}}}
    NeoBundle 'tommcdo/vim-fugitive-blame-ext'
    NeoBundle 'tpope/vim-fugitive', "{{{
        noremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>gr :Gremove<CR>
        autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
        autocmd BufReadPost fugitive://* set bufhidden=delete
    "}}}

    NeoBundleCheck
" }}}

" Toggle relative numbers {{{
    let g:numbers_on = 0
    function! ToggleRelativeNumbers()
        if g:numbers_on
            let g:numbers_on = 0
            set norelativenumber
        else
            let g:numbers_on = 1
            set relativenumber
        endif
    endfunction

    nnoremap <silent> <space>h :call ToggleRelativeNumbers()<CR>
"}}}

" General settings {{{
    if has("balloon_eval") && has("unix")
        set ballooneval
    endif

    if has("eval")
        let &highlight = substitute(&highlight,'NonText','SpecialKey','g')
    endif

    if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
        let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    else
        set listchars=tab:>\ ,trail:-,extends:>,precedes:<
    endif

    if has('mouse')
        set mouse=a
        set mousemodel=popup
    endif

    set number
    set ff=unix
    set cindent

    " a - terse messages (like [+] instead of [Modified]
    " t - truncate file names
    " I - no intro message when starting vim fileless
    " T - truncate long messages to avoid having to hit a key
    set shortmess=atIT

    set nowrap                      " Do not wrap lines by default
    set autoread                    " Reload files changed outside vim
    set colorcolumn=80

    set history=1000                " remember more commands and search history
    set undolevels=1000             " remember more undo levels
    "set lazyredraw
    set ttyfast " u got a fast terminal

    " No need to show mode due to Powerline
    set noshowmode

    " Explicitly set encoding to utf-8
    set encoding=utf-8

    " Prevents MatchParen from loading, which can cause slowdown
    let g:loaded_matchparen=1

    " This makes vim act like all other editors, buffers can :u
    " exist in the background without being in a window.
    " http://items.sjbach.com/319/configuring-vim-right
    set hidden

    " fix delete fail on os x http://vim.wikia.com/wiki/backspace_and_delete_problems
    set backspace=indent,eol,start

    " allow k,l to wrap start/end of lines
    set whichwrap+=<,>,h,l,[,]

    " Do not highlight current line
    set nocursorline
    set nocursorcolumn
    nnoremap <Leader>c :set cursorline!<CR>

    " Solid line for vsplit separator
    set fcs=vert:│

    " Select all
    nmap <space>a ggVG<CR>
" }}}

" Sudo {{{
    " w!!: Writes using sudo
    cnoremap w!! w !sudo tee % >/dev/null
" }}}

" Spelling toggle {{{
    " http://yavin4.anshul.info/2006/05/18/spell-check-in-vim-7/
    set spelllang=en
    " Toggle spelling & line highlighting with F7
    map <silent> <F7> :set nospell!<CR>:set nospell?<CR> <bar> :set cursorline!<CR>
" }}}

" Disable arrow keys {{{
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>
    imap <up> <nop>
    imap <down> <nop>
    imap <left> <nop>
    imap <right> <nop>
" }}}

" Pasting {{{
    nnoremap <f2> :set invpaste paste?<cr>
    set pastetoggle=<f2>            " toggle paste mode
" }}}

" Turn Off Swap Files {{{
    set noswapfile
    set nobackup
    set nowb
" }}}

" Position saving {{{
    " http://amix.dk/vim/vimrc.html
    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
" }}}

" Persistent Undo {{{
    " Keep undo history across sessions, by storing in file.
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
" }}}

" Scrolling {{{
    set scrolloff=8 " Start scrolling when we're 8 lines away from margins
    set sidescrolloff=15
    set sidescroll=1
" }}}

" Search & Replace {{{
    set hlsearch
    set incsearch
    set smartcase
    set ignorecase
    set showmatch

    " Clear search highlight http://statico.github.io/vim.html
    nmap <space>q :nohlsearch<CR>

    " Replace all instances of word under cursor
    nnoremap <space>r :%s/\<<C-r><C-w>\>//g<Left><Left>
" }}}

" Show special characters {{{
    " http://vimcasts.org/episodes/show-invisibles/
    " Shortcut to rapidly toggle `set list`
    set list
    nmap <leader>l :set list!<CR>
    " Use the same symbols as TextMate for tabstops and EOLs
    set listchars=tab:┆\ ,trail:•,extends:❯,precedes:❮
    set shiftround
    set linebreak
    set showbreak=↪
" }}}

" Open preview window at bottom {{{
    set splitbelow
    set splitright
" }}}

" Whitespace {{{
    " Delete trailing whitespace on save
    " http://stackoverflow.com/a/1618401/187954
    fun! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun
    autocmd FileType c,cpp,css,less,sass,scss,java,php,ruby,puppet,python,javascript,vim,sh,nginx,ant,xml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    " listchar=trail is not as flexible, use the below to highlight trailing
    " whitespace. Don't do it for unite windows or readonly files
    highlight ExtraWhitespace ctermbg=red guibg=red

    function! HighlightTrailingWhitespace()
        if &ft =~ 'html|scss|css|javascript|php|vim'
            match ExtraWhitespace /\s\+$/
            match ExtraWhitespace /\s\+\%#\@<!$/
        endif
    endfunction

    augroup HightlightWhitespaceAutoCmd
        autocmd BufWinEnter * :call HighlightTrailingWhitespace()
        autocmd InsertEnter * :call HighlightTrailingWhitespace()
        autocmd InsertLeave * :call HighlightTrailingWhitespace()
    augroup END
" }}}

" Buffer switching {{{
     map <leader>n :bn<cr> " next buffer
     map <leader>p :bp<cr> " previous buffer
     map <leader>d :bd<cr> " delete buffer
"}}}

" PHP {{{
    au BufNewFile,BufRead *.phtml setf phtml
" }}}

" CSS {{{
    autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
" }}}
