import 'dart:convert';
import 'package:app/config/key_app.dart';
import 'package:app/config/print_color.dart';
import 'package:http/http.dart' as http;

class FetchApiMovie {
  FetchApiMovie._();

  static Future<Map<String, dynamic>> getMovies() async {
    var uri = Uri.https(
        KeyApp.baseUrl, '/danh-sach/phim-moi-cap-nhat', {'page': '1'});
    Map<String, dynamic> result = {};
    try {
      final response = await http.get(uri);

      switch (response.statusCode) {
        case 200:
          var data = jsonDecode(response.body);
          result = data;
          break;
        case 400:
          var data = jsonDecode(response.body);
          result = data;
          break;
        case 401:
          var data = jsonDecode(response.body);
          result = data;
          break;
        case 404:
          var data = jsonDecode(response.body);
          result = data;

          break;
        default:
      }

      return result;
    } catch (e) {
      printRed(e.toString());
    }
    return result;
  }

  static Future<Map<String, dynamic>> getMovieDetails(String slug) async {
    var uri = Uri.https(
      KeyApp.baseUrl,
      '/phim/$slug',
    );
    Map<String, dynamic> result = {};
    try {
      final response = await http.get(uri);

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = jsonDecode(response.body);
          result = data;
          break;
        case 400:
          var data = jsonDecode(response.body);
          result = data;
          break;
        case 401:
          var data = jsonDecode(response.body);
          result = data;
          break;
        case 404:
          var data = jsonDecode(response.body);
          result = data;

          break;
        default:
      }
      return result;
    } catch (e) {
      printRed(e.toString());
    }

    return result;
  }
}
