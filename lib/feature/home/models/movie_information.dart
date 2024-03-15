import 'package:json_annotation/json_annotation.dart';
part 'movie_information.g.dart';

@JsonSerializable()
class MovieInformation {
  final String name;
  final String slug;
  final String origin_name;
  final String poster_url;
  final String thumb_url;
  final int year;

  MovieInformation(
      {required this.name,
      required this.slug,
      required this.origin_name,
      required this.poster_url,
      required this.thumb_url,
      required this.year});

  factory MovieInformation.fromJson(Map<String, dynamic> json) =>
      _$MovieInformationFromJson(json);

  Map<String, dynamic> toJson() => _$MovieInformationToJson(this);

  static List<MovieInformation> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json
        .map<MovieInformation>((item) => MovieInformation.fromJson(item))
        .toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
