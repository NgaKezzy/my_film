import 'package:app/config/key_app.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> hiveRegisterAdapter() async {
    Hive.registerAdapter(MovieInformationAdapter());
  }

  static Future<void> hiveOpenBox() async {
    await Hive.openBox<MovieInformation>(KeyApp.FAVORITE_MOVIE_BOX);
    await Hive.openBox<MovieInformation>(KeyApp.VIEW_HISTORY);
  }

  static Future<void> hiveClearBox() async {
    // ? gọi từng box ra để  clear data

    Box<MovieInformation> favoriteMovieBox =
        Hive.box(KeyApp.FAVORITE_MOVIE_BOX);
    favoriteMovieBox.clear();

    Box<MovieInformation> viewHistory = Hive.box(KeyApp.VIEW_HISTORY);
    viewHistory.clear();
  }
}
