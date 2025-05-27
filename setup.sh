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

log "Installing gopls"
go install golang.org/x/tools/gopls@latest >/dev/null 2>&1

log "Installing graphql-language-service-cli"
npm install -g graphql-language-service-cli >/dev/null 2>&1

log "Installing tailwindcss-language-server"
npm install -g tailwindcss-language-server >/dev/null 2>&1

log "Installing prisma language server"
npm install -g @prisma/language-server >/dev/null 2>&1

log "Installing marksman"
npm install -g marksman >/dev/null 2>&1

log "Installing eslint"
npm install -g eslint >/dev/null 2>&1

log "Installing prettier"
npm install -g prettier >/dev/null 2>&1

log "Installing vue language server"
npm install -g @vue/language-server >/dev/null 2>&1
