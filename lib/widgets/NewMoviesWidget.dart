import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/movie_bloc.dart';
import 'package:projeto_modulo_4/model/SerieModelDefinition.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/model/Movie_model.dart';

class NewMoviesWidget extends HookWidget {
  final List<MovieModel> movies;

  NewMoviesWidget({required this.movies});

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
                "Filmes recentes",
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
          child: BlocProvider<MovieBloc>(
            create: (_) => MovieBloc(),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieItem(movie: movies[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieItem extends HookWidget {
  final MovieModel movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movie: movie),
            ),
          );
        },
        child: Container(
          width: 250,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      movie.posterPath!,
                      height: 300,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    width: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(162, 41, 43, 55),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                movie.voteAverage!.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(101, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20)),
                          child: BlocProvider.value(
                            value: context.read<MovieBloc>(),
                            child: FavoriteIcon(movie: movie),
                          ),
                        )
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isHovered.value ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      Icons.play_circle_outline_rounded,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
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
                      movie.title!,
                      style: TextStyle(
                        color: Color(0xFF00A470),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      DateTime.parse(movie.releaseDate!).year.toString(),
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final MovieModel movie;

  const FavoriteIcon({Key? key, required this.movie, SerieModel? serie})
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
