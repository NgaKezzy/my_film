import 'package:app/feature/home/models/movie_details.dart';
import 'package:app/feature/home/models/movie_episodes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_film.g.dart';

@JsonSerializable()
class DataFilm {
  final MovieDetails movie;
  final List<MovieEpisodes> episodes;

  DataFilm({required this.movie, required this.episodes});
  factory DataFilm.fromJson(Map<String, dynamic> json) =>
      _$DataFilmFromJson(json);

  Map<String, dynamic> toJson() => _$DataFilmToJson(this);

  static List<DataFilm> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json.map<DataFilm>((item) => DataFilm.fromJson(item)).toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
