part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/17
///

///
/// ```
/// TargetPlatform.android
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
/// # Debug
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
/// # Release 之后
/// 需要添加混淆规则`-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin`
/// ```
/// 默认文件路径->/data/user/0/com.angcyo.flutter3.abc/code_cache
/// 默认缓存路径->/data/user/0/com.angcyo.flutter3.abc/code_cache
/// getTemporaryDirectory->null
/// getApplicationSupportDirectory->null
/// getLibraryDirectory->null
/// getApplicationDocumentsDirectory->null
/// getApplicationCacheDirectory->null
/// getExternalStorageDirectory->null
/// externalCacheDirectory->null
/// getDownloadsDirectory->null
/// current->/
/// systemTemp->/data/user/0/com.angcyo.flutter3.abc/code_cache
/// ```
///
class PathViewModel extends ViewModel {
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
