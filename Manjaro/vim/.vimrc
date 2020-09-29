" basic settings 
syntax on
set number
set relativenumber
set cursorline
set showcmd
set wildmenu
set autoindent
set hlsearch
set incsearch
"set tab=4 space
set ts=4
set expandtab

"Plugins
call plug#begin('~/.vim/plugged')

"airline: a vim status monitoring plugin
Plug 'vim-airline/vim-airline'

"snazzy: a color theme for vim, supporting transparent
Plug 'connorholyday/vim-snazzy'

"coc: completion plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" CPP syntax highlight
Plug 'octol/vim-cpp-enhanced-highlight'

"********File Navigation**********
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Tagbar : a function list plugin
Plug 'majutsushi/tagbar'

" Error checking
Plug 'w0rp/ale'

"visual enhancement
"indent show
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" color scheme
colorscheme snazzy
let g:SnazzyTransparent = 1

"******************************************
"*			                              * 
"*           COC CONFIGURAITION  	      * 
"*			 		                      * 
"******************************************
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"**********************************************************
"*			                                              * 
"*           CPP SYNTAX HIGHLIGHT CONFIGURAITION  	      * 
"*			 		                                      * 
"**********************************************************

"Highlighting of class scope
let g:cpp_class_scope_highLight                     = 1
"Highlighting of member variables 
let g:cpp_member_variable_highLight                 = 1
"Highlighting of class names in declaration 
let g:cpp_class_decl_highLight                      = 1
"Highlighting of template functions  
let g:cpp_experimental_template_highLight           = 1
"Highlighting of library concepts  
let g:cpp_concepts_highLight                        = 1
"Highlighting of user defined functions 
let g:cpp_no_function_highLight                     = 1

"**********************************************
"*			                                  * 
"*           Tagbar  CONFIGURAITION  	      * 
"*			 		                          * 
"**********************************************
let g:tagbar_ctags_bin = 'ctags'
" tagbar showing up at left side
let g:tagbar_left = 1
" cursor at tagbar page, at vim page by default
let g:tagbar_autofocus = 1
" set tags not sorted
let g:tagbar_sort = 0
" tagbar width = 30.
let g:tagbar_width = 30

"**********************************************
"*			                                  * 
"*           NERDTREE  CONFIGURAITION  	      * 
"*			 		                          * 
"**********************************************
" fast open & close nerdtree
map tt :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
       \ "Modified"  : "✹",
       \ "Staged"    : "✚",
       \ "Untracked" : "✭",
       \ "Renamed"   : "➜",
       \ "Unmerged"  : "═",
       \ "Deleted"   : "✖",
       \ "Dirty"     : "✗",
       \ "Clean"     : "✔︎",
       \ "Unknown"   : "?"
       \ }
"******************************************************
"*			                                          * 
"*           vimindent guid CONFIGURAITION  	      * 
"*			 		                                  * 
"******************************************************
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1