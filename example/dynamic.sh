rm -rf example/dynamic
binary/lemon -d./example/dynamic example/dynamic.y -m &&
gcc example/dynamic/dynamic.c -o example/dynamic/m &&
example/dynamic/m &&
# ls example/dynamic &&
# cat example/dynamic/dynamic.h &&
exit 0
