# Yet Another Zencash Builder for Apple Platform

![Screenshot](https://github.com/kozyilmaz/zcash-apple/raw/master/docs/zcash-apple.png "Zcash on Mac OS")

**This project requires Xcode 9 and a Mac running macOS 10.12.6 or later.**  
This repository builds standalone Zen binaries for macOS platform without installing brew.  
All build tools (`autoconf, automake, libtool, pkgconfig, cmake, install and readlink`) and `Zen` are compiled from scratch.  


### Build instructions
```shell
# run once to install Xcode CLI tools
$ xcode-select --install
# clone and build Zencash 
$ git clone https://github.com/ZencashOfficial/zencash-apple.git
$ cd zencash-apple
$ source environment
$ make
```

In case of an error please run the following command for debug info
```shell
$ PRINT_DEBUG=y make all
```
After successful build Zen binaries will be installed to `out` directory under project root  
You can then copy binary directory anywhere you like there are no dependencies to the build tree anymore  
```shell
bash-3.2$ ls -lrt out/usr/local/bin
total 32136
-rwxr-xr-x@ 1 loki  staff       483 Feb 25 21:19 zen-init
-rw-r--r--@ 1 loki  staff      1766 Feb 25 21:19 zen-commands.txt
-rwxr-xr-x@ 1 loki  staff  13369544 Feb 25 21:39 zend
-rwxr-xr-x@ 1 loki  staff   1814860 Feb 25 21:39 zen-tx
-rwxr-xr-x@ 1 loki  staff      4761 Feb 25 21:39 zen-fetch-params
-rwxr-xr-x@ 1 loki  staff   1238732 Feb 25 21:39 zen-cli
-rw-r--r--@ 1 loki  staff        54 Feb 25 21:39 version.txt
bash-3.2$ otool -L out/usr/local/bin/zend
out/usr/local/bin/zend:
    /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1252.0.0)
    /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 400.9.0)
bash-3.2$ otool -L out/usr/local/bin/zen-cli 
out/usr/local/bin/zen-cli:
    /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 400.9.0)
    /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1252.0.0)
bash-3.2$ otool -L out/usr/local/bin/zen-tx
out/usr/local/bin/zen-tx:
    /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 400.9.0)
    /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1252.0.0)
```

### Run instructions

When launching `Zen` on MacOS for the first time, certain initalization steps should be completed.  
Please run the commands below once for the first time  

```shell
$ cd out/usr/local/bin

# for testnet
$ ./zen-fetch-params --testnet

# for mainnet
$ ./zen-fetch-params

$ ./zen-init
$ ./zend
```

You can just run `Zen` by launching the daemon afterwards. After blockchain is sync'd, you can use the sample commands provided in [zen-commands.txt](zen/files/zen-commands.txt)  

`$ ./zend`  

Console output from the first run is below:
```shell
bash-3.2$ ./zen-fetch-params
Zen - fetch-params.sh

This script will fetch the Zcash zkSNARK parameters and verify their
integrity with sha256sum.

If they already exist locally, it will exit now and do nothing else.
The parameters are currently just under 911MB in size, so plan accordingly
for your bandwidth constraints. If the files are already present and
have the correct sha256sum, no networking is used.

Creating params directory. For details about this directory, see:
/Users/loki/Library/Application Support/ZcashParams/README

Retrieving: https://z.cash/downloads/sprout-proving.key
######################################################################## 100.0%
/Users/loki/Library/Application Support/ZcashParams/sprout-proving.key.dl: OK
/Users/loki/Library/Application Support/ZcashParams/sprout-proving.key.dl -> /Users/loki/Library/Application Support/ZcashParams/sprout-proving.key
Retrieving: https://z.cash/downloads/sprout-verifying.key
######################################################################## 100.0%
/Users/loki/Library/Application Support/ZcashParams/sprout-verifying.key.dl: OK
/Users/loki/Library/Application Support/ZcashParams/sprout-verifying.key.dl -> /Users/loki/Library/Application Support/ZcashParams/sprout-verifying.key
bash-3.2$ 
bash-3.2$ cat zcash-init 
#!/bin/bash

# excerpted from zclassic/zutil/init-mac.sh

if [ ! -f "$HOME/Library/Application Support/Zen/zen.conf" ]; then
    echo "Creating zen.conf"
    mkdir -p "$HOME/Library/Application Support/Zen/"
    echo "rpcuser=zenrpc" > ~/Library/Application\ Support/Zen/zen.conf
    PASSWORD=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "rpcpassword=$PASSWORD" >> "$HOME/Library/Application Support/Zen/zen.conf"
    echo "Complete!"
fi
bash-3.2$ 
bash-3.2$ ./zen-init 
Creating zen.conf
Complete!
```

## Running the testnetwork
Modify your ```$HOME/Library/Application\ Support/Zen/zen.conf``` file and make sure it looks like this:

``` 
rpcuser=SOME_USERNAME
rpcpassword=SOME_PASSWORD

### connect to test network
testnet=1
addnode=testnet.z.cash
```
You can read more about configs and changing between network [here](https://github.com/ZencashOfficial/zen/blob/master/contrib/debian/examples/zen.conf) on zen's example config file.

Now your config is good to go, start the network back up:
```shell
$ cd out/usr/local/bin
$ ./zend
```

## See / query which network is running
```shell
$ cd out/usr/local/bin
$ ./zen-cli getmininginfo
```
should look like this:
``` 
"testnet": true,
  "chain": "test",
```

## Thanks
Developers of `Zcash`  
Developers of `ZClassic` for MacOS patches
Developers of `Zencash` 
## Donations
If you feel this project is useful to you. Feel free to donate.

    BTC address: 1GmXRm5sEATy3Kz1hCxS1dwfXuCPkevsa
    ZEC address: t1MW8Vx4SF1ewmL3rTN8UfRxULFTaugh1ab


### Disclaimer
This program is not officially endorsed by or associated with the Zcash project and the Zcash Company.
[Zcash®](https://trademarks.justia.com/871/93/zcash-87193130.html) and the 
[Zcash® logo](https://trademarks.justia.com/868/84/z-86884549.html) are trademarks of the
[Zerocoin Electric Coin Company](https://trademarks.justia.com/owners/zerocoin-electric-coin-company-3232749/).

