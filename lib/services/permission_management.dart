import 'package:permission_handler/permission_handler.dart';

class PermissionManagement {
  static Future<bool> storagePermission() async {
    final status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }
}
