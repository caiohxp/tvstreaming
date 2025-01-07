import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvabertaflix/bloc/Genre_Bloc.dart';
import 'package:tvabertaflix/bloc/Movie_Bloc.dart';
import 'package:tvabertaflix/model/Genres_model.dart';
import 'package:tvabertaflix/model/Multi_model.dart';
import 'package:tvabertaflix/widgets/FavoriteMovie.dart';
import 'package:responsive_styles/breakpoints/breakpoints.dart';
import 'package:responsive_styles/responsive/responsive.dart';

class MovieDetailsPage extends StatelessWidget {
  final MultiModel? movie;

  const MovieDetailsPage({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    return BlocProvider(
      create: (context) => MovieGenreBloc()..add(FetchMovieGenres()),
      child: Material(
        color: Color(0xFF0F111D),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          '${movie?.backdropPath ?? ''}',
                          fit: BoxFit.fill,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${movie?.posterPath ?? ''}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 125, 49, 71),
                        borderRadius: BorderRadius.circular(50)),
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 125, 49, 71),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: responsive.value({
                          Breakpoints.xs: 300,
                          Breakpoints.sm: 400,
                          Breakpoints.md: 1000,
                          Breakpoints.lg: 1500,
                          Breakpoints.xl: 2000,
                        }),
                      ),
                      child: Text(
                        '${movie?.title ?? ''}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 125, 49, 71),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  BlocProvider.value(
                    value: context.read<MovieBloc>(),
                    child: FavoriteMovie(
                      movie: movie!,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${DateTime.parse(movie!.releaseDate!).year} - ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber),
                    Text(
                      '${movie?.voteAverage!.toStringAsFixed(1) ?? ''}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: BlocBuilder<MovieGenreBloc, GenreState>(
                  builder: (context, state) {
                    if (state is GenreLoading) {
                      return CircularProgressIndicator();
                    } else if (state is GenreLoaded) {
                      final genres = state.genres;
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: movie?.genreIds
                                ?.map((id) =>
                                    _chipTag(_getGenreNameById(id, genres)))
                                .toList() ??
                            [],
                      );
                    } else {
                      return Text('Failed to load genres',
                          style: TextStyle(color: Colors.white));
                    }
                  },
                ),
              ),
              Container(
                width: 600,
                margin: const EdgeInsets.only(
                    left: 50, top: 0, bottom: 100, right: 50),
                child: Text(
                  '${movie?.overview}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGenreNameById(int id, List<dynamic> genres) {
    final genre = genres.firstWhere((genre) => genre.id == id,
        orElse: () => GenreModel(id: 0, name: 'Unknown'));
    return genre.name;
  }

  Chip _chipTag(String nameTag) {
    return Chip(
      label: Text(nameTag, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 43, 43, 56),
    );
  }
}
