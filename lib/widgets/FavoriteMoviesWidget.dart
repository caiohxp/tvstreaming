import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/bloc/movie_bloc.dart';
import 'package:projeto_modulo_4/bloc/serie_bloc.dart';

class FavoriteMoviesWidget extends StatelessWidget {
  final List<MultiModel> favoriteMovies;
  final List<MultiModel> favoriteSeries;

  FavoriteMoviesWidget(
      {required this.favoriteMovies, required this.favoriteSeries});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final item = favoriteMovies[index];
              return _buildFavoriteItem(context, item);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: favoriteSeries.length,
            itemBuilder: (context, index) {
              final item = favoriteSeries[index];
              return _buildFavoriteItem(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteItem(BuildContext context, MultiModel item) {
    final posterPath = item.posterPath != null
        ? '${item.posterPath}'
        : 'https://via.placeholder.com/150';
    final title = item.title ?? item.name ?? 'No title';
    final rating = item.voteAverage!.toStringAsFixed(1);
    final year = item.firstAirDate != null
        ? DateTime.parse(item.firstAirDate!).year.toString()
        : item.releaseDate != null
            ? DateTime.parse(item.releaseDate!).year.toString()
            : 'Unknown year';
    final overview = item.overview ?? 'No overview available';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: item),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    posterPath,
                    width: 125,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        rating,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    year,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 500,
                    child: Text(
                      overview,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
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
