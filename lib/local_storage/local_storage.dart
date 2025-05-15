import 'package:app/config/key_app.dart';
import 'package:app/feature/home/models/movie_category.dart';
import 'package:app/feature/home/models/movie_details.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> hiveRegisterAdapter() async {
    Hive.registerAdapter(MovieDetailsAdapter());
    Hive.registerAdapter(MovieCategoryAdapter());
  }

  static Future<void> hiveOpenBox() async {
    await Hive.openBox<MovieDetails>(KeyApp.VIEW_HISTORY_BOX);
    await Hive.openBox<MovieDetails>(KeyApp.FAVORITE_MOVIE_BOX);
  }

  static Future<void> hiveClearBox() async {
    //  gọi từng box ra để  clear data

    Box<MovieDetails> favoriteMovieBox = Hive.box(KeyApp.FAVORITE_MOVIE_BOX);
    favoriteMovieBox.clear();

    Box<MovieDetails> viewHistory = Hive.box(KeyApp.VIEW_HISTORY_BOX);
    viewHistory.clear();
  }
}
