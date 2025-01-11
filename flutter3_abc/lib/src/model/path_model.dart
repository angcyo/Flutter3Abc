part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/17
///

/// # TargetPlatform.android
/// ```
///   getTemporaryDirectory->/data/user/0/com.angcyo.flutter3_abc/cache
///   getApplicationSupportDirectory->/data/user/0/com.angcyo.flutter3_abc/files
///   getLibraryDirectory->null
///   getApplicationDocumentsDirectory->/data/user/0/com.angcyo.flutter3_abc/app_flutter
///   getApplicationCacheDirectory->/data/user/0/com.angcyo.flutter3_abc/cache
///   getExternalStorageDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3_abc/files
///   externalCacheDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3_abc/cache
///   getDownloadsDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3_abc/files/downloads
///   current->/
///   systemTemp->/data/user/0/com.angcyo.flutter3_abc/code_cache
/// ```
/// ## Debug
/// ```
/// 默认文件路径->/storage/emulated/0/Android/data/com.angcyo.flutter3.abc/files
/// 默认缓存路径->/storage/emulated/0/Android/data/com.angcyo.flutter3.abc/cache
/// getTemporaryDirectory->/data/user/0/com.angcyo.flutter3.abc/cache
/// getApplicationSupportDirectory->/data/user/0/com.angcyo.flutter3.abc/files
/// getLibraryDirectory->null
/// getApplicationDocumentsDirectory->/data/user/0/com.angcyo.flutter3.abc/app_flutter
/// getApplicationCacheDirectory->/data/user/0/com.angcyo.flutter3.abc/cache
/// getExternalStorageDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3.abc/files
/// externalCacheDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3.abc/cache
/// getDownloadsDirectory->/storage/emulated/0/Android/data/com.angcyo.flutter3.abc/files/downloads
/// current->/
/// systemTemp->/data/user/0/com.angcyo.flutter3.abc/code_cache
/// ```
/// ## Release 之后
/// 需要添加混淆规则`-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin`
///
/// # TargetPlatform.windows "Windows 10 Pro" 10.0 (Build 19045)
///
/// ```
/// resolvedExecutable->E:\FlutterProjects\Flutter3DesktopAbc\build\windows\x64\runner\Debug\flutter3_desktop_abc_bn.exe
/// script->E:\FlutterProjects\Flutter3DesktopAbc\main.dart
/// executable->flutter3_desktop_abc_bn.exe
/// 默认文件路径->C:\Users\angcy\AppData\Local\Temp
/// 默认缓存路径->C:\Users\angcy\AppData\Local\Temp
/// getTemporaryDirectory->C:\Users\angcy\AppData\Local\Temp
/// getApplicationSupportDirectory->C:\Users\angcy\AppData\Roaming\com.angcyo.flutter3.desktop.abc\flutter3_desktop_abc_pn
/// getLibraryDirectory->null
/// getApplicationDocumentsDirectory->C:\Users\angcy\Documents
/// getApplicationCacheDirectory->C:\Users\angcy\AppData\Local\com.angcyo.flutter3.desktop.abc\flutter3_desktop_abc_pn
/// getExternalStorageDirectory->null
/// externalCacheDirectory->null
/// getDownloadsDirectory->C:\Users\angcy\Downloads
/// current->E:\FlutterProjects\Flutter3DesktopAbc
/// systemTemp->C:\Users\angcy\AppData\Local\Temp
/// ```
///
/// # TargetPlatform.windows "Windows 10 Pro" 10.0 (Build 22631) XLB-20240902UHB
/// ```
/// resolvedExecutable->E:\projects\flutter\Flutter3DesktopAbc\build\windows\x64\runner\Debug\flutter3_desktop_abc_bn.exe
/// script->E:\projects\flutter\Flutter3DesktopAbc\main.dart
/// executable->flutter3_desktop_abc_bn.exe
/// 默认文件路径->C:\Users\ADMINI~1\AppData\Local\Temp
/// 默认缓存路径->C:\Users\ADMINI~1\AppData\Local\Temp
/// getTemporaryDirectory->C:\Users\ADMINI~1\AppData\Local\Temp
/// getApplicationSupportDirectory->C:\Users\Administrator\AppData\Roaming\com.angcyo.flutter3.desktop.abc\flutter3_desktop_abc_pn
/// getLibraryDirectory->null
/// getApplicationDocumentsDirectory->D:\文档
/// getApplicationCacheDirectory->C:\Users\Administrator\AppData\Local\com.angcyo.flutter3.desktop.abc\flutter3_desktop_abc_pn
/// getExternalStorageDirectory->null
/// externalCacheDirectory->null
/// getDownloadsDirectory->C:\Users\Administrator\Downloads
/// current->E:\projects\flutter\Flutter3DesktopAbc
/// systemTemp->C:\Users\ADMINI~1\AppData\Local\Temp
/// ```
///
/// # TargetPlatform.macOS Version 15.2 (Build 24C101) angcyo-m2-Max.local
///
/// ```
/// resolvedExecutable->/Users/angcyo/project/Flutter/Flutter3DesktopAbc/build/macos/Build/Products/Debug/flutter3_desktop_abc.app/Contents/MacOS/flutter3_desktop_abc
/// script->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/main.dart
/// executable->/Users/angcyo/project/Flutter/Flutter3DesktopAbc/build/macos/Build/Products/Debug/flutter3_desktop_abc.app/Contents/MacOS/flutter3_desktop_abc
/// 默认文件路径->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library/Application Support/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc
/// 默认缓存路径->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library/Caches
/// getTemporaryDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library/Caches
/// getApplicationSupportDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library/Application Support/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc
/// getLibraryDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library
/// getApplicationDocumentsDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Documents
/// getApplicationCacheDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Library/Caches/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc
/// getExternalStorageDirectory->null
/// externalCacheDirectory->null
/// getDownloadsDirectory->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/Downloads
/// current->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data
/// systemTemp->/Users/angcyo/Library/Containers/com.angcyo.flutter3.desktop.abc.flutter3DesktopAbc/Data/tmp
/// ```
///
class PathViewModel extends ViewModel {
  /// [String]
  /// [Directory]
  final MutableLiveData<Map<String, Directory?>?> pathMap = vmData();

  Future<void> loadPath() async {
    Directory? temporaryDirectory;
    try {
      temporaryDirectory = await getTemporaryDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? applicationSupportDirectory;
    try {
      applicationSupportDirectory = await getApplicationSupportDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? libraryDirectory;
    try {
      //Unsupported operation: getLibraryPath is not supported on Android
      libraryDirectory = await getLibraryDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? applicationDocumentsDirectory;
    try {
      applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? applicationCacheDirectory;
    try {
      applicationCacheDirectory = await getApplicationCacheDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? externalStorageDirectory;
    try {
      externalStorageDirectory = await getExternalStorageDirectory();
    } catch (e, s) {
      //PlatformException(channel-error, Unable to establish connection on channel: "dev.flutter.pigeon.path_provider_android.PathProviderApi.getExternalStoragePath"., null, null)
      printError(e, s);
    }
    Directory? externalCacheDirectory;
    try {
      externalCacheDirectory =
          (await getExternalCacheDirectories())?.firstOrNull;
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }
    Directory? downloadsDirectory;
    try {
      downloadsDirectory = await getDownloadsDirectory();
    } catch (e) {
      assert(() {
        l.e(e);
        return true;
      }());
    }

    pathMap.value = {
      'resolvedExecutable': Platform.resolvedExecutable.directory(),
      'script': Platform.script.filePath.directory(),
      //可执行的程序名称, 非路径
      'executable': Platform.executable.directory(),
      '默认文件路径': await fileDirectory(),
      '默认缓存路径': await cacheDirectory(),
      'getTemporaryDirectory': temporaryDirectory ?? Directory('null'),
      'getApplicationSupportDirectory':
          applicationSupportDirectory ?? Directory('null'),
      'getLibraryDirectory': libraryDirectory ?? Directory('null'),
      'getApplicationDocumentsDirectory':
          applicationDocumentsDirectory ?? Directory('null'),
      'getApplicationCacheDirectory':
          applicationCacheDirectory ?? Directory('null'),
      'getExternalStorageDirectory':
          externalStorageDirectory ?? Directory('null'),
      'externalCacheDirectory': externalCacheDirectory ?? Directory('null'),
      //'getExternalCacheDirectories': await getExternalCacheDirectories()?? Directory('null'),
      'getDownloadsDirectory': downloadsDirectory ?? Directory('null'),
      'current': Directory.current,
      'systemTemp': Directory.systemTemp,
    };
  }
}
