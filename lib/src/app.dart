import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'constants.dart' show APP_NAME;
import 'theme-styles.dart';
import 'services.dart';
import 'pages.dart';
import 'routes.dart';
import 'app-context.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: AppContext.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp(context);
        }
        return _InitAppPage();
      },
    );
  }

  Widget _buildApp(BuildContext context) {
    final isFirstTime = SettingService.isFirstTime;
    if (isFirstTime) SettingService.setFirstTime();

    return ValueListenableBuilder(
      valueListenable: SettingService.listen(),
      builder: (context, Box box, child) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: ThemeStyles.themeData(context, SettingService.isDark),
          initialRoute: isFirstTime ? Routes.introduction : Routes.homeScreen,
          //initialRoute: Routes.shareApp,
          routes: <String, WidgetBuilder>{
            Routes.introduction: (_) => IntroductionPage(),
            Routes.homeScreen: (context) => HomePage(
                  maxSlide: MediaQuery.of(context).size.width * 0.835,
                ),
            Routes.surahIndex: (_) => SurahIndexPage(),
            Routes.surah: (ctx) => SurahViewPage(_args(ctx) as Surah),
            Routes.sajdaIndex: (_) => SajdaIndexPage(),
            Routes.sajda: (ctx) => SajdaViewPage(info: _args(ctx) as SajdaInfo),
            Routes.juzzIndex: (_) => JuzzIndexPage(),
            Routes.juzz: (ctx) => JuzzViewPage(juzz: _args(ctx) as int),
            Routes.help: (_) => HelpPage(),
            Routes.shareApp: (_) => SharePage(),
          },
        );
      },
    );
  }
}

class _InitAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Object? _args(BuildContext ctx) => ModalRoute.of(ctx)!.settings.arguments;
