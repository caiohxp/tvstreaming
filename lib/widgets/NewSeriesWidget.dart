import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/pages/SerieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/SerieItem.dart';

class NewSeriesWidget extends HookWidget {
  final List<MultiModel> series;

  NewSeriesWidget({required this.series});

  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Séries recentes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 370,
          child: RawScrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: series.length,
              itemBuilder: (context, index) {
                return SerieItem(serie: series[index]);
              },
            ),
            thumbColor: Color(0xFF00A470),
            radius: Radius.circular(8.0),
            thickness: 8.0,
          ),
        ),
      ],
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final MultiModel serie;

  const FavoriteIcon({Key? key, required this.serie}) : super(key: key);

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
