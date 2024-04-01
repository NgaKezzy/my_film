import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/data_film.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/network/fetch_api_movie.dart';
import 'package:bloc/bloc.dart';
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
      newSingleMovie.add(item);
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
      newSeriesMovies.add(item);
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
      newCartoons.add(item);
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
      newMoviesSearch.add(item);
    }
    emit(state.copyWith(
      moviesSearch: newMoviesSearch,
      status: MovieStatus.success,
    ));
  }

  Future<void> addMoviesToFavoritesList({
    required MovieInformation itemFilm,
  }) async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> items = state.favoriteMovies;
    items.add(itemFilm);
    emit(state.copyWith(favoriteMovies: items));
  }

  Future<void> removeMoviesToFavoritesList({
    required MovieInformation itemFilm,
  }) async {
    emit(state.copyWith(status: MovieStatus.loading));
    List<MovieInformation> items = state.favoriteMovies;
    for (int i = 0; i < items.length; i++) {
      if (itemFilm.slug == items[i].slug) {
        items.removeAt(i);
      }
    }
    emit(state.copyWith(favoriteMovies: items));
  }
}
