import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_category.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class MovieCategory {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  final String slug;

  MovieCategory({required this.id, required this.name, required this.slug});

  factory MovieCategory.fromJson(Map<String, dynamic> json) =>
      _$MovieCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCategoryToJson(this);

  static List<MovieCategory> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json
        .map<MovieCategory>((item) => MovieCategory.fromJson(item))
        .toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
