#!/bin/sh

device=$2

if [ "$1" = "diy" ]; then
cat << EOF | sh
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile 
sed -i 's/os.date(/&"%Y-%m-%d %H:%M:%S"/' package/lean/autocore/files/x86/index.htm
rm -rf ./package/base-files/files/etc/banner
rm -rf ./feeds/luci/themes
rm -rf ./feeds/luci/applications/luci-app-argon-config
find ./feeds/chajian1 -name "*luci-theme*" -type d -exec rm -rf {} \;
find .package/small-package -name "*luci-theme*" -type d -exec rm -rf {} \;
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/luci-app-argon-config
curl -f -L https://github.com/Joshua-DinG/Build-OpenWRT/raw/main/firmware/banner/banner -o ./package/base-files/files/etc/banner
sed -i -e '$i\' -e "s/Year/$(TZ=':Asia/Shanghai' date '+%Y')/g" package/base-files/files/etc/banner
curl -f -L https://github.com/Joshua-DinG/Build-OpenWRT/raw/main/argon/bg1.jpg -o ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
curl https://raw.githubusercontent.com/Joshua-DinG/DinG/main/bash/123.py | python3 -
svn co https://github.com/Joshua-DinG/Build-OpenWRT/trunk/argon/video/default ./package/luci-theme-argon/htdocs/luci-static/argon/background/
rm -rf ./package/luci-theme-argon/htdocs/luci-static/argon/background/.svn/
EOF
fi

# Uncomment a feed source
##sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#sed -i '1i src-git haibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
# LINUX_VERSION
#sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(LINUX_VERSION)-/g' include/image.mk
# 关闭串口跑码
#sed -i 's/console=tty0//g'  target/linux/x86/image/Makefile
#sed -i 's/%V, %C/[Year] | by Jason /g' package/base-files/files/etc/banner
#sed -i "s/Year/$(TZ=':Asia/Shanghai' date '+%Y')/g" package/base-files/files/etc/banner
#sed -i '/logins./a\                                          by Jason' package/base-files/files/etc/profile
# Modify default passwd
#sed -i '/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./ d' package/lean/default-settings/files/zzz-default-settings
# ID
#sed -i "s/DISTRIB_REVISION='R.*.*.[0-9]/& Compiled by Jason/" package/lean/default-settings/files/zzz-default-settings
#svn co https://github.com/Joshua-DinG/Build-OpenWRT/trunk/firmware/banner ./package/base-files/files/etc/
#rm -rf ./package/base-files/files/etc/.svn/

if [ "$device" = "Build-x86" ]; then
  echo "$(cat "$GITHUB_WORKSPACE/firmware/X86" "$GITHUB_WORKSPACE/firmware/Generic")" >> ./.config
elif [ "$device" = "Build-R2S" ]; then
   echo "$(cat "$GITHUB_WORKSPACE/firmware/R2S" "$GITHUB_WORKSPACE/firmware/Generic")" >> ./.config
elif [ "$device" = "Build-R4S" ]; then
  echo "$(cat "$GITHUB_WORKSPACE/firmware/R4S" "$GITHUB_WORKSPACE/firmware/Generic")" >> ./.config
fi

file_name3="DinG"
if [ -n "$3" ]; then
  file_name3="$3"
  sed -i "5i uci set system.@system[0].hostname=${file_name3}" package/lean/default-settings/files/zzz-default-settings
fi

file_name4="10.8.8.8"
if [ -n "$4" ]; then
  file_name4="$4"
  sed -i "s/192.168.1.1/${file_name4}/g" package/base-files/files/bin/config_generate
fi

if [ "$5" = "true" ]; then
  sed -i s/5.15/6.1/g  ./target/linux/x86/Makefile
fi
