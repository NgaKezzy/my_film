import 'package:app/feature/home/models/server_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_episodes.g.dart';

@JsonSerializable()
class MovieEpisodes {
  final String server_name;
  final List<ServerData> server_data;
  MovieEpisodes({required this.server_name, required this.server_data});

  factory MovieEpisodes.fromJson(Map<String, dynamic> json) =>
      _$MovieEpisodesFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEpisodesToJson(this);

  static List<MovieEpisodes> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json
        .map<MovieEpisodes>((item) => MovieEpisodes.fromJson(item))
        .toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
