#!/usr/bin/env bash

VERBOSE=false

for arg in "$@"; do
  case $arg in
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
  esac
done

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

verbose() {
  if [[ "$VERBOSE" == true ]]; then
    blue='\033[0;34m'
    nc='\033[0m'
    echo -e "${blue}INFO:${nc} $1"
  fi
}

if [[ "$(uname -s)" != "Darwin" ]]; then
  error "This script only works on macOS."
  return 1
fi

if ! command -v brew >/dev/null 2>&1; then
  error "Brew needs to be installed for this script"
  return 1
fi

log "Installing language servers and tools"

verbose "Installing gopls"
go install golang.org/x/tools/gopls@latest >/dev/null 2>&1

verbose "Installing graphql-language-service-cli"
npm install -g graphql-language-service-cli >/dev/null 2>&1

verbose "Installing tailwindcss-language-server"
npm install -g tailwindcss-language-server >/dev/null 2>&1

verbose "Installing prisma language server"
npm install -g @prisma/language-server >/dev/null 2>&1

verbose "Installing marksman"
npm install -g marksman >/dev/null 2>&1

verbose "Installing eslint"
npm install -g eslint >/dev/null 2>&1

verbose "Installing prettier"
npm install -g prettier >/dev/null 2>&1

verbose "Installing vue language server"
npm install -g @vue/language-server >/dev/null 2>&1

log "All language servers and tools installed successfully"
