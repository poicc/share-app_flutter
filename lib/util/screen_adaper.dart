import 'package:flutter_screenutil/flutter_screenutil.dart';

//  封装屏幕适配类

class ScreenAdapter {
  // 设置高度
  static setWidth(double n) {
    return ScreenUtil().setWidth(n);
  }

  // 设置宽度
  static setHeight(double n) {
    return ScreenUtil().setHeight(n);
  }

  // 获取屏幕像素宽度(实际宽度dp与设计吃水px之比)
  static getScreenWidth() {
    return ScreenUtil().scaleWidth;
  }

  // 获取屏幕像素高度(实际高度dp与设计吃水px之比)
  static getScreenHeight() {
    return ScreenUtil().scaleHeight;
  }

  // 获取屏幕宽度
  static getPxWidth() {
    return ScreenUtil().screenWidth;
  }

  // 获取屏幕高度
  static getPxHeight() {
    return ScreenUtil().screenHeight;
  }

  // 适配字体高度
  static size(double size) {
    return ScreenUtil().setSp(size);
  }
}
