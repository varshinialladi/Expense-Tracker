import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
