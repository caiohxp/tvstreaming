import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/pages/SerieDetailsPage.dart';

class FavoriteMoviesWidget extends StatefulWidget {
  final List<MultiModel> favoriteMovies;
  final List<MultiModel> favoriteSeries;

  FavoriteMoviesWidget({
    required this.favoriteMovies,
    required this.favoriteSeries,
  });

  @override
  FavoriteMoviesWidgetState createState() => FavoriteMoviesWidgetState();
}

class FavoriteMoviesWidgetState extends State<FavoriteMoviesWidget> {
  bool showFavoriteMovies = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showFavoriteMovies = true;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: showFavoriteMovies
                      ? const Color.fromARGB(255, 0, 164, 112)
                      : const Color.fromARGB(139, 0, 0, 0),
                  padding: EdgeInsets.all(20)),
              child: Text(
                'Favorite Movies',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showFavoriteMovies = false;
                });
              },
              child: Text(
                'Favorite Series',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: showFavoriteMovies
                      ? const Color.fromARGB(139, 0, 0, 0)
                      : const Color.fromARGB(255, 0, 164, 112),
                  padding: EdgeInsets.all(20)),
            ),
          ],
        ),
        Expanded(
          child: showFavoriteMovies
              ? ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: widget.favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final item = widget.favoriteMovies[index];
                    return _buildFavoriteItem(context, item);
                  },
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: widget.favoriteSeries.length,
                  itemBuilder: (context, index) {
                    final item = widget.favoriteSeries[index];
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
            builder: (context) => item.releaseDate != null
                ? MovieDetailsPage(movie: item)
                : SerieDetailsPage(
                    serie: item,
                  ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              posterPath,
              width: 125,
              height: 150,
              fit: BoxFit.contain,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 5),
                Row(
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
                  width: 100,
                  child: Text(
                    overview,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
