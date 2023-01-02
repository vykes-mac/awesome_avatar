import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

loadHtmlFromAssets(WebViewController controller, String asset) async {
  String fileText = await rootBundle.loadString(asset);
  controller.loadUrl(Uri.dataFromString(fileText,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString());
}

userFromPrefs(SharedPreferences prefs) {
  final Map<String, dynamic> json =
      jsonDecode(prefs.getString('avatar') ?? '{}');
  if (json.isNotEmpty) {
    final avatarUrl = json['data']['url'];
    final avatarId =
        avatarUrl?.split('/').last.toString().replaceAll('.glb', '').trim();
    return ProfileData(avatarId, avatarUrl: avatarUrl);
  }
  return null;
}

class ProfileData {
  ProfileData(this.avatarId, {this.name, this.avatarUrl, this.email});
  final String? avatarId;
  final String? name;
  final String? email;
  final String? avatarUrl;
}
