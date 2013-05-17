
function makeheader(){

 export HEADER_FILE=$1 export UUID=`uuid | sed  's/-/_/g'` ; echo -e "#ifndef _$UUID\n#define _$UUID\n\n#endif" > $HEADER_FILE ;

}


function lsdirectory(){

    find $1 -maxdepth 1 -type d 
}

function install-alternative(){
    sudo update-alternatives --install $1 $2 $3
}

function update-alternative(){
    sudo update-alternatives --config $1
}
function gobindir(){
    cd $(dirname `which $1`)
}
function gh-clone(){
    git clone git@github.com:trevd/$1.git $2
}
function quick-find(){  
    find ./ -iname "*$1*" 
}
function movefromlast(){
    mv $OLDPWD/$1 $PWD
}
function movetolast(){
    mv $PWD/$1 $OLDPWD
}
function copyfromlast(){
    cp $OLDPWD/$1 $PWD
}
function copytolast(){
    cp $PWD/$1 $OLDPWD
}
function copytolastrv(){
    cp -rv $PWD/$1 $OLDPWD
}
function envsetup(){
    if [ -f "build2/envsetup.sh" ] ; then
        . build2/envsetup.sh
    else
        . build/envsetup.sh 
    fi
}
function elfless(){
    readelf -a $1 | less
}
function binless(){
    strings $1 | less
}
function bingrep(){
    strings -f $1 | grep "$2"
}
function fgreplow(){
    if [ -z "$2" ]; then
        SEARCH=./*
    else
        SEARCH=$2
    fi
    echo "fgrep -in "$1" $SEARCH 2>/dev/null"
        fgrep -in "$1" $SEARCH 2>/dev/null
}
function fgreplowr(){
    if [ -z "$2" ]; then
        SEARCH=./*
    else
        SEARCH=$2
    fi
    echo "fgrep -inR \"$1\" $SEARCH 2>/dev/null"
        fgrep -inR "$1" $SEARCH 2>/dev/null
}

DARWIN_PREFIX=i686-apple-darwin11
PATH=/media/android/bin:/media/android/lib:$PATH
ALIAS_ANDROID_DIR=/media/android
VENDOR_DIR=/media/vendor/
ALIAS_BUILD_DIR=/media/android/build
WORKSPACE_DIR=/media/android/workspace
TOOLCHAINS_DIR=$ALIAS_BUILD_DIR/toolchains/
REPO_DIR=/media/android/REPO
GITS=$REPO_DIR/gits
KERNELS_DIR=$ALIAS_BUILD_DIR/kernels
ANDROID_KERNELS_DIR=$KERNELS_DIR/android
EDITOR=geany
NDK_TOOLCHAIN_VERSION=clang3.1

APT=apt-fast
alias chm='sudo chmod'
alias own='sudo -E chown $USER.$USER -Rv'
alias ownrv='sudo -E chown $USER.$USER -Rv'
alias goosxsdk108='cd /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk'
alias goosx='cd $ALIAS_ANDROID_DIR/osx'
alias exut=exit
alias fr=fgreplowr
alias f=fgreplow
alias binl=binless
alias binf=bingrep
alias setapp='update-alternative'
alias setgcc='update-alternative gcc'
alias addapp='sudo update-alternatives --install'
ENVSETUP=envsetup
export SDK=$ALIAS_ANDROID_DIR/sdk
export ANDROID_HOME=$SDK
export NDK=/media/android/ndk/android-ndk-r8e
alias gh-commit='git commit -a && git push'
alias gh-push='git push'
alias c='cat'
alias gd='godir'
#alias cd='pushd'
#alias cd..='popd'
alias du0='du -h --max-depth=0 -c'
alias start-eclipse='$ALIAS_ANDROID_DIR/eclipse/eclipse &'
alias gpout='cd $ANDROID_PRODUCT_OUT'
alias gpoutkernel='cd $ANDROID_PRODUCT_OUT/obj/KERNEL_OBJ'
alias gpoutobj='cd $ANDROID_PRODUCT_OUT/obj'
alias gpoututils='cd $ANDROID_PRODUCT_OUT/utilities'
alias gowinbin='cd $REPO_DIR/windows'
alias goapk='cd $ALIAS_ANDROID_DIR/apk'
alias gogits='cd $ALIAS_ANDROID_DIR/REPO/gits'
alias gomusic='cd $ALIAS_ANDROID_DIR/REPO/music'
alias gpoutsys='cd $ANDROID_PRODUCT_OUT/system'
alias gpoutsysbin='cd $ANDROID_PRODUCT_OUT/system/bin'
alias gpoutsyslib='cd $ANDROID_PRODUCT_OUT/system/lib'
alias godown='cd $HOME/Downloads'
alias gokernels='cd $KERNELS_DIR'
alias gho='cd $ANDROID_HOST_OUT'
alias ghwin='cd $ANDROID_BUILD_TOP/out/host/windows-x86'
alias ghdar='cd $ANDROID_BUILD_TOP/out/host/darwin-x86'
alias mm16='mm -j16'
alias gbt='cd $ANDROID_BUILD_TOP'
alias gadb='cd $ANDROID_BUILD_TOP/system/core/adb'
alias gfb='cd $ANDROID_BUILD_TOP/system/core/fastboot'
alias gzlib='cd $ANDROID_BUILD_TOP/external/zlib'
alias gssl='cd $ANDROID_BUILD_TOP/external/openssl'
alias gbit='cd $ANDROID_BUILD_TOP/external/bootimage_tools'
alias gext='cd $ANDROID_BUILD_TOP/external'
alias gsys='cd $ANDROID_BUILD_TOP/system'
alias grecovery='cd $ANDROID_BUILD_TOP/bootable/recovery'
alias gsyscore='cd $ANDROID_BUILD_TOP/system/core'
alias gkernel='cd $ANDROID_BUILD_TOP/kernel'
alias gkernelarchos='cd $ANDROID_BUILD_TOP/kernel/archos/archos_g9'
alias gdeviceamazon='cd $ANDROID_BUILD_TOP/device/amazon'
alias gdeviceamazonomap='cd $ANDROID_BUILD_TOP/device/amazon/omap4-common'
alias gdeviceottercommon='cd $ANDROID_BUILD_TOP/device/amazon/otter-common'
alias gdeviceotter='cd $ANDROID_BUILD_TOP/device/amazon/otter'
alias gdevicearchos='cd $ANDROID_BUILD_TOP/device/archos'
alias gdeviceomap='cd $ANDROID_BUILD_TOP/device/archos/omap4-common'
alias gdeviceg9='cd $ANDROID_BUILD_TOP/device/archos/archos_g9'
alias gdevarchos='cd $ANDROID_BUILD_TOP/device/archos/archos_g9'
alias gdevasusgrouper='cd $ANDROID_BUILD_TOP/device/asus/grouper'
alias gdevasus='cd $ANDROID_BUILD_TOP/device/asus'
alias gdevsamsung='cd $ANDROID_BUILD_TOP/device/samsung'
alias gdevsamsungomap='cd $ANDROID_BUILD_TOP/device/samsung/omap4-common'
alias gdevp1='cd $ANDROID_BUILD_TOP/device/samsung/p1'
alias gdevp1common='cd $ANDROID_BUILD_TOP/device/samsung/p1-common'
alias gdev='cd $ANDROID_BUILD_TOP/device'
alias gdevblazetab='cd $ANDROID_BUILD_TOP/device/ti/blaze_tablet'
alias gdevice='cd $ANDROID_BUILD_TOP/device'
alias gbuild='cd $ANDROID_BUILD_TOP/build'
alias gbuild2='cd $ANDROID_BUILD_TOP/build2'
alias gbuildcombo='cd $ANDROID_BUILD_TOP/build/core/combo'
alias gbuildtools='cd $ANDROID_BUILD_TOP/build/tools'
alias gbuildcore='cd $ANDROID_BUILD_TOP/build/core'
alias gbuildboard='cd $ANDROID_BUILD_TOP/build/target/board'
alias gbuildproduct='cd $ANDROID_BUILD_TOP/build/target/product'
alias gbuildtarget='cd $ANDROID_BUILD_TOP/build/target'
alias grootdir='cd $ANDROID_BUILD_TOP/system/core/rootdir'
alias ghw='cd $ANDROID_BUILD_TOP/hardware'
alias ghwti='cd $ANDROID_BUILD_TOP/hardware/ti'
alias ghwril='cd $ANDROID_BUILD_TOP/hardware/ril'
alias gti='cd $ANDROID_BUILD_TOP/device/ti'
alias gtiblaze='cd $ANDROID_BUILD_TOP/device/ti/blaze_tablet'
alias gsam='cd $ANDROID_BUILD_TOP/device/samsung'
alias ghtc='cd $ANDROID_BUILD_TOP/device/htc'
alias gbionic='cd $ANDROID_BUILD_TOP/bionic'
alias glibc='cd $ANDROID_BUILD_TOP/bionic/libc'
alias gven='cd $ANDROID_BUILD_TOP/vendor'
alias ggog='cd $ANDROID_BUILD_TOP/device/google'
alias gcom='cd $ANDROID_BUILD_TOP/device/common'
alias ggen='cd $ANDROID_BUILD_TOP/device/generic'
alias gasus='cd $ANDROID_BUILD_TOP/device/asus'
alias gmakefile='$EDITOR $ANDROID_BUILD_TOP/build/core/Makefile'
alias gfw='cd $ANDROID_BUILD_TOP/frameworks'
alias gdevicegrouper='cd $ANDROID_BUILD_TOP/device/asus/grouper'
alias grepo='cd $ANDROID_BUILD_TOP/.repo'
alias gpackages='cd $ANDROID_BUILD_TOP/packages'
alias gapps='cd $ANDROID_BUILD_TOP/packages/apps'
alias gvendorcm='cd $ANDROID_BUILD_TOP/vendor/cm'
alias gvendorcmconfig='cd $ANDROID_BUILD_TOP/vendor/cm/config'
alias gvendorbroadcomm='cd $ANDROID_BUILD_TOP/vendor/broadcomm'
alias gvendorwidevine='cd $ANDROID_BUILD_TOP/vendor/widevine'
alias gvendorgoogle='cd $ANDROID_BUILD_TOP/vendor/google'
alias gvendor='cd $ANDROID_BUILD_TOP/vendor/'
alias glocalmanifests='cd $ANDROID_BUILD_TOP/.repo/local_manifests'


alias gpl='cd $ALIAS_BUILD_DIR/android-paranoid && $ENVSETUP && lunch'  
alias gal='cd $ALIAS_BUILD_DIR/aosp && $ENVSETUP && lunch'  
alias g1l='cd $ALIAS_BUILD_DIR/android-cm-10 && $ENVSETUP && lunch' 
alias gol='cd $ALIAS_BUILD_DIR/android-omapzoom && $ENVSETUP && lunch'  
alias rpsytrace='repo --trace sync -j16'
alias rpsy='repo sync -j16'
alias rpinit-pa='repo init -u git://github.com/ParanoidAndroid/manifest.git -b'
alias rpinit-cm='repo init  -u git://github.com/CyanogenMod/android.git -b'
alias rpinit-linaro='repo init -u git://android.git.linaro.org/platform/manifest.git -b'
alias rpinit-aosp='repo init  -u https://android.googlesource.com/platform/manifest -b'
alias rpinit-omap='repo init  -u git://git.omapzoom.org/platform/omapmanifest.git -b'
alias tm16='time make -j16'
alias mj16='time m -j16'
alias tm16ota='time make -j16 otapackage'
alias tm12='time make -j12'
alias tmk='time make'
alias mmsc='mm showcommands'

alias tz='tar -zxvf'
alias tj='tar -jxvf'

########## Quick Switch Common Directories ##################
alias gobuild='cd $ALIAS_BUILD_DIR'
alias gotc='cd $TOOLCHAINS_DIR'
alias gows='cd $WORKSPACE_DIR'
alias gowsacm10='cd $WORKSPACE_DIR/archos/cm101'
alias godroid='cd $ALIAS_ANDROID_DIR'
alias govendor='cd $VENDOR_DIR'
alias gosdk='cd $SDK'
alias gondk='cd $NDK'
################# ANDROID BUILD HELPERS #######################
##### root required ########
alias reboot='sudo reboot'
alias shdn='sudo shutdown now'
alias mount='sudo mount'
alias umount='sudo umount'
alias chown='sudo chown'
alias chmod='sudo chmod'
alias +x='sudo chmod +x'
alias +w='sudo chmod +w'
alias +r='sudo chmod +r'
alias 777='sudo chmod 777'
alias 644='sudo chmod 644'
alias 755='sudo chmod 755'  
alias 6777='sudo chmod 6777'
alias 6755='sudo chmod 6755'
alias 666='sudo chmod 666'
alias 750='sudo chmod 750'
alias rmrf='sudo rm -rf'
alias cprv='cp -rv'
alias cd-='cd -'
alias wgetf='wget -F'
alias androidsdk='$SDK/tools/android &'
 
alias 7d='7z d'
alias 7a='7z a'
alias 7x='7z x'
alias 7l='7z l'
alias 7u='7z u'
alias 7e='7z e'
alias g='$EDITOR'
alias sug='sudo $EDITOR'


alias settings='$EDITOR /media/android/setup/bash_aliases &'
alias lar='ls -lAhR'
alias lsd='lsdirectory'
alias lsdir='lsdirectory'
alias la='ls -lAh'
alias l1='ls -1'
alias l1r='find . -iname '
alias lr='ls -R'
alias apt-in='sudo $APT install'
alias apt-rm='sudo $APT remove'
alias apt-up='sudo $APT update'
alias apt-ug='sudo $APT upgrade'
alias apt-find='apt-cache search'
alias apt-info='apt-cache show'
alias apt-code='sudo $APT source'
alias aptin='sudo $APT install'
alias aptrm='sudo $APT remove'
alias aptup='sudo $APT update'
alias aptug='sudo $APT upgrade'
alias aptfind='apt-cache search'
alias aptinfo='apt-cache show'
alias aptcode='sudo $APT source'


alias qf='quick-find'
alias ps='ps aux'

alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias fh='free -h'
alias dfh='df -h'
alias rmrf='rm -rf'
alias objdump-arm='$TOOLCHAINS_DIR/arm-eabi-4.7/bin/arm-eabi-objdump' 
alias make-and='PATH=$ARM_EABI_TOOLCHAIN/arm-eabi-4.7/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make -j16'
alias make-arm47='PATH=$TOOLCHAINS_DIR/arm-eabi-4.7/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make -j16'
alias make-archos='PATH=$TOOLCHAINS_DIR/archos_arm_toolchain/usr/bin:$PATH CC=arm-linux-uclibcgnueabi-cc ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-linux-uclibcgnueabi- LOCALVERSION_AUTO=n make -j16'
alias make-arm43='PATH=$TOOLCHAINS_DIR/arm-eabi-4.3.3/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias make-arm46='PATH=$TOOLCHAINS_DIR/arm-eabi-4.6/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias make-arm44='PATH=$TOOLCHAINS_DIR/arm-eabi-4.4.3/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias mkarchosconfig='make-arm47 archos_g9_defconfig ; make-arm47 menuconfig ; cp .config arch/arm/configs/archos_g9_defconfig ; make-arm47 mrproper'

alias udev-android='sug /etc/udev/rules.d/51-android.rules'
alias udev-reload='sudo udevadm control --reload-rules'
alias adbg='ADB_TRACE=all a'
alias lns='ln -s'
alias doset='source $HOME/.bash_aliases'
alias updaterscript='$EDITOR META-INF/com/google/android/updater-script'
alias ghome='cd $HOME'
alias diffy='diff -W130 --suppress-common-lines  -y'
alias gstudio='cd /media/android/studio'
alias gorandom='cd $ALIAS_BUILD_DIR/random_and_useful'
