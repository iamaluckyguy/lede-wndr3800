#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

./scripts/feeds update -a
./scripts/feeds install -a
#解决sfe和mwan3的冲突补丁
#wget -O- https://github.com/coolsnowwolf/lede/commit/e6ef0d1d73a4b3d4feaae55c86d68474700526d1.patch | patch -p1
sed -i '/^config internal themes/ a\        option Bootstrap "/luci-static/bootstrap"\n        option Netgear "/luci-static/netgear"' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/KERNEL_PATCHVER:=4.9/KERNEL_PATCHVER:=4.14/g' target/linux/ar71xx/Makefile

#smartdns
WORKINGDIR="`pwd`/feeds/packages/net/smartdns"
mkdir $WORKINGDIR -p
rm $WORKINGDIR/* -fr
wget https://github.com/pymumu/openwrt-smartdns/archive/master.zip -O $WORKINGDIR/master.zip
unzip $WORKINGDIR/master.zip -d $WORKINGDIR
mv $WORKINGDIR/openwrt-smartdns-master/* $WORKINGDIR/
rmdir $WORKINGDIR/openwrt-smartdns-master
rm $WORKINGDIR/master.zip

LUCIBRANCH="lede" #更换此变量
WORKINGDIR="`pwd`/feeds/luci/applications/luci-app-smartdns"
mkdir $WORKINGDIR -p
rm $WORKINGDIR/* -fr
wget https://github.com/pymumu/luci-app-smartdns/archive/${LUCIBRANCH}.zip -O $WORKINGDIR/${LUCIBRANCH}.zip
unzip $WORKINGDIR/${LUCIBRANCH}.zip -d $WORKINGDIR
mv $WORKINGDIR/luci-app-smartdns-${LUCIBRANCH}/* $WORKINGDIR/
rmdir $WORKINGDIR/luci-app-smartdns-${LUCIBRANCH}
rm $WORKINGDIR/${LUCIBRANCH}.zip

#更改luci.mk此行
sed -i 's/LUCI_DEPENDS:=+luci-compat +smartdns/LUCI_DEPENDS:=smartdns/g' feeds/luci/applications/luci-app-smartdns/Makefile
sed -i 's/include ..\/..\/luci.mk/include $(TOPDIR)\/feeds\/luci\/luci.mk/g' feeds/luci/applications/luci-app-smartdns/Makefile

echo "src-git helloworld https://github.com/fw876/helloworld" >> feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a
