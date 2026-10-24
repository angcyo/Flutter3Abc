import 'package:flame_games/src/assets/game_assets.dart';
import 'package:flame_games/src/flame_games_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_core/flutter3_core.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/10/21
///
/// Flame 拼图游戏
void main() async {
  ensureInitialized();
  await initHive();
  await initFlutter3Core();
  await $gameAssets.initGameImageAssets();
  runApp(const FlameGamesApp());
}

class FlameGamesApp extends StatelessWidget {
  const FlameGamesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeData = GlobalConfig.def.initGlobalTheme(
      context,
      (globalTheme, isLight, themeMode) => ThemeData(
        colorScheme: .fromSeed(
          seedColor: Color(0xffd23d3e),
          brightness: themeMode.brightness,
        ),
        brightness: themeMode.brightness,
        /*useMaterial3: true,
        fontFamily: "menlo", //默认字体*/
      ),
      themeMode: .dark,
    );

    return MaterialApp(
      title: 'Flame Games',
      theme: themeData,
      locale: GlobalConfig.def.locale,
      themeMode: GlobalConfig.def.themeMode,
      //--
      localizationsDelegates: const [
        LibRes.delegate, // 必须
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        /*...LibRes.delegate.supportedLocales,*/
        //可以不需要
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      ],
      home: builder((ctx) {
        initGlobalAppAtContext(ctx);
        return const FlameGamesScreen();
      }),
    ).wrapDebugPage(context);
  }
}
