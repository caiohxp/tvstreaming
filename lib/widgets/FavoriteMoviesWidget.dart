import 'package:flutter/material.dart';
import 'package:tvabertaflix/model/Multi_model.dart';
import 'package:tvabertaflix/pages/MovieDetailsPage.dart';
import 'package:tvabertaflix/pages/SerieDetailsPage.dart';
import 'package:responsive_styles/breakpoints/breakpoints.dart';
import 'package:responsive_styles/responsive/responsive.dart';

class FavoriteMoviesWidget extends StatefulWidget {
  final List<MultiModel> favoriteMovies;
  final List<MultiModel> favoriteSeries;
  final Responsive responsive;

  FavoriteMoviesWidget({
    required this.favoriteMovies,
    required this.favoriteSeries,
    required this.responsive,
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
                padding: EdgeInsets.all(20),
              ),
              child: Text(
                'Favorite Movies',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              width: widget.responsive.value({
                Breakpoints.xs: 15,
                Breakpoints.sm: 25,
                Breakpoints.md: 40,
                Breakpoints.lg: 50,
                Breakpoints.xl: 60,
              }),
            ),
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
                padding: EdgeInsets.all(20),
              ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
        child: Material(
          color: Colors
              .transparent, // Cor transparente para evitar sombras indesejadas
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  item.posterPath != null
                      ? '${item.posterPath}'
                      : 'https://via.placeholder.com/150',
                  width: 125,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.responsive.value({
                        Breakpoints.xs: 150,
                        Breakpoints.sm: 250,
                        Breakpoints.md: 400,
                        Breakpoints.lg: 500,
                        Breakpoints.xl: 600,
                      }),
                      child: Text(
                        item.title ?? item.name ?? 'No title',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          item.voteAverage!.toStringAsFixed(1),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      item.firstAirDate != null
                          ? DateTime.parse(item.firstAirDate!).year.toString()
                          : item.releaseDate != null
                              ? DateTime.parse(item.releaseDate!)
                                  .year
                                  .toString()
                              : 'Unknown year',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: widget.responsive.value({
                        Breakpoints.xs: 150,
                        Breakpoints.sm: 250,
                        Breakpoints.md: 400,
                        Breakpoints.lg: 500,
                        Breakpoints.xl: 600,
                      }),
                      child: Text(
                        item.overview ?? 'No overview available',
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
        ),
      ),
    );
  }
}
