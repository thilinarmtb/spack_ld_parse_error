# Introduction

I am running into an issue where spack `ld` wrappers on Darwin fails to parse
command-line arguments of the form `-Wl,-rpath <path>` (note the space instead
of `,` between `-rpath` and `<path>`). This happens with the latest spack
release `v0.23.1`. If the space is changed to a comma, it works as expected
with the spack `ld` wrappers.

# Steps to reproduce

First of all, `-Wl,-rpath <path>` works as expected with the regular clang:
```sh
tratnayaka@hapana3 spack_ld_parse_error % which clang
/usr/bin/clang
tratnayaka@hapana3 spack_ld_parse_error % CC=clang make
clang -c hello.c -o hello.o
clang -Wl,-rpath /Users/tratnayaka/workspace/anl/thapi/spack_ld_parse_error/libs -o hello hello.o
```
To reproduce the error with `spack`, first get to a spack build-env so we can
use the spack compiler wrappers:
```sh
spack build-env sowing%apple-clang bash
```

Try to build the `hello` executable:
```
bash-3.2$ which clang
/Users/tratnayaka/workspace/anl/thapi/spack/lib/spack/env/clang/clang
bash-3.2$ CC=clang make
clang -c hello.c -o hello.o
clang -Wl,-rpath /Users/tratnayaka/workspace/anl/thapi/spack_ld_parse_error/libs -o hello hello.o
ld: warning: -rpath missing <path>
ld: file cannot be mmap()ed, errno=22 path=/Users/tratnayaka/workspace/anl/thapi/spack_ld_parse_error/libs in '/Users/tratnayaka/workspace/anl/thapi/spack_ld_parse_error/libs'
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:7: hello] Error 1
```
