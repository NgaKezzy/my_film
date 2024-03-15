import 'package:app/feature/home/models/movie_category.dart';
import 'package:app/feature/home/models/movie_episodes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';

@JsonSerializable()
class MovieDetails {
  final String content;
  final String poster_url;
  final String thumb_url;
  final String trailer_url;
  final String time;
  final int year;
  final List<String> actor;
  final List<MovieCategory> category;
  final List<MovieCategory> country;

  MovieDetails(
      {this.content = '',
      this.poster_url = '',
      this.thumb_url = '',
      this.trailer_url = '',
      this.time = '',
      this.year = 0,
      this.actor = const [],
      this.category = const [],
      this.country = const [],
      });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  static List<MovieDetails> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json
        .map<MovieDetails>((item) => MovieDetails.fromJson(item))
        .toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
