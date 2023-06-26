import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9968591176688909/1034495746';
    }else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}