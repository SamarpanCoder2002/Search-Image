import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:search_photo/services/permission_management.dart';
import 'package:search_photo/services/toast_message.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../config/types.dart';
import 'directory_management.dart';

class SpecificServices {
  static final _dio = Dio();

  static downloadPicture(String downloadPath, BuildContext context) async {
    final _permissionGranted = await PermissionManagement.storagePermission();

    if (!_permissionGranted) return;

    final _dirPath = await createImageStoreDir();
    final _imageDownloadPath = createImageFile(
        dirPath: _dirPath,
        name: DateTime.now().toString().split(" ").join("_"));

    _dio.download(downloadPath, _imageDownloadPath).then((response) async {
      final file = File(_imageDownloadPath);
      final bytes = file.readAsBytesSync();
      await ImageGallerySaver.saveImage(bytes);

      DialogMsg.showDialog(
          context, 'Image downloaded successfully', 'Check your gallery',
          awesomeDialogType: AwesomeDialogType.success);
    });
  }
}
