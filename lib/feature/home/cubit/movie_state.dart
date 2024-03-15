import 'package:app/feature/home/models/movie_details.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'movie_state.g.dart';

enum MovieStatus { init, loading, success, error }

@CopyWith()
class MovieState extends Equatable {
  const MovieState({
    this.movies = const [],
    this.status = MovieStatus.init,
    this.movieDetails = const [],
  });
  final List<MovieInformation> movies;
  final MovieStatus status;
  final List<MovieDetails> movieDetails;

  @override
  List<Object> get props => [
        movies,
        movieDetails,
        status,
      ];
}
