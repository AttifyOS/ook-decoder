#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${APM_TMP_DIR}" ]]; then
    echo "APM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_INSTALL_DIR}" ]]; then
    echo "APM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_BIN_DIR}" ]]; then
    echo "APM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/AttifyOS/ook-decoder/releases/download/vcc108f9/go-clients.tar.gz -O $APM_TMP_DIR/go-clients.tar.gz
  tar xf $APM_TMP_DIR/go-clients.tar.gz -C $APM_PKG_INSTALL_DIR/
  rm $APM_TMP_DIR/go-clients.tar.gz

  wget https://github.com/AttifyOS/ook-decoder/releases/download/vcc108f9/ookbins.tar.gz -O $APM_TMP_DIR/ookbins.tar.gz
  tar xf $APM_TMP_DIR/ookbins.tar.gz -C $APM_PKG_INSTALL_DIR/
  rm $APM_TMP_DIR/ookbins.tar.gz

  ln -s $APM_PKG_INSTALL_DIR/ookdump $APM_PKG_BIN_DIR/
  ln -s $APM_PKG_INSTALL_DIR/ookd $APM_PKG_BIN_DIR/
  ln -s $APM_PKG_INSTALL_DIR/ookanalyze $APM_PKG_BIN_DIR/
  ln -s $APM_PKG_INSTALL_DIR/ookplay $APM_PKG_BIN_DIR/
  ln -s $APM_PKG_INSTALL_DIR/ooklog $APM_PKG_BIN_DIR/
}

uninstall() {
  rm -rf $APM_PKG_INSTALL_DIR/*
  rm $APM_PKG_BIN_DIR/ook{dump,d,analyze,play,log}
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1