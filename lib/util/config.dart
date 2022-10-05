import 'package:flutter/material.dart';

/// FileName config
///
/// @Author mqxu
/// @Date 2022/9/29 09:03
///
/// @Description 全局配置类
class Config {
  /// 主题颜色
  static const int _primaryColorValue = 0xFF547773;
  static const Color primaryColor = Color(_primaryColorValue);
  static const MaterialColor primarySwatchColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      // 50: Color(0xFFD7E5D3),
      // 100: Color(0xFFAFC0AC),
      // 200: Color(0xFF90A496),
      // 300: Color(0xFF7D9178),
      // 400: Color(0xFF687E6F),
      // 500: Color(_primaryColorValue),
      // 600: Color(0xFF506055),
      // 700: Color(0xFF39483E),
      // 800: Color(0xBA405447),
      // 900: Color(0xBA27342D),
      50: Color(0xFFbbdfde),
      100: Color(0xffa2c2c1),
      200: Color(0xFF95B1B4),
      300: Color(0xFF829C9F),
      400: Color(0xFF6A8F8D),
      500: Color(_primaryColorValue),
      600: Color(0xFF466564),
      700: Color(0xFF3C5457),
      800: Color(0xFF2C4144),
      900: Color(0xBA263B39),
    },
  );
}
