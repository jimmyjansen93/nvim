#!/usr/bin/env bash

log() {
  green='\033[0;32m'
  nc='\033[0m'
  echo -e "${green}LOG:${nc} $1"
}

error() {
  red='\033[0;31m'
  nc='\033[0m'
  echo -e "${red}ERROR: $1${nc}"
}

warning() {
  orange='\033[0;38;5;208m'
  nc='\033[0m'
  echo -e "${orange}WARNING:${nc} $1"
}

if [[ "$(uname -s)" != "Darwin" ]]; then
  error "This script only works on macOS."
  return 1
fi

if ! command -v brew >/dev/null 2>&1; then
  error "Brew needs to be installed for this script"
  return 1
fi

if ! command -v go &> /dev/null; then
  brew install go
fi

if ! command -v npm &> /dev/null; then
  brew install node
fi

brew install sif
brew install zls
brew install llvm
brew install rust-analyzer
brew install typescript-language-server
brew install vscode-langservers-extracted
brew install typescript-language-server
brew install yaml-language-server
brew install bash-language-server
brew install stylua
brew install sql-language-server
brew install docker-ls
brew install terraform-ls
brew install helm
go install golang.org/x/tools/gopls@latest
npm install -g graphql-language-service-cli
npm install -g tailwindcss-language-server
npm install -g @prisma/language-server
npm install -g marksman
npm install -g eslint
npm install -g prettier
npm install -g @vue/language-server
