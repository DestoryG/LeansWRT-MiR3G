#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/KERNEL_PATCHVER:=5\.4/KERNEL_PATCHVER:=5.10/' target/linux/ramips/Makefile
sed -i "s/set system.@system\[-1\].hostname='OpenWrt'/set system.@system[-1].hostname='DGWrt'/" package/base-files/files/bin/config_generate
#mv 322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/
mv files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/
rm -rf package/feeds/routing/batman-adv
mv files/batman-adv package/feeds/routing
rm feeds/packages/lang/lua-eco/Makefile
wget https://raw.githubusercontent.com/zhaojh329/lua-eco/openwrt-package/Makefile -O feeds/packages/lang/lua-eco/Makefile
rm package/feeds/packages/rust/Makefile
mv files/rustfix/Makefile package/feeds/packages/rust
git clone https://github.com/sbwml/luci-app-alist package/alist
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git packages
sudo apt install libfuse-dev
rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt -b packages-24.10 feeds/packages/lang/node
