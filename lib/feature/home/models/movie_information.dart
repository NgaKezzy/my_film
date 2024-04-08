import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_information.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MovieInformation {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String slug;
  @HiveField(2)
  final String origin_name;
  @HiveField(3)
  String poster_url;
  @HiveField(4)
  String thumb_url;
  @HiveField(5)
  final int year;
  @HiveField(6)
  bool isFavorite;

  MovieInformation(
      {this.name = '',
      this.slug = '',
      this.origin_name = '',
      this.poster_url = '',
      this.thumb_url = ' ',
      this.year = 2020,
      this.isFavorite = false});

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
