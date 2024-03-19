import 'package:app/feature/home/models/data_film.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'movie_state.g.dart';

enum MovieStatus { init, loading, success, error }

@CopyWith()
class MovieState extends Equatable {
  const MovieState({
    this.movies = const [],
    this.singleMovies = const [],
    this.status = MovieStatus.init,
    this.dataFilm,
  });
  final List<MovieInformation> movies;
  final List<MovieInformation> singleMovies;
  final MovieStatus status;
  final DataFilm? dataFilm;

  @override
  List<Object?> get props => [
        movies,
        singleMovies,
        dataFilm,
        status,
      ];
}
