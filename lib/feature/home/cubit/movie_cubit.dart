import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/movie_data.dart';
import 'package:app/feature/home/models/movie_details.dart';
import 'package:app/feature/home/models/movie_episodes.dart';
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

    try {
      final data = await FetchApiMovie.getMovieDetails(slug);
      final MovieDetails movieDetails = MovieDetails.fromJson(data['movie']);

      final MovieEpisodes movieEpisodes =
          MovieEpisodes.fromJson(data['episodes'][0]);

      final movieData =
          MovieData(movie: [movieDetails], episodes: movieEpisodes);
 
    } catch (e) {
      print("error: " + e.toString());
    }
    emit(state.copyWith(status: MovieStatus.success));
  }
}
