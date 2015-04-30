#!/bin/bash

#Установка Vim и необходимых компонентов
#эту строку можно закомментировать, если
#все компоненты уже установлены
#sudo yum install vim curl git
sudo apt-get install vim curl git

#Установка плагинов Vim
#1. Pathogen - для удобства установки плагинов. (https://github.com/tpope/vim-pathogen)
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSo ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#2. NERDTree - Дерево папок. (https://github.com/scrooloose/nerdtree)
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#3. CSApprox - Позволяет использовать цветовые темы для GUI в терминале
#http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal
#http://www.vim.org/scripts/script.php?script_id=2390
git clone https://github.com/godlygeek/csapprox ~/.vim/bundle/csapprox

#4. colorscheme twilight (https://github.com/vim-scripts/twilight)
#Цветовую схему можно установить любую понравившуюся, а не только указанную ниже
#mkdir -p .vim/bundle/twilight256/colors
#curl -LSo .vim/bundle/twilight256/colors/twilight256.vim http://www.vim.org/scripts/download_script.php?src_id=14937
git clone https://github.com/justincampbell/vim-railscasts ~/.vim/bundle/vim-railscasts

#.vimrc - конфигурационный файл VIM
cat << EOF > ~/.vimrc
execute pathogen#infect()
syntax on
filetype plugin indent on
"NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"switch to a second window
"autocmd VimEnter * <C-w><C-w>

"CSApprox
set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

"set row numbers
set number

"set switch between windows as <Tab>
map <Tab> <C-w><C-w>

"Color scheme
colorscheme railscasts

"Set tabstops
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
EOF
