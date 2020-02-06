#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
wget -O- https://github.com/coolsnowwolf/lede/commit/e6ef0d1d73a4b3d4feaae55c86d68474700526d1.patch | patch -p1
