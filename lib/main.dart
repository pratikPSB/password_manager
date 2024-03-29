import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'app/data/resources/size_config.dart';
import 'app/data/resources/strings.dart';
import 'app/data/resources/theme_utils.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    getTheme();
    // getLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Strings(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      onGenerateTitle: (context) {
        SizeConfig().init(context);
        return "Password manager";
      },
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      title: 'Password manager',
      theme: ThemeUtils.getDarkTheme(),
      // darkTheme: ThemeUtils.getDarkTheme(),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
    );
  }

  void getTheme() {
    ThemeUtils.getThemeMode().then((value) {
      themeMode = value;
      Get.changeThemeMode(themeMode);
    });
  }

/*void getLocale() {
    prefs().getString(prefKeyLocale).then((value) {
      if (value != "") {
        if (value == "hi") {
          Get.updateLocale(const Locale('hi', 'IN'));
        } else {
          Get.updateLocale(const Locale('en', 'US'));
        }
      } else {
        Get.updateLocale(const Locale('en', 'US'));
      }
    });
  }*/
}
