import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'themeMode';

  // Retrieve the theme from local storage or return default value
  ThemeMode _loadThemeFromBox() {
    String? themeString = _box.read(_key);
    switch (themeString) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.system':
      default:
        return ThemeMode.system;
    }
  }

  // Save the theme to local storage
  void _saveThemeToBox(ThemeMode themeMode) {
    _box.write(_key, themeMode.toString());
  }

  var themeMode = ThemeMode.system.obs;

  ThemeController() {
    themeMode.value = _loadThemeFromBox();
    Get.changeThemeMode(themeMode.value);
  }

  void switchTheme(ThemeMode mode) {
    themeMode.value = mode;
    _saveThemeToBox(mode);
    Get.changeThemeMode(mode);
  }

  void setSystemMode() {
    themeMode.value = ThemeMode.system;
    _saveThemeToBox(ThemeMode.system);
    Get.changeThemeMode(ThemeMode.system);
  }
}
