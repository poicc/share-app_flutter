import 'package:flutter/material.dart';

/// FileName text_styles
///
/// @Author mqxu
/// @Date 2022/9/29 09:03
///
/// @Description 文本样式定义

//黑色文字样式
final TextStyle blackText = TextStyle(color: Colors.black);

//按钮文字样式
final TextStyle buttonText = TextStyle(fontSize: 16.0);

//链接文字样式
const TextStyle linkText = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Color(0xffFFD800),
);

//加粗样式
const TextStyle shadedTitle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xff587498));

const TextStyle sub = TextStyle(fontSize: 14.0, color: Colors.grey);

const TextStyle summary = TextStyle(fontSize: 16.0);

// 消息样式，复制上面样式
final TextStyle messageStyle = shadedTitle.copyWith();

//正确文字样式
final TextStyle correctMessageStyle =
    messageStyle.copyWith(color: const Color(0xff587058));

//错误文字样式
final TextStyle incorrectMessageStyle =
    messageStyle.copyWith(color: const Color(0xffE86850));
