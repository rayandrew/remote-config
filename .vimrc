let mapleader = " "

call plug#begin()
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'moll/vim-bbye'
	Plug 'tpope/vim-commentary'
call plug#end()

nnoremap <silent> <C-p> :Files<CR>
nmap <leader>ff :GitFiles<CR>
nmap <leader>bb :Buffers<CR>
nmap <leader>fs :w<CR>
nmap <leader>sp :Rg<CR>

nmap <leader>wv :vsplit<CR>
nmap <leader>ws :split<CR>
nnoremap <leader>wq <C-w>q

nnoremap <Leader>bd :Bdelete<CR>
