import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class Plugins {
  //拍照
  static takePhoto() async {
    var image =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as File;
    return image;
  }

  //相册
  static openGalley() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

  //选取视频
  static getVideo() async {
    var image = await ImagePicker().pickVideo(source: ImageSource.gallery);
    return image;
  }

  // 裁剪图片
  static Future cropImage(context, file) async {
    File croppedFile = await ImageCrop.cropImage(
        file: file, area: const Rect.fromLTRB(50, 50, 50, 50));
    return croppedFile;
  }
}
