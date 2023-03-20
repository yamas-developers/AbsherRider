import 'dart:io';

import 'package:absher_rider/providers/location/location_provider.dart';
import 'package:absher_rider/providers/mj_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import 'package:flutter/material.dart';
import 'config/mj_config.dart';
import 'helpers/router_helper.dart' as router;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Future<FirebaseApp> firebaseApp = Firebase.initializeApp(
    options: Platform.isIOS
        ? MJConfig.firebaseIOSOptions
        : MJConfig.firebaseAndroidOptions,
  );
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child:
        MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...providers],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          // This is the theme of your application.

          textTheme: TextTheme(
              bodyText2: TextStyle(
                  color: mediumGreyFontColor
              )
          ),
          primaryColor: mainColor,
          primarySwatch: Colors.purple,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: lighterGreyColor
            )
          )
          /* dark theme settings */
        ),
        themeMode: ThemeMode.system,
        /* ThemeMode.system to follow system theme,
           ThemeMode.light for light theme,
           ThemeMode.dark for dark theme
        */
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: '/',
        // routes: routes,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
