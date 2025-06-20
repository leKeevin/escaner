import 'dart:io';
import 'package:flutter/foundation.dart';

String getBaseUrl() {
  const port = '8000';

  // return "http://192.168.1.75:$port";

  if (kIsWeb) {
    // Running in a web browser - assuming server is accessible from browser's perspective
    // This might need adjustment based on how you host/proxy your API for web
    return 'http://localhost:$port'; // Or your domain
  } else if (Platform.isAndroid) {
    // Android Emulator uses 10.0.2.2 to access host localhost
    // return 'http://10.0.2.2:$port';
    return 'http://192.168.1.75:$port'; //
    // return 'http://10.10.7.27:$port'; //
  } else if (Platform.isIOS) {
    // iOS Simulator uses localhost or 127.0.0.1
    return 'http://localhost:$port';
  } else {
    // Default or other platforms (handle physical devices separately)
    // For physical devices, you'd need the host machine's actual network IP
    // e.g., 'http://192.168.1.100:12345'
    // Returning localhost as a fallback might not work universally
    return 'http://localhost:$port';
    // return 'http://192.168.1.75:$port';
  }
}
