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
cd package/lean
git clone https://github.com/pymumu/smartdns.git
svn checkout https://github.com/Lienol/openwrt/trunk/package/lean/luci-app-smartdns
cd ../..
./scripts/feeds update -a
./scripts/feeds install -a
