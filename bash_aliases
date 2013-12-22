#copy#G_FILE=/run/shm/geany.$USER
#G_FILE=/run/shm/geany.$USER
ALIAS_DOWNLOAD_DIR=/REPO/Downloads
ALIAS_MUSIC_DIR=/REPO/music

alias doset='source $HOME/.bash_aliases && $HOME/.bash_completion'
shopt -s autocd
rm $HOME/Downloads > /dev/null
rm $HOME/Music > /dev/null

ln -fs $ALIAS_DOWNLOAD_DIR $HOME/Downloads
#stat --
ln -fs $ALIAS_MUSIC_DIR $HOME/Music
export TODIR=/android/build/random_and_useful/todir


if [ -f $TODIR ]; then
    . $TODIR
fi
alias todir='to_dir'

alias llp='ls -l ../'
function _aptcode(){

	own /tmp/apt-fast.list
	apt-get source $1
	rm $1*diff.gz
	rm $1*ubuntu*.dsc
	rm $1*.orig.tar.*
	rm $1*.debian.tar.*
}


function _aptfind(){

	apt-cache search $1	 | sort
}
function _aptfindless(){

	apt-cache search $1	 | sort | less
}
function make_symlink(){

	sudo ln -s $PWD/$1 $2

}
function get_column(){

	
	cut -f$1 -d' '
}
# make directory ( including parents ) and cd to it
function make_and_change_directory(){ 

	mkdir -pv $1
	cd $1

}
alias mkdircd='make_and_change_directory'

# touch a file and make the path if required
function make_directory_touch_file(){

	mkdir -pv $( dirname $1 ) && touch $1 && ls -l $1
	

}
alias mktouch='make_directory_touch_file'

# touch a file, make the path if required and edit 
function make_directory_touch_file_edit(){

	mkdir -pv $( dirname $1 ) && $EDITOR $1 && ls -l $1
	

}
alias mktouched='make_directory_touch_file_edit'
function cleanobj(){
     for fi in  `qf *.o `; do  rm -v $fi ; done
}
function installtoolchain(){
    
    GCC=$1
    GPP=$(echo $GCC |sed 's/gcc/g++/g')
    sudo $APT -y --force-yes install $GCC $GPP
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/$GCC 20 --slave /usr/bin/g++ g++ /usr/bin/$GPP
    sudo update-alternatives --config gcc
}
function installlocaltoolchain(){
    
    GCC=$1
    GPP=$(echo $GCC |sed 's/gcc/g++/g')
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/$GCC 20 --slave /usr/bin/g++ g++ /usr/bin/$GPP
    sudo update-alternatives --config gcc
}
#export CC=/usr/bin/gcc
alias touchall='find -type f -exec touch {} \;'


function mvdown(){

    DEST=$2
    if [ -z "$2" ] ; then DEST="." ; fi

    echo "$1"
    mv ~/Downloads/$1 $DEST

}

# mvcd - mv a file and then change directory to the new
# location
function mvcd(){

    DEST=$2
    DESTDIR=$( basename $2 )
    SRCBASE=$( basename $1 )
    if [ $DESTDIR != $SRCBASE ] ; then
	    DESTDIR=$DEST
    else
        DESTDIR=$( dirname $2 )
    fi


    if [ -z "$2" ] ; then DEST="." ; fi

    echo "$1"
    mv $1 $DEST
    cd $DESTDIR


}


hex2dec(){
  echo "ibase=16; $@"|bc
}
dec2hex(){
  echo "obase=16; $@"|bc
}


function downloadvendorbinaries1(){

	
	AOSP_DEVICE_NAME=$1
	AOSP_BUILD_NUMBER=$2
	GREP_FOR="https://dl.google.com.+$AOSP_DEVICE_NAME.+$AOSP_BUILD_NUMBER.+tgz"
	if [ -z "$AOSP_BUILD_NUMBER" ] ; then 
		curl --silent https://developers.google.com/android/nexus/drivers |  grep -o0 -E $GREP_FOR
		return 0 ; 
	fi	
	SILENT=$3
	if [ -z "$SILENT" ] ; then SILENT="--silent" ; fi
	 
	 
	 echo "Grepping $GREP_FOR"
	 rm extract-*-$1.sh ;
	 rm extract-*-*.sh ; 
	 rm $1*.tgz ;
	 rm *-$1-*.tgz ;
	 rm *-$1-*.sh.tgz ;
	 curl $SILENT https://developers.google.com/android/nexus/drivers |  grep -o0 -E $GREP_FOR | \
		while read -r line ;
			do 
				FILESH=`curl $SILENT $line | tar -xvz ` ;
				sed -n '/\x1f\x8b/,$ p' $FILESH | tar zxv ;
			done 

}

function copyvendor(){

    cd $ANDROID_BUILD_TOP
    lunch $1
    ALIAS_BUILD=$(basename `get_abs_build_var BUILD_ID`) ; ALIAS_BUILD_ID="${x%?}" 
    echo "ALIAS_BUILD=$ALIAS_BUILD"
    ALIAS_DEVICE=$(get_abs_build_var TARGET_PRODUCT | sed -ne 's/^[^_]*_//p')
    echo "ALIAS_DEVICE=$ALIAS_DEVICE"
    cd $ANDROID_BUILD_TOP
    echo "ANDROID _BUILD_TOP=$ANDROID _BUILD_TOP"
    mkdir -p $ANDROID_BUILD_TOP/vendor
    echo "copying vendor files for device: $ALIAS_DEVICE build: $ALIAS_BUILD_ID"
    rm -f extract*.sh
   
    #done
    #rm -f $ANDROID_BUILD_TOP/extract-*-*.sh
    #rm -f $ANDROID_BUILD_TOP/extract-*-*.sh.tgz 
      

}
alias cpven='copyvendor'


function makeheader(){

 export HEADER_FILE=$1 export UUID=`uuid | sed  's/-/_/g'` ; echo -e "#ifndef _$UUID\n#define _$UUID\n\n#endif" > $HEADER_FILE ;

}

function freeram(){
    free -h
    su -c "sync && echo 1 > /proc/sys/vm/drop_caches && echo 2 > /proc/sys/vm/drop_caches && echo 3 > /proc/sys/vm/drop_caches"
    free -h
    
    
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
function quick-find-dir(){  
    find $1 -iname "*$2" 
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
function copyfromlastrv(){
    cp -rv $OLDPWD/$1 $PWD
}
function copytolast(){
    cp $PWD/$1 $OLDPWD
}
function copytolastrv(){
    cp -rv $PWD/$1 $OLDPWD
}
function doenvsetup(){

    echo $PWD
    if [ -f "build2/envsetup.sh" ] ; then
        source build2/envsetup.sh
    else
        source build/envsetup.sh 
    fi
}
function addalias(){

	if [ $# -eq 0 ] ; then
	    echo "No arguments supplied"
            return ;
	fi

	if [ $# -eq 1 ] ; then
		echo "usage: addalias <alias> '<command>'"
		return ;
	fi

	echo "alias $1='$2'" >> $HOME/.bash_aliases
	doset


}
function go_dir(){

	
	
	if [ $# -ne 0 ] ; then
		EXTDIR=/$2
	fi 
 
	cd $ANDROID_BUILD_TOP/$1/$EXTDIR

}
function go_android_dir(){

	
	
	if [ $# -ne 0 ] ; then
		EXTDIR=/$2
	fi 
 
	cd $ANDROID_BUILD_TOP/$1$EXTDIR

}
function go_vendor_dir(){

	
	
	if [ $# -ne 0 ] ; then
		EXTDIR=/$2
	fi 
 
	cd $VENDOR_DIR/$1$EXTDIR

}
function go_build_dir(){

 
	cd $ALIAS_BUILD_DIR/$1

}
function elfless(){
    readelf -aW $1 | less
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

export DARWIN_PREFIX=x86_64-apple-darwin11


function get_device_dir(){
    ALIAS_DEVICE_DIR="$ANDROID_BUILD_TOP/device/*/$(echo "$TARGET_PRODUCT" | sed -ne 's/^[^_]*_//p')"
    
}
function get_kernel_dir(){
    
    TKS=$(get_build_var TARGET_KERNEL_SOURCE)
    
    if [ -z $TKS ] ; then
        TMP_KERNEL_DIR=$(dirname $ANDROID_BUILD_TOP/kernel/*/$(echo "$TARGET_PRODUCT" | sed -ne 's/^[^_]*_//p'))
        ALIAS_KERNEL_DIR=$TMP_KERNEL_DIR/$(echo "$TARGET_PRODUCT" | sed -ne 's/^[^_]*_//p')
        
    else 
        ALIAS_KERNEL_DIR=$(get_abs_build_var TARGET_KERNEL_SOURCE)
    fi 
    
    
}
function get_device(){
    ALIAS_DEVICE="$(echo "$TARGET_PRODUCT" | sed -ne 's/^[^_]*_//p')"
}


ALIAS_ANDROID_DIR=/android
VENDOR_DIR=/vendor/
ALIAS_BUILD_DIR=/android/build
WORKSPACE_DIR=/android/workspace
TOOLCHAINS_DIR=$ALIAS_BUILD_DIR/toolchains/
REPO_DIR=/REPO
GITS=$REPO_DIR/gits
KERNELS_DIR=$ALIAS_BUILD_DIR/kernels
ANDROID_KERNELS_DIR=$KERNELS_DIR/android
#EDITOR=gedit
EDITOR=codelite
# --socket-file $G_FILE"
NDK_TOOLCHAIN_VERSION=clang3.1
export USE_CCACHE=1
export CCACHE_DIR=$ALIAS_BUILD_DIR/ccache

APT=apt-fast
alias striplic="sed -n '/\x1f\x8b/,$ p'"
alias gnexbin='cd $ALIAS_BUILD_DIR/android-nexus-binaries'
alias mnt='sudo mount'
alias chm='sudo chmod'
alias own='sudo -E chown $USER.$USER -Rv'
alias ownrv='sudo -E chown $USER.$USER -Rv'
alias goosxsdk108='cd /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk'
alias goosx='cd $ALIAS_ANDROID_DIR/osx'
alias exut=exit
alias pk9='sudo pkill -9'
alias binl=binless
alias binf=bingrep
alias setapp='update-alternative'
alias setgcc='sudo update-alternatives --config gcc'
alias setjava='sudo update-alternatives --config java && sudo update-alternatives --config javac && sudo update-alternatives --config javadoc'
alias addapp='sudo update-alternatives --install'
ENVSETUP=doenvsetup
export SDK=$ALIAS_ANDROID_DIR/sdk
export ANDROID_SDK=$ALIAS_ANDROID_DIR/sdk
export ANDROID_HOME=$SDK
export NDK=/android/ndk/current
PATH=/android/build/git-pastiche/bin:/android/bin:/android/lib:$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:/android/build/toolchains/arm-linux-androideabi-4.7/bin:$PATH
alias gh-commit='git commit -a && git push'
alias gh-push='git push'
alias c='cat'
alias gd='godir'
#alias cd='pushd'
#alias cd..='popd'
alias du0='du -h --max-depth=0 -c'
alias du1='du -h --max-depth=1 -c'
alias start-eclipse='$ALIAS_ANDROID_DIR/eclipse/eclipse &'
alias llt='ls -l --sort=time'
alias gpout='cd $ANDROID_PRODUCT_OUT'
alias gpoutsyspriv='cd $ANDROID_PRODUCT_OUT/system/priv-app'
alias gpoutkernel='cd $ANDROID_PRODUCT_OUT/obj/KERNEL_OBJ'
alias gpoutobj='cd $ANDROID_PRODUCT_OUT/obj'
alias gpoutobjlib='cd $ANDROID_PRODUCT_OUT/obj/lib'
alias gpoututils='cd $ANDROID_PRODUCT_OUT/utilities'
alias gpoutvendorlib='cd $ANDROID_PRODUCT_OUT/system/vendor/lib'
alias gpoutvendorlibhw='cd $ANDROID_PRODUCT_OUT/system/vendor/lib/hw'
alias gpoutvendorlibegl='cd $ANDROID_PRODUCT_OUT/system/vendor/lib/egl'
alias gpoutvendorbin='cd $ANDROID_PRODUCT_OUT/system/vendor/bin'
alias gpoutvendoretc='cd $ANDROID_PRODUCT_OUT/system/vendor/etc'
alias gowinbin='cd $REPO_DIR/windows'
alias goapk='cd $ALIAS_ANDROID_DIR/apk'
alias gogits='cd $ALIAS_ANDROID_DIR/REPO/gits'
alias gomusic='cd $REPO_DIR/music'
alias gpoutsys='cd $ANDROID_PRODUCT_OUT/system'
alias gpoutsysbin='cd $ANDROID_PRODUCT_OUT/system/bin'
alias gpoutsysxbin='cd $ANDROID_PRODUCT_OUT/system/xbin'
alias gpoutsysetc='cd $ANDROID_PRODUCT_OUT/system/etc'
alias gpoutsysapp='cd $ANDROID_PRODUCT_OUT/system/app'
alias gpoutsyslib='cd $ANDROID_PRODUCT_OUT/system/lib'
alias gpoutroot='cd $ANDROID_PRODUCT_OUT/root'
alias gpoutrecovery='cd $ANDROID_PRODUCT_OUT/recovery/root'
alias gpoutrootsbin='cd $ANDROID_PRODUCT_OUT/root/sbin'
alias gpoutrecoverysbin='cd $ANDROID_PRODUCT_OUT/recovery/root/sbin'
alias gpoutsyslibhw='cd $ANDROID_PRODUCT_OUT/system/lib/hw'
alias gpoutsyslibegl='cd $ANDROID_PRODUCT_OUT/system/lib/egl'
alias gpoutsyslibmod='cd $ANDROID_PRODUCT_OUT/system/lib/modules'
alias godown='cd $HOME/Downloads'
alias gokernels='cd $KERNELS_DIR'
alias golinuxkernel='cd $KERNELS_DIR/linux'
alias goandroidkernels='cd $ANDROID_KERNELS_DIR'
alias gho='cd $ANDROID_HOST_OUT'
alias ghobin='cd $ANDROID_HOST_OUT/bin'
alias gholib='cd $ANDROID_HOST_OUT/lib'
alias ghoobj='cd $ANDROID_HOST_OUT/obj'
alias ghowin='cd $ANDROID_BUILD_TOP/out/host/windows-x86'
alias ghowinbin='cd $ANDROID_BUILD_TOP/out/host/windows-x86/bin'
alias ghowinlib='cd $ANDROID_BUILD_TOP/out/host/windows-x86/lib'
alias gholin='cd $ANDROID_BUILD_TOP/out/host/linux-x86'

alias ghodar='cd $ANDROID_BUILD_TOP/out/host/darwin-x86'
alias mm16='mm -j16'

alias gbt='cd $ANDROID_BUILD_TOP'
alias gadb='cd $ANDROID_BUILD_TOP/system/core/adb'
alias gfb='cd $ANDROID_BUILD_TOP/system/core/fastboot'
alias gzlib='cd $ANDROID_BUILD_TOP/external/zlib'
alias gssl='cd $ANDROID_BUILD_TOP/external/openssl'
alias gbit='cd $ANDROID_BUILD_TOP/external/bootimage_utils'
alias gext='go_dir external'
alias gsys='go_dir system'
alias gsyscore='go_dir system/core'
alias gsysextras='go_dir system/extras'
alias gsysbluetooth='cd $ANDROID_BUILD_TOP/system/bluetooth'
alias gsyscoreroot='cd $ANDROID_BUILD_TOP/system/core/rootdir'
alias gsysroot='cd $ANDROID_BUILD_TOP/system/core/rootdir'
alias grecovery='go_dir bootable/recovery'
alias gdevelopment='go_dir development'

alias gkernel='go_android_dir kernel'
alias gkernelarchos='go_android_dir kernel/archos/archos_g9'
alias gdamazon='go_android_dir device/amazon'
alias gdamazonomap='go_android_dir device/amazon/omap4-common'
alias gdottercommon='go_android_dir device/amazon/otter-common'
alias gdotter='go_android_dir device/amazon/otter'
alias gdotter2common='go_android_dir device/amazon/otter-common'
alias gdotter2='go_android_dir device/amazon/otter'
alias gdomap='go_android_dir device/archos/omap4-common'
alias gdg9='go_android_dir device/archos/archos_g9'
alias gdarchos='go_android_dir device/archos/archos_g9'
alias gda80sboard='go_android_dir device/archos/a80sboard'
alias gda80sboardkernel='go_android_dir device/archos/a80sboard-kernel'
alias gdasusgrouper='go_android_dir device/asus/grouper'
alias gdasus='go_android_dir device/asus'
alias gdsamsung='go_android_dir device/samsung'
alias gdsamsungomap='go_android_dir device/samsung/omap4-common'
alias gdp1='go_android_dir device/samsung/p1'
alias gdlge='go_android_dir device/lge'
alias gdhammerhead='go_android_dir device/lge/hammerhead'
alias gdmako='go_android_dir device/lge/mako'
alias gdp1common='go_android_dir device/samsung/p1-common'
alias gdblazetab='go_android_dir device/ti/blaze_tablet'
alias gdev='go_android_dir device/*/`get_build_var TARGET_DEVICE`'
alias gbuild='go_android_dir build'
alias gbuild2='go_android_dir build2'
alias gbuildcombo='go_android_dir build/core/combo'
alias gbuildtools='go_android_dir build/tools'
alias gbuildcore='go_android_dir build/core'
alias gbuildcoretasks='go_android_dir build/core/tasks'
alias gkerneltask='$EDITOR $ANDROID_BUILD_TOP/build/core/tasks/kernel.mk'
alias gbuildboard='go_android_dir build/target/board'
alias gbuildproduct='go_android_dir build/target/product'
alias gbuildtarget='go_android_dir build/target'
alias grootdir='go_android_dir system/core/rootdir'
alias ghw='go_android_dir hardware'
alias ghwarchos='go_android_dir hardware/archos'
alias ghwti='go_android_dir hardware/ti'
alias ghwbc='go_android_dir hardware/broadcom'
alias ghwtiomap4xxx='go_android_dir hardware/ti/omap4xxx'
alias ghwtidomx='go_android_dir hardware/ti/domx'
alias ghwril='go_android_dir hardware/ril'
alias gti='go_android_dir device/ti'
alias gtiblaze='go_android_dir device/ti/blaze_tablet'
alias gsam='go_android_dir device/samsung'
alias ghtc='go_android_dir device/htc'
alias gbionic='go_android_dir bionic'
alias gprebuilts='go_android_dir prebuilts'
alias glibc='go_android_dir bionic/libc'
alias glibc86='go_android_dir bionic/libc/arch-x86'
alias glibc64='go_android_dir bionic/libc/arch-x86_64'
alias glibc86bionic='go_android_dir bionic/libc/arch-x86/bionic'
alias glibc64bionic='go_android_dir bionic/libc/arch-x86_64/bionic'
alias llibc86='ll $ANDROID_BUILD_TOP/bionic/libc/arch-x86'
alias llibc64='ll $ANDROID_BUILD_TOP/bionic/libc/arch-x86_64'
alias llibc86bionic='ll $ANDROID_BUILD_TOP/bionic/libc/arch-x86/bionic'
alias llibc64bionic='ll $ANDROID_BUILD_TOP/bionic/libc/arch-x86_64/bionic'


alias gktools='go_android_dir bionic/libc/kernel/tools'
alias gkheader='go_android_dir external/kernel-headers/original'
alias gkintel='go_android_dir kernel/intel'
alias gven='go_android_dir vendor'
alias gprebuilt='go_android_dir prebuilt'
alias ggog='go_android_dir device/google'
alias gdcommon='go_android_dir device/common'
alias gdgeneric='go_android_dir device/generic'
alias gmakefile='$EDITOR $ANDROID_BUILD_TOP/build/core/Makefile'
alias gfw='go_android_dir frameworks'
alias gfwbase='go_android_dir frameworks/base'
alias gfwbasecore='go_android_dir frameworks/base/core'
alias gfwnative='go_android_dir frameworks/native'
alias gfwnativeservices='go_android_dir frameworks/native/services'
alias gdalvik='go_android_dir dalvik'
alias gdalvikvm='go_android_dir dalvik/vm'
alias gdalvikvmnative='go_android_dir dalvik/vm/native'
alias grepo='go_android_dir .repo'
alias grepoprojects='go_android_dir .repo/projects'
alias gpackages='go_android_dir packages'
alias gapps='go_android_dir packages/apps'
alias glocalmanifests='go_android_dir .repo/local_manifests'
alias groomservice='$EDITOR $ANDROID_BUILD_TOP/.repo/local_manifests/roomservice.xml'
alias gboardconfigmk='get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/BoardConfig.mk'
alias gcmmk='get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/cm.mk'
alias gcmdeps='get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/cm.dependencies'
alias gdevicemk='get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/device.mk'
alias gandroidproductsmk='get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/AndroidProducts.mk'
alias gddir='go_android_dir device'
alias gfullmk='get_device && get_device_dir && $EDITOR $ALIAS_DEVICE_DIR/full_$ALIAS_DEVICE.mk'
alias gker='get_kernel_dir && cd $ALIAS_KERNEL_DIR'
alias gkerconfig='$EDITOR $ALIAS_KERNEL_DIR/arch/$(get_build_var TARGET_ARCH)/configs/$(get_build_var TARGET_KERNEL_CONFIG)'
alias README.md='less README.md'
alias gpl='cd $ALIAS_BUILD_DIR/android-paranoid && doenvsetup && lunch'  
alias gal='reset_paths && cd $ALIAS_BUILD_DIR/aosp && doenvsetup && lunch'
alias gul='reset_paths && cd $ALIAS_BUILD_DIR/android-aurora && doenvsetup && lunch'
alias gil='reset_paths && cd $ALIAS_BUILD_DIR/android-intel && doenvsetup && lunch'
alias g6l='reset_paths && cd $ALIAS_BUILD_DIR/android-armv6 && doenvsetup && lunch'
alias reposynclite='repo sync -j8 --no-tags --no-clone-bundle --current-branch'
alias reposynclitetrace='repo --trace sync -j8 --no-tags --no-clone-bundle --current-branch'

function g1l(){
    echo "ROM $1"
    ROM=""
    if [ ! -z $1 ] ; then
        ROM=cm_$1-userdebug
        echo "ROM $ROM"
    fi
	reset_paths

    cd $ALIAS_BUILD_DIR/android-cm && doenvsetup && lunch $ROM

	if [ -z "$ANDROID_BUILD_TOP" ] ; then
		export ANDROID_BUILD_TOP=$ALIAS_BUILD_DIR/android-cm
	fi

}

function g8l(){
	reset_paths
    cd $ALIAS_BUILD_DIR/android-x86 && doenvsetup && lunch $ROM
	if [ -z "$ANDROID_BUILD_TOP" ] ; then
		export ANDROID_BUILD_TOP=$ALIAS_BUILD_DIR/android-x86
	fi

}

function reset_paths(){
env -u ANDROID_BUILD_PATHS > /dev/null
env -u ANDROID_DEV_SCRIPTS  > /dev/null
env -u aospremote  > /dev/null
env -u cmremote  > /dev/null
env -u CM_BUILD  > /dev/null
env -u TARGET_PRODUCT  > /dev/null
env -u TARGET_GCC_VERSION  > /dev/null
env -u OPROFILE_EVENTS_DIR  > /dev/null
env -u ANDROID_PROMPT_PREFIX  > /dev/null
env -u ANDROID_EABI_TOOLCHAIN  > /dev/null
env -u TARGET_BUILD_TYPE  > /dev/null
env -u BUILD_ENV_SEQUENCE_NUMBER  > /dev/null
env -u TARGET_BUILD_VARIANT  > /dev/null
env -u ARM_EABI_TOOLCHAIN  > /dev/null
unset ANDROID_BUILD_TOP  > /dev/null
echo ANDROID_BUILD_TOP=$ANDROID_BUILD_TOP
unset ENVSETUP
unset addcompletions
unset add_lunch_combo cgrep check_product check_variant choosecombo chooseproduct choosetype choosevariant cproj croot findmakefile gdbclient gdbwrapper get_abs_build_var getbugreports get_build_var getlastscreenshot getprebuilt getscreenshotpath getsdcardpath gettargetarch gettop godir hmm isviewserverstarted jgrep key_back key_home key_menu lunch _lunch m mangrep mm mma mmm mmma pez pid printconfig print_lunch_menu resgrep runhat runtest sepgrep set_java_home setpaths set_sequence_number set_stuff_for_environment settitle smoketest stacks startviewserver stopviewserver systemstack tapas tracedmdump

env -u PATH  > /dev/null
export PATH=/android/bin:/android/lib:/usr/local/bin:/usr/bin:/bin:/usr/games
}

alias gll='reset_paths && cd $ALIAS_BUILD_DIR/linaro-android && doenvsetup  && lunch'  
alias gol='reset_paths && cd $ALIAS_BUILD_DIR/android-omapzoom && doenvsetup  && lunch'  
alias rpsytrace='repo --trace sync -j16'
alias rpsy='repo sync -j8'
alias rpinit-omni='repo init -u git://github.com/omnirom/android.git -b'
alias rpinit-pa='repo init -u git://github.com/ParanoidAndroid/manifest.git -b'
alias rpinit-cm='repo init  -u git://github.com/CyanogenMod/android.git -b'
alias rpinit-linaro='repo init -u git://android.git.linaro.org/platform/manifest.git -b'
alias rpinit-aosp='repo init  -u https://android.googlesource.com/platform/manifest -b'
alias rpinit-omap='repo init  -u git://git.omapzoom.org/platform/omapmanifest.git -b'
alias rpinit-intel='repo init  -u https://android-review.01.org/platform/manifest -b'
alias rpinit-x86='repo init  -u http://git.android-x86.org/platform/manifest -b'
alias rpman='repo manifest'
alias tm16='time m -j16'
alias tm16log='time m -j16 showcommands &> build.log | tail -f build.log'
alias mj16='time m -j16'
alias tm16ota='time m -j16 otapackage'
alias tm12='time make -j12'
alias tmk='time make'
alias mmsc='mm showcommands'

alias tlz='tar -ztvf'
alias tz='tar -zxvf'
alias tj='tar -jxvf'
alias tlj='tar -jtvf'

########## Quick Switch Common Directories ##################
alias gobuild='go_build_dir'
alias gotc='cd $TOOLCHAINS_DIR'
alias gows='cd $WORKSPACE_DIR'
alias gowsacm10='cd $WORKSPACE_DIR/archos/cm101'
alias godroid='cd $ALIAS_ANDROID_DIR'
alias govendor='go_vendor_dir'
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
alias cprvp='cp -rvp'
alias sucprvp='sudo cp -rvp'
alias cd-='cd -'
alias wgetf='wget -F'
alias androidsdk='$SDK/tools/android &'
 
alias 7d='7z d'
alias 7a='7z a'
alias 7x='7z x'
alias 7l='7z l'
alias 7u='7z u'
alias 7e='7z e'
alias g=$EDITOR
alias sug='sudo $EDITOR'


alias settings='$EDITOR $HOME/.bash_aliases &'
alias ls='ls --color'
alias ll='ls -l'
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
alias apt-code='$APT source'
alias aptin='sudo $APT install'
alias aptrein='sudo $APT --reinstall install'
alias aptinsug='sudo $APT --install-suggests install'
alias aptrm='sudo $APT remove'
alias aptup='sudo $APT update'
alias aptug='sudo $APT upgrade'
alias aptfind='_aptfind'
alias aptfin='aptfind'
alias aptfinless='_aptfindless'
alias aptinfo='apt-cache show'
alias aptcode='_aptcode'
alias aptfiles='apt-file list'
alias aptdl='apt-get download'
alias pacman='sudo pacman'
alias pacman-sync='sudo pacman -S'
alias pacman-list='sudo pacman -Ql'
alias pacman-man='man pacman'
alias qf='quick-find'
alias qfd='quick-find-dir'
alias ps='ps aux'


alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias fh='free -h'
alias dfh='df -h'
alias rmrf='rm -rf'
alias make-x86='CROSS_COMPILE= ARCH=x86 make -j16'
alias objdump-arm='$TOOLCHAINS_DIR/arm-eabi-4.7/bin/arm-eabi-objdump' 
alias make-and='ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LOCALVERSION_AUTO=n make -j16'
alias make-arm47='PATH=$TOOLCHAINS_DIR/arm-eabi-4.7/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make -j16'
alias make-archos='PATH=$TOOLCHAINS_DIR/archos_arm_toolchain/usr/bin:$PATH CC=arm-linux-uclibcgnueabi-cc ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-linux-uclibcgnueabi- LOCALVERSION_AUTO=n make -j16'
alias make-arm43='PATH=$TOOLCHAINS_DIR/arm-eabi-4.3.3/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias make-arm46='PATH=$TOOLCHAINS_DIR/arm-eabi-4.6/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias make-arm44='PATH=$TOOLCHAINS_DIR/arm-eabi-4.4.3/bin:$PATH  ARCH=arm SUBARCH=arm CROSS_COMPILE=arm-eabi- LOCALVERSION_AUTO=n make'
alias mkarchosconfig='gkernelarchos ; make-arm47 archos_g9_defconfig ; make-arm47 menuconfig ; cp .config arch/arm/configs/archos_g9_defconfig ; make-arm47 mrproper'
alias mkarchosconfignoproper='gkernelarchos; make-arm47 archos_g9_defconfig ; make-arm47 menuconfig ; cp .config arch/arm/configs/archos_g9_defconfig'
alias garchosconfig='$EDITOR $ANDROID_BUILD_TOP/kernel/archos/archos_g9/arch/arm/configs/archos_g9_defconfig'
alias udev-android='sug /etc/udev/rules.d/51-android.rules'
alias udev-reload='sudo udevadm control --reload-rules'
alias adbg='ADB_TRACE=all a'
alias lns='ln -s'

alias updaterscript='$EDITOR META-INF/com/google/android/updater-script'
alias ghome='cd $HOME'
alias diffy='colordiff -W130 --suppress-common-lines  -y'
alias less='less -r'
alias gstudio='cd /android/studio'
alias gorandom='cd $ALIAS_BUILD_DIR/random_and_useful'
alias xclip='xclip -selection c'
alias gowsarchos='cd $WORKSPACE_DIR/archos'
alias gowssamsung='cd $WORKSPACE_DIR/samsung'
alias govendorsamsung='go_vendor_dir samsung'
alias govendorsamsungp1='go_vendor_dir samsung/p1000'
alias govendorarchos='go_vendor_dir archos'
alias govendoramazon='go_vendor_dir amazon'
alias govendorasus='go_vendor_dir asus'
alias gvendorbroadcomm='go_dir vendor/broadcomm'
alias gvendorcm='go_dir vendor/cm'
alias gvendoromni='go_dir vendor/omni'
alias gvendorasus='go_dir vendor/asus'
alias gvendorcmconfig='go_dir vendor/cm/config'
alias gvendorelan='go_dir vendor/elan/config'
alias gvendorgoogle='go_dir vendor/google'
alias gvendorinvensense='go_dir vendor/invensense'
alias gvendormoto='go_dir vendor/moto'
alias gvendornvida='go_dir vendor/nvida'
alias gvendornxp='go_dir vendor/nxp'
alias gvendorqcom='go_dir vendor/qcom'
alias gvendorsamsung='go_dir vendor/samsung'
alias gvendorsony='go_dir vendor/sony'
alias gvendorti='go_dir vendor/ti'
alias gvendorimgtec='go_dir vendor/imgtec'
alias gvendorarchos='go_dir vendor/archos'
alias gvendortmobile='go_dir vendor/tmobile'
alias gvendorwidevine='go_dir vendor/widevine'
alias gvendor='go_dir vendor/'
alias gvendortrevd='go_dir vendor/trevd'


alias gotter='cd $ANDROID_BUILD_TOP/device/amazon/otter' 
alias inswifikey='a pu /android/apk/trevapps/RouterKeygen.dic /sdcard/ ; a ins /android/apk/trevapps/RouterKeygen.apk ; a wifikey ;'
alias xclip-cwd='echo $PWD | xclip'
alias www=x-www-browser
#alias display='gm display'
alias mkkerdevconfig='cd $(get_abs_build_var TARGET_KERNEL_SOURCE) && make-arm47 $(get_build_var TARGET_KERNEL_CONFIG) && make-arm47 menuconfig && cp -i .config $(get_abs_build_var TARGET_KERNEL_SOURCE)/arch/arm/configs/$(get_build_var TARGET_KERNEL_CONFIG)' 
alias d2h='dec2hex'
alias h2d='hex2dec'



alias fif='ag'

alias gbsd='cd $ALIAS_BUILD_DIR/freebsd'

alias gasm='cd $ALIAS_BUILD_DIR/asm'

alias dasm='objdump --disassemble'
alias gsyscorelibcutils='cd $ANDROID_BUILD_TOP/system/core/libcutils'
alias gsyscoreliblog='cd $ANDROID_BUILD_TOP/system/core/liblog'
alias goamd64='cd $ALIAS_BUILD_DIR/amd64'
alias golibc='reset_paths && $ALIAS_BUILD_DIR/olibc && doenvsetup && lunch'
alias gacp='cd $ANDROID_BUILD_TOP/build/tools/acp'
alias gbuildhost='cd $ANDROID_BUILD_TOP/build/libs/host'
alias gstdc='cd $ALIAS_BUILD_DIR/std-c-libs'
alias README='less README'
alias INSTALL='less INSTALL'
alias conf='./configure'
alias configure-help='./configure --help'
alias conf32='LDFLAGS='-m32' CFLAGS='-m32' ./configure'
alias autog32='LDFLAGS='-m32' CFLAGS='-m32' ./autogen.sh'
alias gbionic='cd $ANDROID_BUILD_TOP/bionic'
alias gbioniclc='cd $ANDROID_BUILD_TOP/bionic/libc'
alias gbioniclcarch='cd $ANDROID_BUILD_TOP/bionic/libc/arch-$TARGET_ARCH'
alias gbioniclck='cd $ANDROID_BUILD_TOP/bionic/libc/kernel/'
alias gbioniclcktools='cd $ANDROID_BUILD_TOP/bionic/libc/kernel/tools'
alias gbionicdl='cd $ANDROID_BUILD_TOP/bionic/libdl'
alias groomservice='$EDITOR $ANDROID_BUILD_TOP/.repo/local_manifests/roomservice.xml'
alias rmroomservice='rm $ANDROID_BUILD_TOP/.repo/local_manifests/roomservice.xml'
alias gmanifest='$EDITOR $ANDROID_BUILD_TOP/.repo/manifest.xml'
alias grepomanifest='cd $ANDROID_BUILD_TOP/.repo/manifests'
alias mkdir='mkdir -pv'
alias lsdown='ls $ALIAS_DOWNLOAD_DIR'
alias symlink='make_symlink'
alias filecd='file *'
alias debcon='dpkg-deb --contents'
alias debx='dpkg-deb --extract'
alias debh='dpkg-deb --help'
alias dpkgh='dpkg --help'
alias rm='rm -v'

alias xv='xclip-pastefile'
alias xx='xclip-cutfile'
alias xc='xclip-copyfile'

alias gbuildmainmk="$EDITOR $ANDROID_BUILD_TOP/build/core/main.mk"
alias gdbx="gdb -x $ALIAS_BUILD_DIR/random_and_useful/start_gdb" 

alias goandroid="cd /android"
alias gorepo="cd /REPO"
alias gorepovbox="cd /REPO/vbox"
alias stop='sudo stop'
alias start='sudo start'
alias restart='sudo restart'
alias getcol='get_column'
alias gbuildandroidinfo='cd $ALIAS_BUILD_DIR/android-info'
alias updategrub='sudo update-grub2'
alias qemu-start='qemu-system-x86_64 -cpu qemu64 -m 2G -serial stdio -smp 4 -initrd'
alias externalip='curl ifconfig.me'
alias untar='tar -xvf'
export NEXUS_BINARY_DIRECTORY=/vendor/nexus-binaries
export NEXUS_FACTORY_IMAGES_DIRECTORY=/vendor/nexus-images
alias gonexusbinaries="cd $NEXUS_BINARY_DIRECTORY"
alias gonexusimages="cd $NEXUS_FACTORY_IMAGES_DIRECTORY"
alias lsexec='find ./  -maxdepth 1 -type f -executable'
alias mkrecoveryrd='cd $ANDROID_PRODUCT_OUT/recovery && mkbootfs root | gzip > ../ramdisk-recovery.img'
alias mkandroidrd='cd $ANDROID_PRODUCT_OUT && mkbootfs root | gzip > ramdisk.img'
alias agi='ag -i'

#find $NEXUS_BINARY_DIRECTORY -iname "*`get_build_var TARGET_DEVICE`*$ANDROID_BUILD_NUMBER" -exec tar -xzvf {} \; && find $PWD -maxdepth 1 -iname "extract-*-`get_build_var TARGET_DEVICE`.sh" -exec sh -c "rm {}.tgz ;  sed -n '/\x1f\x8b/,$ p'
function import_nexus_binaries(){
	find $NEXUS_BINARY_DIRECTORY -iname "*$1*$2" -exec tar -xzvf {} \; && find $PWD -maxdepth 1 -iname "extract-*-$1.sh" -exec sh -c "rm {}.tgz ;  sed -n '/\x1f\x8b/,$ p' {} > {}.tgz && tar xvzf {}.tgz ; rm {} {}.tgz" \; 
}


# some archos lazyness 
function kdflashpush(){

	adb remount / && \
	adb push kernel /k && \
	adb push ramdisk.img /i && \
	adb shell kd_flasher -k k -i i
	
}
alias kdflash='adb shell kd_flasher -k k -i i'

alias mmwin='USE_MINGW=true mm'