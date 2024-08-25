import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestScheduleExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isGranted) {
    // Permission is already granted
    return;
  }

  // Request permission
  PermissionStatus status = await Permission.scheduleExactAlarm.request();

  if (status.isGranted) {
    // Permission granted
    print("Exact alarm permission granted");
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied
    openAppSettings();
  } else {
    // Permission denied
    
    print("Exact alarm permission denied");
  }
}
