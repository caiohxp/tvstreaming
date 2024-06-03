import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Movie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';

class FavoriteMovie extends StatelessWidget {
  final MultiModel movie;

  const FavoriteMovie({Key? key, required this.movie, MultiModel? serie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MovieBloc>().add(ToggleFavoriteEvent(movie));
      },
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          bool isFavorite = false;
          if (state is MoviesLoadedState) {
            isFavorite = state.favoriteMovieIds.contains(movie.id);
          }
          return Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: const Color.fromARGB(255, 255, 7, 7),
          );
        },
      ),
    );
  }
}
