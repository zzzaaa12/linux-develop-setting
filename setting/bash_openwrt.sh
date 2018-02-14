alias maket='make target/install V=s'
alias makev='make V=s'
alias makem='make menuconfig'

# error messages
cannot_find_top="error: Cannot find OpenWrt TopDir"
cannot_find_prj="error: Cannot find project folder"
cannot_find_rootfs="error: Cannot find rootfs folder"
no_pkg_name="no package!!!"
nothing_to_makr="error: nothing to make"
here_not_opnewrt_root="error: here is NOT OpenWrt TopDir!!!"
here_is_openwrt_root="error: here is OpenWrt TopDir!!!"
finding="Finding, please wait it..."

# colorful echo
COLOR_END='\e[0m'
GREEN='\e[1;32m';
RED='\e[1;31m';
YELLOW='\e[1;33m';

function echo_green() {
	echo -e ${GREEN}$@${COLOR_END}
}

function echo_error() {
	echo -e ${RED}$@${COLOR_END}
}

function echo_info() {
	echo -e ${GREEN}$@${COLOR_END}
}

function goto_target() {
	echo "last_path: $last_path" && \
	cd $target_path && \
	echo_info "change to: $target_path"
}

# make package/xxx/prepare V=s
function makep() {
	if [ "$(is_sdk_top)" = "no" -o "$1" = "" ]; then
		echo_error $nothing_to_make
		return
	fi
	make package/$1/prepare V=s
}

# make package/xxx/prepare V=s
function makec() {
	if [ "$(is_sdk_top)" = "no" -o "$1" = "" ]; then
		echo_error $nothing_to_make
		return
	fi
	make package/$1/compile V=s
}

# make package/xxx/install V=s
function makei() {
	if [ "$(is_sdk_top)" = "no" -o "$1" = "" ]; then
		echo_error $nothing_to_make
		return
	fi
	make package/$1/install V=s
}

# make package/xxx/clean V=s
function make_clean() {
	if [ "$(is_sdk_top)" = "no" -o "$1" = "" ]; then
		echo_error $nothing_to_make
		return
	fi
	make package/$1/clean V=s
}

# make target/linux/{clean,compile}
function make_kernel() {
	make target/linux/{clean,compile} V=s
}

function is_sdk_top() {
	check1="$(ls rules.mk 2>/dev/null)"
	check2="$(ls package 2>/dev/null)"
	if [ "$check1" != "" -a "$check2" != "" ]; then
		echo "yes"
	else
		echo "no"
	fi
}

# cd to OpenWRT TopDir
function cdtop() {
	last_path="$(pwd)"
	current="${PWD##*/}"
	cd_path=""
	hide="$1"

	if [ "$(is_sdk_top)" = "yes" -a "$hide" != "1" ]; then
		echo_error "$here_is_openwrt_root"
		return
	fi

	ls_path=""
	level="$(pwd | sed 's/^\///g' | tr '\n' '\0' | tr '/' '\n'  | wc -l)"
	for i in $(seq 1 $level)
	do
		ls_path="$ls_path../"
		check1="$(ls $ls_path/rules.mk 2>/dev/null)"
		check2="$(ls $ls_path/package 2>/dev/null)"
		if [ "$check1" != "" -a "$check2" != "" ]; then
			cd_path="$ls_path"
		fi
	done

	if [ "$cd_path" != "" ]; then
		if [ "$hide" != "1" ]; then
			target_path=$cd_path
			goto_target
		else
			cd $cd_path
		fi
	else
		if [ "$hide" != "1" ]; then
			echo_error $cannot_find_top
		else
			echo $cannot_find_top
		fi
	fi
}

# cd to rootfs folder
function cdroot() {
	echo_green $finding
	echo ""
	last_path="$(pwd)"
	if [ "$(is_sdk_top)" = "no" ]; then
		if [ "$(cdtop 1)" = "$cannot_find_top" ]; then
			echo $cannot_find_top
			return
		fi
		cdtop 1
	fi

	rootfs_path=$(find build_dir -type d -name root-*)

	if [ "$rootfs_path" = "" ]; then
		echo_red "$cannot_find_rootfs"
		cd $last_path
		return
	fi

	target_path=$(pwd)/$rootfs_path
	goto_target
}
