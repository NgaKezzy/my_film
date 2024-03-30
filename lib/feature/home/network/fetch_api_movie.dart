import 'dart:convert';
import 'package:app/config/key_app.dart';
import 'package:app/config/print_color.dart';
import 'package:http/http.dart' as http;

class FetchApiMovie {
  FetchApiMovie._();

  static Future<Map<String, dynamic>> getMovies() async {
    var uri =
        Uri.https(KeyApp.baseUrl, KeyApp.NEW_UPDATE_MOVIES, {'page': '1'});
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
          var data = jsonDecode(response.body);
          result = data;
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

  static Future<Map<String, dynamic>> getAListOfIndividualMovies() async {
    var uri = Uri.https(KeyApp.baseUrl, KeyApp.SINGLE_MOVIES, {'limit': '50'});
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
          var data = jsonDecode(response.body);
          result = data;
      }

      return result;
    } catch (e) {
      printRed(e.toString());
    }
    return result;
  }

  static Future<Map<String, dynamic>> getTheListOfMoviesAndSeries() async {
    var uri = Uri.https(KeyApp.baseUrl, KeyApp.SERIES_MOVIES, {'limit': '50'});
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
          var data = jsonDecode(response.body);
          result = data;
      }

      return result;
    } catch (e) {
      printRed(e.toString());
    }
    return result;
  }

  static Future<Map<String, dynamic>> getTheListOfCartoons() async {
    var uri = Uri.https(KeyApp.baseUrl, KeyApp.CARTOON, {'limit': '50'});
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
          var data = jsonDecode(response.body);
          result = data;
      }

      return result;
    } catch (e) {
      printRed(e.toString());
    }
    return result;
  }

  static Future<Map<String, dynamic>> movieSearch(String keyWord) async {
    var uri = Uri.https(KeyApp.baseUrl, KeyApp.MOVIES_SEARCH,
        {'keyword': keyWord, 'limit': '10'});
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
          var data = jsonDecode(response.body);
          result = data;
      }

      return result;
    } catch (e) {
      printRed(e.toString());
    }
    return result;
  }
}
