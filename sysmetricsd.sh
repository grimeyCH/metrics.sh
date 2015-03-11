#!/bin/sh

# config
INTERVAL=1
REPORTER=stdout


# handle opts
opts_spec=":dvh-:"
opt_docs=false
opt_verbose=false

usage () {
  echo "usage: $0 [-d] [-h]"
}

help () {
  echo "TODO"
}

while getopts "$opts_spec" opt; do
  case "${opt}" in
    d)
      opt_docs=true
      ;;
    v)
      opt_verbose=true
      ;;
    h)
      help
      exit
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))


# run
source ./lib/main.sh

if [ $opt_verbose = "true" ]; then
  verbose_on
  verbose "Started in verbose mode"
fi
verbose "OS detected: $OS_TYPE"

main_load
verbose "Metrics loaded: ${__METRICS[@]}"

if [ "$opt_docs" = true ]; then
  main_docs
  exit
fi

main_init
verbose "Metrics initialized"

verbose "Collecting metrics every $INTERVAL second(s)"
main_collect