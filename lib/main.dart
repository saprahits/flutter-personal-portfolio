/*
 * Project Name: Flutter Personal Portfolio
 *
 * Description: This project is a Flutter-based personal portfolio template. It is designed to be
 *              easily customizable and can be used by anyone for free.
 *
 * Copyright (c) 2024 Hitesh Sapra
 * Website: https://www.hiteshsapra.com
 *
 * License: Permission is hereby granted, free of charge, to any person obtaining a copy of this
 *          software and associated documentation files (the "Software"), to deal in the Software
 *          without restriction, including without limitation the rights to use, copy, modify,
 *          merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 *          permit persons to whom the Software is furnished to do so, subject to the following
 *          conditions:
 *
 *          The above copyright notice and this permission notice shall be included in all copies
 *          or substantial portions of the Software.
 *
 *          THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 *          INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 *          PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 *          LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
 *          OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 *          OTHER DEALINGS IN THE SOFTWARE.
 *
 * Credit: This project is created by Hitesh Sapra. If you use this project or any part of it, please
 *         give credit to the original author by including the following link: https://www.hiteshsapra.com
 */


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiteshsapra/theme/theme_controller.dart';

import 'dashboard/dashboard_controller.dart';
import 'dashboard/dashboard_screen.dart';
import 'splash/splash_controller.dart';
import 'splash/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final ThemeData lightTheme = ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFFF75023),
        secondaryHeaderColor: const Color(0xFFF4F4F2),
        scaffoldBackgroundColor: const Color(0xFFffffff),
        highlightColor: const Color(0xFF000000),
        hoverColor: const Color(0xFFb8b5c8),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
              fontSize: 20,
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaRegular'),
          titleMedium: TextStyle(
              fontSize: 20,
              color: Color(0xFFF75023),
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaRegular'),
        ));

    final ThemeData darkTheme = ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFFF75023),
        secondaryHeaderColor: const Color(0xFF404453),
        scaffoldBackgroundColor: const Color(0xFF2b2d33),
        highlightColor: const Color(0xFFffffff),
        hoverColor: const Color(0xFFb8b5c8),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
              fontSize: 20,
              color: Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaRegular'),
          titleMedium: TextStyle(
              fontSize: 20,
              color: Color(0xFFF75023),
              fontWeight: FontWeight.bold,
              fontFamily: 'HelveticaRegular'),
        ));
    return Obx(
      () => GetMaterialApp(
        title: 'Hitesh Sapra',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.themeMode.value,
        initialBinding: InitialBinding(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),

          ///Lunch Screen
          GetPage(name: '/dashboard', page: () => const DashboardScreen()),

          /// main screen
        ],
      ),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(SplashController());
    Get.put(DashboardController());
  }
}
