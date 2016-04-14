#!/bin/bash

#Установка Vim и необходимых компонентов
#эту строку можно закомментировать, если
#все компоненты уже установлены
#sudo yum install vim curl git
#sudo apt-get install vim curl git
rm -rf ~/.vim ~/.vimrc

VIM=$(which vim)
CURL=$(which curl)
GIT=$(which git)
if [[ -z $VIM ]] || [[ -z $CURL ]] || [[ -z $GIT ]]; then
	distr=$(grep 'Red Hat' /proc/version)
	if [[ -z $distr ]]; then
		sudo apt-get -y install vim curl git
	else
		sudo yum -y install vim curl git
	fi  
fi



#Установка плагинов Vim
#НЕ ОТКЛЮЧАТЬ УСТАНОВКУ ЭТОГО ПЛАГИНА! Pathogen - для удобства установки плагинов. (https://github.com/tpope/vim-pathogen)
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSo ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#NERDTree - Дерево папок. (https://github.com/scrooloose/nerdtree)
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#CSApprox - Позволяет использовать цветовые темы для GUI в терминале
#http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal
#http://www.vim.org/scripts/script.php?script_id=2390
git clone https://github.com/godlygeek/csapprox ~/.vim/bundle/csapprox

#colorscheme twilight (https://github.com/vim-scripts/twilight)
#(стандартная colorscheme desert смотрится тоже нормально)
#Цветовую схему можно установить любую понравившуюся, а не только указанную ниже
#mkdir -p .vim/bundle/twilight256/colors
#curl -LSo .vim/bundle/twilight256/colors/twilight256.vim http://www.vim.org/scripts/download_script.php?src_id=14937
#git clone https://github.com/justincampbell/vim-railscasts ~/.vim/bundle/vim-railscasts

#Conque-Shell. Console window in vim
#https://github.com/vim-scripts/Conque-Shell
git clone https://github.com/vim-scripts/Conque-Shell ~/.vim/bundle/conque-shell
#Last version 2.2@1 desn't working
#Checkout to the version 2.2
cd ~/.vim/bundle/conque-shell
git checkout tags/2.2


#.vimrc - конфигурационный файл VIM
cat << EOF > ~/.vimrc
"Do not comment off the next lines
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
map <F2> :w<Enter>
map <F10> :qa<Enter>
map <F12> :ConqueTermSplit bash<Enter>

"Color scheme
colorscheme desert

"Set tabstops
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
EOF
