rm -rf example/parser
gcc defgen.c -o binary/defgen &&
binary/defgen &&
gcc lemon.c -o binary/lemon -DLEMONEX_DBG=3  &&
binary/lemon -dexample/parser ./example/parse.y -m &&
gcc example/parser/parse.c -o example/parser/parser &&
example/parser/parser &&
ls example/parser &&
cat example/parser/parse.h
