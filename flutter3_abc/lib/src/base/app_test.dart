part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/09/27
///
class AppTest {
  AppTest._();

  /// [_MainAbcState.build]
  ///
  /// ```
  /// NetworkInterface('lo', [InternetAddress('127.0.0.1', IPv4), InternetAddress('::1%1', IPv6)])
  /// NetworkInterface('wlan1', [InternetAddress('192.168.1.139', IPv4), InternetAddress('fe80::5418:24ff:fec0:1b07%wlan1', IPv6)])
  /// NetworkInterface('dummy0', [InternetAddress('fe80::50b4:8bff:fee9:b545%dummy0', IPv6)])
  /// ```
  /// ```
  ///NetworkInterface('lo', [InternetAddress('127.0.0.1', IPv4), InternetAddress('::1%1', IPv6)])
  ///NetworkInterface('wlan0', [InternetAddress('192.168.0.108', IPv4), InternetAddress('fd00:4c10:d528:d394:1c86:ee7e:df0e:85ed%26', IPv6), InternetAddress('fd00:4c10:d528:d394:19a1:53c:2d57:a2b7%26', IPv6), InternetAddress('fd00:4c10:d528:d394:c916:ebd5:3585:5bef%26', IPv6), InternetAddress('fd00:4c10:d528:d394:9bd:eb46:2db9:d13c%26', IPv6), InternetAddress('fd00:4c10:d528:d394:8417:5926:e5fe:a23c%26', IPv6), InternetAddress('fd00:4c10:d528:d394:5025:d13e:ff2c:9544%26', IPv6), InternetAddress('fd00:4c10:d528:d394:d063:fdcb:3ff0:e5f5%26', IPv6), InternetAddress('fd00:4c10:d528:d394:2e59:8aff:fe7c:3f54%26', IPv6), InternetAddress('fe80::2e59:8aff:fe7c:3f54%wlan0', IPv6)])
  ///NetworkInterface('rndis0', [InternetAddress('192.168.42.129', IPv4), InternetAddress('fe80::68b3:eaff:fee0:22f%rndis0', IPv6)])
  ///NetworkInterface('dummy0', [InternetAddress('fe80::502b:1aff:fe3a:5b7d%dummy0', IPv6)])
  /// ```
  /// [NetworkInterface]
  static void testOnMainBuild(State state) async {
    //debugger();
    final list = await NetworkInterface.list(
      includeLinkLocal: true,
      type: InternetAddressType.any,
      includeLoopback: true,
    );
    final ipv4 = InternetAddress.anyIPv4.address; //0.0.0.0
    final ipv6 = InternetAddress.anyIPv6.address; //::
    l.i("网络接口信息(网关)↓\n${list.join("\n")}\n默认ipv4->$ipv4, 默认ipv6->$ipv6");
    //debugger();
  }

  static final chars =
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  /// 创建指定字节大小的字符串
  static String buildString(int size) {
    final StringBuffer buffer = StringBuffer();
    int byteCount = 0;
    for (int i = 0; i < intMax64Value; i++) {
      final char = chars[i % chars.length];
      byteCount += char.bytes.size();
      buffer.write(char);
      if (byteCount >= size) {
        break;
      }
    }
    return buffer.toString();
  }

  /// [_buildString]
  static Future<String> buildStringAsync(int size) async {
    return isolateRun(() {
      final StringBuffer buffer = StringBuffer();
      int byteCount = 0;
      for (int i = 0; i < intMax64Value; i++) {
        final char = chars[i % chars.length];
        byteCount += char.bytes.size();
        buffer.write(char);
        if (byteCount >= size) {
          break;
        }
      }
      return buffer.toString();
    });
  }

  /// 底部显示信息小部件
  static Widget buildBottomWidget(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaData = context.mediaQueryData;

    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);

    //当前语言
    final currentLocale = Localizations.localeOf(context);

    /*Text(
      StringBuilder()
          .append(
          '种子颜色:${themeData.colorScheme.primary.toHexColor()} ${themeData.colorScheme.secondary.toHexColor()}')
          .newLine()
          .append(
          '主题颜色:${themeData.primaryColor.toHexColor()} ${themeData.primaryColorDark.toHexColor()}')
          .newLine()
          .append(
          '${themeData.platform} ${themeData.colorScheme.brightness} $platformBrightness')
          .toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 9, color: Colors.grey),
    ),*/

    final bottomTextWidget = textSpanBuilder(
      (builder) {
        builder
          ..addText("种子颜色:")
          ..addTextColor(themeData.colorScheme.primary.toHexColor(),
              themeData.colorScheme.primary)
          ..addText(" ")
          ..addTextColor(themeData.colorScheme.secondary.toHexColor(),
              themeData.colorScheme.secondary)
          ..newLine()
          ..addText("主题颜色:")
          ..addTextBackgroundColor(
              themeData.primaryColor.toHexColor(), themeData.primaryColor)
          ..addText(" ")
          ..addTextBackgroundColor(
              themeData.indicatorColor.toHexColor(), themeData.indicatorColor)
          ..addText(" ")
          ..addTextBackgroundColor(themeData.primaryColorDark.toHexColor(),
              themeData.primaryColorDark)
          ..newLine()
          ..addText(
              'w:${mediaData.size.width.toDigits()}/${(mediaData.size.width * mediaData.devicePixelRatio).toInt()}/${deviceWidthPixel.toInt()}')
          ..addText(
              ' h:${mediaData.size.height.toDigits()}/${(mediaData.size.height * mediaData.devicePixelRatio).toInt()}/${deviceHeightPixel.toInt()}') //高度没有包含导航栏
          ..addText(
              ' s:${mediaData.devicePixelRatio} sf:${mediaData.textScaleFactor}')
          ..newLine()
          ..addText(
              '$appFlavor ${$buildFlavor} M3:${themeData.useMaterial3} ${themeData.colorScheme.brightness}')
          ..newLine()
          ..addText(
              '主题:${themeData.platform} ${themeData.brightness} $currentLocale')
          ..newLine()
          ..addText(
              '本机:${platformDispatcher.platformBrightness} 系统:$platformBrightness $platformLocale $platformLocales');
      },
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 9, color: Colors.grey),
    );

    return bottomTextWidget;
  }
}
