import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/SerieModelDefinition.dart';
import 'package:projeto_modulo_4/pages/SerieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';

class NewSeriesWidget extends StatelessWidget {
  final List<SerieModel> series;

  NewSeriesWidget({required this.series});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          height: 340,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: series.length,
            itemBuilder: (context, index) {
              return SerieItem(serie: series[index]);
            },
          ),
        ),
      ],
    );
  }
}

class SerieItem extends StatelessWidget {
  final SerieModel? serie;

  const SerieItem({Key? key, this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SerieDetailsPage(serie: serie!),
          ),
        );
      },
      child: Container(
        width: 190,
        height: 340,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xFF292B37),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                serie?.posterPath ?? '',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serie?.name ?? '',
                    style: TextStyle(
                      color: Color(0xFF00A470),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    serie?.firstAirDate ?? '',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text(
                        serie?.voteAverage?.toString() ?? '',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      BlocProvider.value(
                        value: context.read<SerieBloc>(),
                        child: FavoriteIcon(serie: serie!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final SerieModel serie;

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
