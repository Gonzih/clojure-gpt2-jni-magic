.SHELLFLAGS =
SHELL=./scripts/shell.sh

nrepl:
	clj -m nrepl.cmdline

run:
	clj -m hello
