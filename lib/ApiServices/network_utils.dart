import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {
  static Future<String?>? fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      // ignore: non_constant_identifier_names
      final Response = await http.get(uri, headers: headers);
      if (Response.statusCode == 200) {
        return Response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
