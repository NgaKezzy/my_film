import 'package:app/feature/home/models/movie_category.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MovieDetails {
  @HiveField(0)
  String content;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String origin_name;
  @HiveField(3)
  final String poster_url;
  @HiveField(4)
  final String thumb_url;
  @HiveField(5)
  final String trailer_url;
  @HiveField(6)
  final String time;
  @HiveField(7)
  final int year;
  @HiveField(8)
  final List<String> actor;
  @HiveField(9)
  List<MovieCategory> category;
  @HiveField(10)
  final List<MovieCategory> country;
  @HiveField(11)
  bool isFavorite;
  @HiveField(12)
  String slug;

  MovieDetails({
    this.name = '',
    this.origin_name = '',
    this.content = '',
    this.poster_url = '',
    this.thumb_url = '',
    this.trailer_url = '',
    this.time = '',
    this.year = 0,
    this.actor = const [],
    this.category = const [],
    this.country = const [],
    this.isFavorite = false,
    this.slug = '',
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
