class AppApi {
  AppApi._();
  //base api
  static const String baseApi = 'api.openweathermap.org';

  //path
  static const String data = '/data/2.5/forecast';
  static const String getLocation = '/geo/1.0/direct';


  //action
  static const String action = 'action';

  //query params
  static const String apiKey = '3c2ade9b394e5a827a3b6ff9bf60af4d';
  static const String appId = 'appid';
  static const String lat = 'lat';
  static const String lon = 'lon';
  static const String units = 'units';
  static const String metric = 'metric';
  static const String q = 'q';
  static const String limit = 'limit';


  //timezone params
  static const String timezoneVN = 'Asia/Ho_Chi_Minh';

  //status code
  static const int success = 200;
  static const int error = 404;
}
