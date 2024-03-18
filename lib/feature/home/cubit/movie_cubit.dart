import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/data_film.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/network/fetch_api_movie.dart';
import 'package:bloc/bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());

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

  Future<void> getMovieDetails(String slug) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final DataFilm newDataFilm;

    try {
      final data = await FetchApiMovie.getMovieDetails(slug);
      newDataFilm = DataFilm.fromJson(data);

      emit(state.copyWith(
        dataFilm: newDataFilm,
        status: MovieStatus.success,
      ));
    } catch (e) {
      print("error: $e");
    }

    emit(state.copyWith(status: MovieStatus.success));
  }
}
