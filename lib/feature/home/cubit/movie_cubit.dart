import 'package:app/config/key_app.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/data_film.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/network/fetch_api_movie.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:translator/translator.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());

  final translator = GoogleTranslator();

  Future<void> getMovie() async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> newMovies = [];

    final data = await FetchApiMovie.getMovies();

    List items = data['items'];
    for (var i = 0; i < items.length; i++) {
      final MovieInformation item;
      item = MovieInformation.fromJson(items[i]);
      newMovies.add(item);
    }
    if (state.favoriteMovies.isNotEmpty && newMovies.isNotEmpty) {
      for (int i = 0; i < newMovies.length; i++) {
        for (int j = 0; j < state.favoriteMovies.length; j++) {
          if (newMovies[i].slug == state.favoriteMovies[j]!.slug) {
            newMovies[i].isFavorite = true;
          }
        }
      }
    }
    emit(state.copyWith(
      movies: newMovies,
      status: MovieStatus.success,
    ));
  }

  Future<void> getMovieDetails(String slug, String languageCode) async {
    DataFilm? newDataFilm;
    emit(state.copyWith(status: MovieStatus.loading, dataFilm: newDataFilm));

    try {
      final data = await FetchApiMovie.getMovieDetails(slug);
      if (data['status'] == false) {
        return;
      }

      newDataFilm = DataFilm.fromJson(data);
      if (languageCode == 'en') {
        // nếu là tiếng anh thì dịch nội dung phim
        newDataFilm.movie.content = await translate(newDataFilm.movie.content);

        for (var i = 0; i < newDataFilm.movie.actor.length; i++) {
          newDataFilm.movie.actor[i] =
              await translate(newDataFilm.movie.actor[i]);
        }

        for (var i = 0; i < newDataFilm.movie.category.length; i++) {
          newDataFilm.movie.category[i].name =
              await translate(newDataFilm.movie.category[i].name);
        }
      }
    } catch (e) {
      print("error: $e");
    }
    printGreen(newDataFilm!.movie.content);
    emit(state.copyWith(
      dataFilm: newDataFilm,
      status: MovieStatus.success,
    ));
  }

  Future<String> translate(String content) async {
    // hàm để dịch sang tiếng anh
    String newContent = '';
    await translator.translate(content, to: 'en').then((value) => {
          newContent = value.toString(),
        });
    return newContent;
  }

  Future<void> getAListOfIndividualMovies() async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> newSingleMovie = [];

    final data = await FetchApiMovie.getAListOfIndividualMovies();

    List items = data['data']['items'];
    for (var i = 0; i < items.length; i++) {
      final MovieInformation item;
      item = MovieInformation.fromJson(items[i]);
      item.poster_url = 'https://img.phimapi.com/${item.poster_url}';
      item.thumb_url = 'https://img.phimapi.com/${item.thumb_url}';

      newSingleMovie.add(item);
    }
    if (state.favoriteMovies.isNotEmpty && newSingleMovie.isNotEmpty) {
      for (int i = 0; i < newSingleMovie.length; i++) {
        for (int j = 0; j < state.favoriteMovies.length; j++) {
          if (newSingleMovie[i].slug == state.favoriteMovies[j]!.slug) {
            newSingleMovie[i].isFavorite = true;
          }
        }
      }
    }
    emit(state.copyWith(
      singleMovies: newSingleMovie,
      status: MovieStatus.success,
    ));
  }

  Future<void> getTheListOfMoviesAndSeries() async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> newSeriesMovies = [];

    final data = await FetchApiMovie.getTheListOfMoviesAndSeries();

    List items = data['data']['items'];
    for (var i = 0; i < items.length; i++) {
      final MovieInformation item;
      item = MovieInformation.fromJson(items[i]);
      item.poster_url = 'https://img.phimapi.com/${item.poster_url}';
      item.thumb_url = 'https://img.phimapi.com/${item.thumb_url}';
      newSeriesMovies.add(item);
    }
    if (state.favoriteMovies.isNotEmpty && newSeriesMovies.isNotEmpty) {
      for (int i = 0; i < newSeriesMovies.length; i++) {
        for (int j = 0; j < state.favoriteMovies.length; j++) {
          if (newSeriesMovies[i].slug == state.favoriteMovies[j]!.slug) {
            newSeriesMovies[i].isFavorite = true;
          }
        }
      }
    }
    emit(state.copyWith(
      seriesMovies: newSeriesMovies,
      status: MovieStatus.success,
    ));
  }

  Future<void> getTheListOfCartoons() async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> newCartoons = [];

    final data = await FetchApiMovie.getTheListOfCartoons();
    List items = data['data']['items'];
    for (var i = 0; i < items.length; i++) {
      final MovieInformation item;
      item = MovieInformation.fromJson(items[i]);
      item.poster_url = 'https://img.phimapi.com/${item.poster_url}';
      item.thumb_url = 'https://img.phimapi.com/${item.thumb_url}';
      newCartoons.add(item);
    }

    if (state.favoriteMovies.isNotEmpty && newCartoons.isNotEmpty) {
      for (int i = 0; i < newCartoons.length; i++) {
        for (int j = 0; j < state.favoriteMovies.length; j++) {
          if (newCartoons[i].slug == state.favoriteMovies[j]!.slug) {
            newCartoons[i].isFavorite = true;
          }
        }
      }
    }
    emit(state.copyWith(
      cartoon: newCartoons,
      status: MovieStatus.success,
    ));
  }

  Future<void> moviesSearch(String keyWord) async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> newMoviesSearch = [];

    final data = await FetchApiMovie.movieSearch(keyWord);

    List items = data['data']['items'];
    for (var i = 0; i < items.length; i++) {
      final MovieInformation item;
      item = MovieInformation.fromJson(items[i]);
      item.poster_url = 'https://img.phimapi.com/${item.poster_url}';
      item.thumb_url = 'https://img.phimapi.com/${item.thumb_url}';
      newMoviesSearch.add(item);
    }
    emit(state.copyWith(
      moviesSearch: newMoviesSearch,
      status: MovieStatus.success,
    ));
  }

  Future<void> getMovieDataTheLocalStorage() async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation?> itemFilms = [];

    Box<MovieInformation> favoriteMovieBox =
        Hive.box(KeyApp.FAVORITE_MOVIE_BOX);

    if (favoriteMovieBox.length == 0) {
      emit(
        state.copyWith(
          favoriteMovies: [],
        ),
      );
    } else {
      for (int i = 0; i < favoriteMovieBox.length; i++) {
        itemFilms.add(favoriteMovieBox.getAt(i));
      }
      emit(state.copyWith(favoriteMovies: itemFilms));
    }
  }

  Future<void> addMoviesToFavoritesList({
    required MovieInformation? itemFilm,
  }) async {
    emit(state.copyWith(status: MovieStatus.loading));
    Box<MovieInformation> favoriteMovieBox =
        Hive.box(KeyApp.FAVORITE_MOVIE_BOX);
    favoriteMovieBox.clear();
    List<MovieInformation?> newFavoriteMovies = [
      itemFilm,
      ...state.favoriteMovies
    ];

    newFavoriteMovies.forEach((element) async {
      await favoriteMovieBox.add(element!);
      printRed(element.slug);
    });

    emit(state.copyWith(
        favoriteMovies: newFavoriteMovies, status: MovieStatus.success));
  }

  Future<void> removeMoviesToFavoritesList({
    required MovieInformation? itemFilm,
  }) async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation?> items = state.favoriteMovies;
    for (int i = 0; i < items.length; i++) {
      if (itemFilm!.slug == items[i]!.slug) {
        items.removeAt(i);
      }
    }
    emit(state.copyWith(favoriteMovies: items));
    Box<MovieInformation> favoriteMovieBox =
        Hive.box(KeyApp.FAVORITE_MOVIE_BOX);
    favoriteMovieBox.clear();
    for (var element in items) {
      favoriteMovieBox.add(element!);
    }
  }

  Future<void> addToWatchHistory({required MovieInformation? itemFilm}) async {
    emit(state.copyWith(status: MovieStatus.loading));
    printCyan(itemFilm.toString());
    Box<MovieInformation> viewHistoryBox = Hive.box(KeyApp.VIEW_HISTORY_BOX);

    List<MovieInformation?> newViewHistory = [];
    if (state.viewHistory.isEmpty) {
      /// nếu mảng rỗng thêm luôn phim vào
      newViewHistory.add(itemFilm!);
      viewHistoryBox.add(itemFilm);
      emit(state.copyWith(
          viewHistory: newViewHistory, status: MovieStatus.success));
    } else {
      // nếu mảng có chứa phần từ thì
      viewHistoryBox.clear();
      // ! kiểm tra mảng có tồn tại phần tử đó chưa
      bool isContains = false;
      int index = -1;

      for (int i = 0; i < state.viewHistory.length; i++) {
        if (itemFilm!.slug == state.viewHistory[i]!.slug) {
          isContains = true;
          index = i;
        }
      }

      if (isContains) {
        // xóa phim ở vị trí cũ đi thay phim vào vị trí đầu tiên
        List<MovieInformation?> items = state.viewHistory;
        items.removeAt(index);
        newViewHistory = [itemFilm, ...items];
        for (var element in newViewHistory) {
            viewHistoryBox.add(element!);
          }

        emit(state.copyWith(
            viewHistory: newViewHistory, status: MovieStatus.success));
      } else {
        if (state.viewHistory.length == 20) {
          /// nếu 20 phần tử thì xóa phần tử cuối rồi thêm phim mới xem vào đầu tiên

          List<MovieInformation?> items = [...state.viewHistory];
          items.removeLast();
          newViewHistory = [itemFilm, ...items];
          for (var element in newViewHistory) {
              viewHistoryBox.add(element!);
            }
          emit(state.copyWith(
              viewHistory: newViewHistory, status: MovieStatus.success));
        } else {
          // nhỏ hơn 20 phần tử thì thêm vào phim vào phần tử đầu tiên của mảng

          List<MovieInformation?> items = [...state.viewHistory];
          newViewHistory = [itemFilm, ...items];
          for (var element in newViewHistory) {
              viewHistoryBox.add(element!);
            }
          emit(state.copyWith(
              viewHistory: newViewHistory, status: MovieStatus.success));
        }
      }
    }
  }

  Future<void> getViewHistoryTheLocalStorage() async {
    emit(state.copyWith(status: MovieStatus.loading));
    Box<MovieInformation> viewHistoryBox = Hive.box(KeyApp.VIEW_HISTORY_BOX);
    printRed(viewHistoryBox.length.toString());
    List<MovieInformation?> newViewHistory = [];
    if (viewHistoryBox.length == 0) {
      emit(
        state.copyWith(
          favoriteMovies: [],
        ),
      );
    } else {
      for (int i = 0; i < viewHistoryBox.length; i++) {
        newViewHistory.add(viewHistoryBox.getAt(i));
      }
      emit(state.copyWith(viewHistory: newViewHistory));
      printCyan(state.viewHistory.length.toString());
    }
  }

  Future<void> clearCache() async {
    emit(state.copyWith(status: MovieStatus.loading));
    Box<MovieInformation> viewHistoryBox = Hive.box(KeyApp.VIEW_HISTORY_BOX);
    Box<MovieInformation> favoriteMovieBox =
        Hive.box(KeyApp.FAVORITE_MOVIE_BOX);
    viewHistoryBox.clear();
    favoriteMovieBox.clear();
    emit(state.copyWith(
        status: MovieStatus.success, favoriteMovies: [], viewHistory: []));
  }
}
