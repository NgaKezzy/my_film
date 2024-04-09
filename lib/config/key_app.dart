class KeyApp {
  KeyApp._();
  static const String Base_URL = 'phimapi.com';

  static const String IS_SET_LANGUAGE = 'Is_Select_Language';
  static const String LANGUAGE_CODE = 'Language_Code';
  static const String IS_DARK = 'Is_Dark';

  /// End point
  static const String NEW_UPDATE_MOVIES = '/danh-sach/phim-moi-cap-nhat';
  static const String SINGLE_MOVIES = '/v1/api/danh-sach/phim-le';
  static const String SERIES_MOVIES = '/v1/api/danh-sach/phim-bo';
  static const String CARTOON = '/v1/api/danh-sach/hoat-hinh';
  static const String MOVIES_SEARCH = '/v1/api/tim-kiem';

  /// local storage
  static const String FAVORITE_MOVIE_BOX = 'favorite_Movie_Box';
  static const String VIEW_HISTORY = 'view_history';
  static const String IS_SELECTED_NOTIFICATION = 'is_selected_notification';


}
