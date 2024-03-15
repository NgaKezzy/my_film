import 'package:app/feature/home/models/movie_details.dart';
import 'package:app/feature/home/models/movie_episodes.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_data.g.dart';

@JsonSerializable()
class MovieData {
  final List<MovieDetails> movie;
  final MovieEpisodes episodes;

  MovieData({required this.movie, required this.episodes});

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);

  static List<MovieData> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json.map<MovieData>((item) => MovieData.fromJson(item)).toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
