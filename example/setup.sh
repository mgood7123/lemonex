# gcc defgen.c -o binary/defgen &&
# binary/defgen &&
gcc -g3 lemon.c -o binary/lemon -DLEMONEX_DBG=0 -w -g3 &&
exit 0
