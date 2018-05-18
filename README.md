

### Build instructions
```shell
# run once to install Xcode CLI tools
$ xcode-select --install
# clone and build Zcash on macOS
$ git clone https://github.com/ZencashOfficial/zencash-apple.git
$ cd zencash-apple
$ source environment
$ make
```

In case of an error please run the following command for debug info
```shell
$ PRINT_DEBUG=y make all
```
Clone the ZenCash repository and fetch the necessary parameters:
Build using the following command (with NUM_CORES = number of cores to use for the build process):

```shell
git clone https://github.com/ZencashOfficial/zencash.git
cd zencash/
./zcutil/fetch-params.sh
LIBTOOLIZE=glibtoolize ./zcutil/build-mac-clang.sh --disable-libs -j(NUM_CORES)
```

for example:

```shell
LIBTOOLIZE=glibtoolize ./zcutil/build-mac-clang.sh --disable-libs -j4
```
or
```shell
export LIBTOOLIZE=glibtoolize
 ./zcutil/build-mac-clang.sh --disable-libs -j4
 ```

### Disclaimer
this is a fork of https://github.com/kozyilmaz/zcash-apple.git

