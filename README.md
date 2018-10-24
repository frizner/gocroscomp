# gocroscomp

**gocroscomp** performs cross compile of a golang package for set OSes.

## Feauteres
- automated compilation.
- OSes and platforms can be set by regular expression.
- archiving binary files.
- creating SHA256 checksums file.

## Usage
```sh
$ gocroscomp.sh 
gocroscomp.sh performs cross compilation of a golang package,
   archaive the binaries and creates file with checksum for the each archive.

usage: ./gocroscomp.sh PLATFORMS PACKET FILENAME VERSION

  - PLATFORMS. Sets OSes and platforms by using regular expression to build binarie files.
    For instance '(windows|linux)\/(386|amd64)'.

  - PACKET. The name of packet to compile.
    For instance 'github.com/friznerd/solrdump/cmd/solrdump'

  - FILENAME. The name of destination binary file.
    For Windows OS, '.exe' extension will be aaded automatically

  - VERSION. The version will be added into names of archaives of the binary files.
    For instance '0.1.1'

```

```sh
$ gocroscomp.sh "(windows|linux|darwin|bsd|solaris)\/(386|amd64)" "github.com/frizner/solrdump/cmd/solrdump" solrdump 0.1.1

$ ls -1
solrdump_0.1.1_SHA256.txt
solrdump_0.1.1_freebsd_x86_32.gz
solrdump_0.1.1_freebsd_x86_64.gz
solrdump_0.1.1_linux_x86_32.gz
solrdump_0.1.1_linux_x86_64.gz
solrdump_0.1.1_netbsd_x86_32.gz
solrdump_0.1.1_netbsd_x86_64.gz
solrdump_0.1.1_openbsd_x86_32.gz
solrdump_0.1.1_openbsd_x86_64.gz
solrdump_0.1.1_osx_x86_32.gz
solrdump_0.1.1_osx_x86_64.gz
solrdump_0.1.1_solaris_x86_64.gz
solrdump_0.1.1_windows_x86_32.zip
solrdump_0.1.1_windows_x86_64.zip

$ cat solrdump_0.1.1_SHA256.txt 
41c62ef3d10d2a0c15ef49aa93077312532ae1c7d63896f3f7e66d9cc31238a8  solrdump_0.1.1_osx_x86_32.gz
eb3081b30f486ba42546bba401d0779c964906e6d284ad3075455eb6522865de  solrdump_0.1.1_osx_x86_64.gz
c118c02a8127855cf6245d7d964a1a8186d7c683ce7696f12d4f2eb3d95f5aa3  solrdump_0.1.1_freebsd_x86_32.gz
ac215000b53550d3b07da21c1d142e648172e9f0cf72d7aafe1d55deab49c9ca  solrdump_0.1.1_freebsd_x86_64.gz
21f565090bd1b736935d733ad80357ce7e8ae677c1d3bb2da035cd229d444a4e  solrdump_0.1.1_linux_x86_32.gz
883fbfed802a23353e151195f7773800df6376b818e20fdd881e8612c5486445  solrdump_0.1.1_linux_x86_64.gz
9f77568823c507fac7622d43e80c620916a0fb9bfa8c552df53cf0c020abefd6  solrdump_0.1.1_netbsd_x86_32.gz
06cccb6fed85e7b03aea2a689fc83687ca02c6cc22a6018bd72cb776c5ad0c80  solrdump_0.1.1_netbsd_x86_64.gz
aced6905d65f94df27f9b4b9461718f1275a8cdfaf029240c8c3872dd027a821  solrdump_0.1.1_openbsd_x86_32.gz
e75aa056ebcc12b08426911fd501012b9e0861aca1cf3455122fff8553c232c0  solrdump_0.1.1_openbsd_x86_64.gz
d13d37523f63fbbe3e2137ef9b964f5b6abe809caf086ef638580a0a41054a29  solrdump_0.1.1_solaris_x86_64.gz
3c19903bb05be89774ca52466c46420aa6f818f23800357cd06881e3318d3bc3  solrdump_0.1.1_windows_x86_32.zip
3ff2fdfd328cff21e83bc4fcb43ae447de60c83052db21e8bcf53afc5deee293  solrdump_0.1.1_windows_x86_64.zip
```

### License
`gocroscomp` is released under the MIT License. See [LICENSE](https://github.com/frizner/gocroscomp/blob/master/LICENSE).


