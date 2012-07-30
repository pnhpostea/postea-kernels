How to build Mobule for Platform
- It is only for modules are needed to using Android build system.
- Please check its own install information under its folder for other module.

[Step to build]
1. Get android open source.
    : version info - Android gingerbread 4.0.3
    ( Download site : http://source.android.com )

2. Copy module that you want to build - to original android open source
   If same module exist in android open source, you should replace it. (no overwrite)
   
  # It is possible to build all modules at once.
  
3. Check module is in 'build\core\user_tags.mk'
   If not, you should add your module name in it.
ex1) external\libjpega : Write "libjpega \" into "build\core\user_tags.mk"
ex2) external\libexifa : Write "libexifa \" into "build\core\user_tags.mk"

4. In case of 'external\bluetooth',
   you should add following text in 'build\target\board\generic\BoardConfig.mk'
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

5. excute build command
   ./build.sh user
