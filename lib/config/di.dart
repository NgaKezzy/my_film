import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> setup() async {
  di.registerSingleton<MovieCubit>(MovieCubit());

// Alternatively you could write it if you don't like global variables
}
