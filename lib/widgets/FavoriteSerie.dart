import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';

class FavoriteSerie extends StatelessWidget {
  final MultiModel serie;

  const FavoriteSerie({Key? key, required this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SerieBloc>().add(ToggleFavoriteEvent(serie));
      },
      child: BlocBuilder<SerieBloc, SerieState>(
        builder: (context, state) {
          bool isFavorite = false;
          if (state is SeriesLoadedState) {
            isFavorite = state.favoriteSeriesIds.contains(serie.id);
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
