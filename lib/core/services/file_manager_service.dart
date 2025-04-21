import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf_generator/core/exceptions/file_service_exception.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManagerService {
  Future<File> pickFile() async {
    final grantedPermission = await requestStoragePermission();
    if (grantedPermission) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        throw PickedFileException();
      }
    } else {
      throw PickFilePermissionException();
    }
  }

  Future<dynamic> saveFile({
    required String fileName,
    required Uint8List bytes,
    bool handleDesktopSave = false,
  }) async {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux
        ? await _saveFileDesktop(
          fileName: fileName,
          bytes: bytes,
          handleSave: handleDesktopSave,
        )
        : await _saveFileMobile(fileName, bytes);
  }

  Future<String?> _saveFileDesktop({
    required String fileName,
    required Uint8List bytes,
    bool handleSave = false,
  }) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: fileName,
      bytes: bytes,
    );
    if (outputFile == null) {
      return null;
    }
    if (handleSave) {
      final file = File(outputFile);
      await file.writeAsBytes(bytes);
    }
    return outputFile;
  }

  Future<String?> _saveFileMobile(String fileName, Uint8List bytes) async {
    final outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: fileName,
      bytes: bytes,
    );
    if (outputFile == null) {
      return null;
    }
    return outputFile;
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      if (deviceInfo.version.sdkInt <= 32) {
        final PermissionStatus res = await Permission.storage.request();
        return res.isGranted;
      } else {
        final PermissionStatus res = await Permission.mediaLibrary.request();
        return res.isGranted;
      }
    } else if (Platform.isIOS) {
      final PermissionStatus res = await Permission.storage.request();
      return res.isGranted;
    }
    return true;
  }
}
