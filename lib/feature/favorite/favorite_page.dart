import 'package:app/component/header_app.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderApp(title: 'Phim yêu thích'),
          BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state.favoriteMovies.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text('danh sách trống !'),
                  ),
                );
              }
              return Expanded(
                  child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    height: 100,
                    imageUrl: state.favoriteMovies[index].poster_url,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.warning),
                  );
                },
                itemCount: state.favoriteMovies.length,
              ));
            },
          )
        ],
      ),
    );
  }
}
