import 'package:json_annotation/json_annotation.dart';
part 'server_data.g.dart';

@JsonSerializable()
class ServerData {
  final String server_data;
  final String slug;
  final String filename;
  final String link_embed;
  final String link_m3u8;

  ServerData(
      {required this.server_data,
      required this.slug,
      required this.filename,
      required this.link_embed,
      required this.link_m3u8});

  factory ServerData.fromJson(Map<String, dynamic> json) =>
      _$ServerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServerDataToJson(this);

  static List<ServerData> convertToList(List<dynamic> json) {
    //json ở đây là data
    return json.map<ServerData>((item) => ServerData.fromJson(item)).toList();
    // post này là từng instance   ------------- post này là  để ấy vào trong fromjson trong factory rồi chuyển thành list
  }
}
