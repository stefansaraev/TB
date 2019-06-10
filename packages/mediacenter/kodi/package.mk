# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="kodi"
PKG_VERSION="1eff5afda0"
PKG_SITE="https://github.com/xbmc/xbmc/tree/master"
PKG_URL="https://github.com/xbmc/xbmc/archive/$PKG_VERSION.tar.gz"

PKG_DEPENDS_TARGET="
  $PKG_DEPENDS_TARGET
  flatbuffers:host kodi:host
  alsa-lib curl flatbuffers fmt ffmpeg freetype fribidi fstrcmp libass
  lzo pcre rapidjson sqlite taglib tinyxml
  eudev libinput libxkbcommon
  $OPENGLES
"

PKG_CMAKE_OPTS_TARGET="
  -DNATIVEPREFIX=$TOOLCHAIN
  -DWITH_ARCH=$TARGET_ARCH
  -DGIT_VERSION=$PKG_VERSION

  # kod.bin
  -DENABLE_APP_AUTONAME=OFF

  # build specifics
  -DWITH_JSONSCHEMABUILDER=$TOOLCHAIN/bin/JsonSchemaBuilder
  -DENABLE_CCACHE=OFF
  -DENABLE_LDGOLD=OFF
  -DENABLE_INTERNAL_FFMPEG=OFF

  # platform
  -DCORE_PLATFORM_NAME=gbm
  -DGBM_RENDER_SYSTEM=gles
  -DENABLE_VAAPI=OFF

  # audio
  -DENABLE_ALSA=ON
  -DENABLE_PULSEAUDIO=OFF
  -DENABLE_SNDIO=OFF

  # other
  -DENABLE_AIRTUNES=OFF
  -DENABLE_AVAHI=OFF
  -DENABLE_BLUETOOTH=OFF
  -DENABLE_BLURAY=OFF
  -DENABLE_CAP=OFF
  -DENABLE_CEC=OFF
  -DENABLE_CLANGFORMAT=OFF
  -DENABLE_DBUS=OFF
  -DENABLE_EVENTCLIENTS=OFF
  -DENABLE_LCMS2=OFF
  -DENABLE_LIRCCLIENT=OFF
  -DENABLE_MDNS=OFF
  -DENABLE_MICROHTTPD=OFF
  -DENABLE_MARIADBCLIENT=OFF
  -DENABLE_MYSQLCLIENT=OFF
  -DENABLE_NFS=OFF
  -DENABLE_OPTICAL=OFF
  -DENABLE_PLIST=OFF
  -DENABLE_PYTHON=OFF
  -DENABLE_SMBCLIENT=OFF
  -DENABLE_UDEV=ON
  -DENABLE_UPNP=OFF
  -DENABLE_XSLT=OFF
"

pre_configure_host() {
  rm -rf $PKG_BUILD_SUBDIR
  # needed only for python
  sed -e "s/PROPERTIES ENABLE_EXPORTS ON/PROPERTIES ENABLE_EXPORTS OFF/g" \
      -i $PKG_BUILD/CMakeLists.txt
}

configure_host() {
  mkdir -p tools/depends/native/JsonSchemaBuilder/bin && cd $_
  cmake ..
}

makeinstall_host() {
  cp $PKG_BUILD/tools/depends/native/JsonSchemaBuilder/bin/JsonSchemaBuilder $TOOLCHAIN/bin
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/*/xbmc*
  rm -rf $INSTALL/usr/bin/kodi
  rm -rf $INSTALL/usr/bin/kodi-standalone
  rm -rf $INSTALL/usr/lib/firewalld
  rm -rf $INSTALL/usr/lib/kodi/*.cmake
  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/kodi/addons/audioencoder.*
  rm -rf $INSTALL/usr/share/kodi/addons/game.*
  rm -rf $INSTALL/usr/share/kodi/addons/resource.images.*
  rm -rf $INSTALL/usr/share/kodi/addons/resource.uisounds.*
  rm -rf $INSTALL/usr/share/kodi/addons/script.module.pil
  rm -rf $INSTALL/usr/share/kodi/addons/script.module.pycryptodome
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/skin.*
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.*
  rm -rf $INSTALL/usr/share/kodi/addons/webinterface.*
  rm -rf $INSTALL/usr/share/kodi/cmake
  rm -rf $INSTALL/usr/share/kodi/media/icon*
  rm -rf $INSTALL/usr/share/kodi/system/certs/cacert.pem
  rm -rf $INSTALL/usr/share/kodi/system/IRSSmap.xml
  rm -rf $INSTALL/usr/share/kodi/system/keymaps/{customcontroller*,gamepad*,joystick*,nyxboard,touchscreen*,wetek-play}
  rm -rf $INSTALL/usr/share/kodi/system/Lircmap.xml
  rm -rf $INSTALL/usr/share/kodi/system/python
  rm -rf $INSTALL/usr/share/kodi/system/settings/{android*,darwin*,freebsd*,imx6*,rbp*,wayland*,win*,x11*,aml-linux*}
  rm -rf $INSTALL/usr/share/kodi/system/X10-Lola-IRSSmap.xml
  rm -rf $INSTALL/usr/share/kodi/userdata/iOS
  rm -rf $INSTALL/usr/share/kodi/userdata/ModeLines_template.xml
  rm -rf $INSTALL/usr/share/xsessions

  # remove languages
  rm -rf $INSTALL/usr/share/kodi/addons/*/resources/language/*\(*\)*
  find $INSTALL/usr/share/kodi/addons -name strings.po | grep -Ev "English|resource.language.en_gb" | xargs rm -f {} \;

  # too much library nodes...
  rm -rf $INSTALL/usr/share/kodi/system/library/music/{musicroles,musicvideos,top100}
  KEEP="addons.xml albums.xml artists.xml files.xml index.xml movies.xml musicvideos.xml
        playlists.xml sets.xml titles.xml tvshows.xml"
  for node in $(find $INSTALL/usr/share/kodi/system/library -type f -name "*.xml"); do
    for keep in $KEEP ; do
      [ "$(basename $node)" = "$keep" ] && continue 2
    done
    rm -f $node
  done
  ln -sf ../files.xml $INSTALL/usr/share/kodi/system/library/video/movies/files.xml
  ln -sf ../files.xml $INSTALL/usr/share/kodi/system/library/video/tvshows/files.xml
  ln -sf ../addons.xml $INSTALL/usr/share/kodi/system/library/video/movies/addons.xml
  ln -sf ../addons.xml $INSTALL/usr/share/kodi/system/library/video/tvshows/addons.xml

  # update addon manifest
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  sed -e "/>audioencoder./d" \
      -e "/>game./d" \
      -e "/>resource.images./d" \
      -e "/>resource.uisounds./d" \
      -e "/>script.module.pil/d" \
      -e "/>script.module.pycryptodome/d" \
      -e "/>service.xbmc.versioncheck/d" \
      -e "/>skin./d" \
      -e "/>xbmc.json/d" \
      -e "/>webinterface./d" \
      -i $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.saraev.ca" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "skin.tb" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "tb.settings" $ADDON_MANIFEST

  # distro splash / skin
  rm -f $INSTALL/usr/share/kodi/media/splash.jpg
  cp $ROOT/config/splash/splash.png $INSTALL/usr/share/kodi/media/splash.png
  sed "s|skin.estuary|skin.tb|g" -i $INSTALL/usr/share/kodi/system/settings/settings.xml

  # set repo url
  sed -e "s|@OS_VERSION@|$OS_VERSION|g" \
      -e "s|@ADDON_URL@|$ADDON_URL|g" \
      -i $INSTALL/usr/share/kodi/addons/repository.saraev.ca/addon.xml
}
