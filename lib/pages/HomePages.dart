import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/DiscoverMovie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/DiscoverSerie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Movie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Multi_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/widgets/DiscoverMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/DiscoverSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/FavoriteMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/MultiSearchWidget.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

const List<Map<String, dynamic>> tvGenres = [
  {'id': 10759, 'name': 'Action & Adventure'},
  {'id': 16, 'name': 'Animation'},
  {'id': 35, 'name': 'Comedy'},
  {'id': 80, 'name': 'Crime'},
  {'id': 99, 'name': 'Documentary'},
  {'id': 18, 'name': 'Drama'},
  {'id': 10751, 'name': 'Family'},
  {'id': 10762, 'name': 'Kids'},
  {'id': 9648, 'name': 'Mystery'},
  {'id': 10763, 'name': 'News'},
  {'id': 10764, 'name': 'Reality'},
  {'id': 10765, 'name': 'Sci-Fi & Fantasy'},
  {'id': 10766, 'name': 'Soap'},
  {'id': 10767, 'name': 'Talk'},
  {'id': 10768, 'name': 'War & Politics'},
  {'id': 37, 'name': 'Western'},
];

const List<Map<String, dynamic>> movieGenres = [
  {'id': 28, 'name': 'Action'},
  {'id': 12, 'name': 'Adventure'},
  {'id': 16, 'name': 'Animation'},
  {'id': 35, 'name': 'Comedy'},
  {'id': 80, 'name': 'Crime'},
  {'id': 99, 'name': 'Documentary'},
  {'id': 18, 'name': 'Drama'},
  {'id': 10751, 'name': 'Family'},
  {'id': 14, 'name': 'Fantasy'},
  {'id': 36, 'name': 'History'},
  {'id': 27, 'name': 'Horror'},
  {'id': 10402, 'name': 'Music'},
  {'id': 9648, 'name': 'Mystery'},
  {'id': 10749, 'name': 'Romance'},
  {'id': 878, 'name': 'Science Fiction'},
  {'id': 10770, 'name': 'TV Movie'},
  {'id': 53, 'name': 'Thriller'},
  {'id': 10752, 'name': 'War'},
  {'id': 37, 'name': 'Western'},
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MultiBloc()),
            BlocProvider(create: (_) => MovieBloc()..fetchMovies()),
            BlocProvider(create: (_) => SerieBloc()..fetchSeries()),
            BlocProvider(
                create: (_) => DiscoverMovieBloc()
                  ..add(FetchDiscoverMoviesEvent(
                      [28, 12]))), // Exemplo de IDs de gêneros
            BlocProvider(
                create: (_) => DiscoverSerieBloc()
                  ..add(FetchDiscoverSeriesEvent(
                      [10759, 16]))), // Exemplo de IDs de gêneros
          ],
          child: HomeBody(),
        ),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String searchQuery = "";
  int? selectedTVGenreId;
  int? selectedMovieGenreId;
  final TextEditingController _controller = TextEditingController();
  bool showFavoriteMovies = false;
  bool showFavoriteSeries = false;

  @override
  Widget build(BuildContext context) {
    final multiBloc = context.read<MultiBloc>();
    final discoverSerieBloc = context.read<DiscoverSerieBloc>();
    final discoverMovieBloc = context.read<DiscoverMovieBloc>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Text(
          'Cinesquad',
          style: TextStyle(color: Colors.white, fontSize: 72),
        ),
        backgroundColor: Color(0xFF0F111D),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 500,
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 43, 66),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          controller: _controller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Buscar",
                            hintStyle: TextStyle(color: Colors.white54),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          onChanged: (query) {
                            setState(() {
                              searchQuery = query;
                            });
                            if (query.isNotEmpty) {
                              multiBloc.add(FetchMultiEvent(query));
                            }
                          },
                        ),
                      ),
                    ),
                    if (searchQuery.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.white54),
                        onPressed: () {
                          setState(() {
                            searchQuery = "";
                            _controller.clear();
                          });
                          multiBloc.add(ClearSearchEvent());
                        },
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  DropdownButton<int>(
                    value: selectedMovieGenreId,
                    hint: Text("Filmes por gênero",
                        style: TextStyle(color: Colors.white)),
                    dropdownColor: Color(0xFF292B37),
                    items: movieGenres.map((genre) {
                      return DropdownMenuItem<int>(
                        value: genre['id'],
                        child: Text(
                          genre['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMovieGenreId = value;
                      });
                      if (value != null) {
                        discoverMovieBloc
                            .add(FetchDiscoverMoviesEvent([value]));
                      }
                    },
                  ),
                  if (selectedMovieGenreId != null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedMovieGenreId = null;
                        });
                        discoverMovieBloc.add(FetchDiscoverMoviesEvent([]));
                      },
                      icon: Icon(Icons.clear, color: Colors.white54),
                    ),
                ],
              ),
              Row(
                children: [
                  DropdownButton<int>(
                    value: selectedTVGenreId,
                    hint: Text("Séries por gênero",
                        style: TextStyle(color: Colors.white)),
                    dropdownColor: Color(0xFF292B37),
                    items: tvGenres.map((genre) {
                      return DropdownMenuItem<int>(
                        value: genre['id'],
                        child: Text(
                          genre['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTVGenreId = value;
                      });
                      if (value != null) {
                        discoverSerieBloc
                            .add(FetchDiscoverSeriesEvent([value]));
                      }
                    },
                  ),
                  if (selectedTVGenreId != null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedTVGenreId = null;
                        });
                        discoverSerieBloc.add(FetchDiscoverSeriesEvent([]));
                      },
                      icon: Icon(Icons.clear, color: Colors.white54),
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showFavoriteMovies = !showFavoriteMovies;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(139, 0, 0, 0),
                    padding: EdgeInsets.all(20)),
                child: Row(
                  children: [
                    Text(
                      'Lista de Favoritos',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.favorite,
                      color: const Color.fromARGB(255, 255, 7, 7),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: showFavoriteMovies
                ? BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, movieState) {
                      return BlocBuilder<SerieBloc, SerieState>(
                        builder: (context, serieState) {
                          if (movieState is MoviesLoadedState &&
                              serieState is SeriesLoadedState) {
                            final List<MultiModel> favoriteMovies = movieState
                                .movies
                                .where((movie) => movieState.favoriteMovieIds
                                    .contains(movie.id))
                                .toList();
                            final List<MultiModel> favoriteSeries = serieState
                                .series
                                .where((serie) => serieState.favoriteSeriesIds
                                    .contains(serie.id))
                                .toList();
                            return FavoriteMoviesWidget(
                              favoriteMovies: favoriteMovies,
                              favoriteSeries: favoriteSeries,
                            );
                          } else if (movieState is MovieErrorState) {
                            return Center(child: Text(movieState.errorMessage));
                          } else if (serieState is SerieErrorState) {
                            return Center(child: Text(serieState.errorMessage));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    },
                  )
                : BlocBuilder<MultiBloc, MultiState>(
                    builder: (context, state) {
                      if (searchQuery.isNotEmpty) {
                        if (state is MultiLoadedState) {
                          final List<MultiModel> items = state.items;
                          return MultiSearchWidget(items: items);
                        } else if (state is MultiErrorState) {
                          return Center(child: Text(state.errorMessage));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      } else if (selectedMovieGenreId != null) {
                        return BlocBuilder<DiscoverMovieBloc,
                            DiscoverMovieState>(
                          builder: (context, state) {
                            if (state is DiscoverMovieLoadedState) {
                              final List<MultiModel> movies = state.movies;
                              return DiscoverMoviesWidget(movies: movies);
                            } else if (state is DiscoverMovieErrorState) {
                              return Center(child: Text(state.errorMessage));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else if (selectedTVGenreId != null) {
                        return BlocBuilder<DiscoverSerieBloc,
                            DiscoverSerieState>(
                          builder: (context, state) {
                            if (state is DiscoverSerieLoadedState) {
                              final List<MultiModel> series = state.series;
                              return DiscoverSeriesWidget(series: series);
                            } else if (state is DiscoverSerieErrorState) {
                              return Center(child: Text(state.errorMessage));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else {
                        return BlocBuilder<MovieBloc, MovieState>(
                          builder: (context, movieState) {
                            if (movieState is MoviesLoadedState) {
                              final List<MultiModel> movies = movieState.movies;
                              return BlocBuilder<SerieBloc, SerieState>(
                                builder: (context, serieState) {
                                  if (serieState is SeriesLoadedState) {
                                    final List<MultiModel> series =
                                        serieState.series;
                                    return ListView(
                                      padding: EdgeInsets.all(10),
                                      children: [
                                        SizedBox(height: 20),
                                        UpcomingWidget(movies: movies),
                                        SizedBox(height: 20),
                                        NewMoviesWidget(movies: movies),
                                        SizedBox(height: 20),
                                        NewSeriesWidget(series: series),
                                        SizedBox(height: 20),
                                      ],
                                    );
                                  } else if (serieState is SerieErrorState) {
                                    return Center(
                                        child: Text(serieState.errorMessage));
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              );
                            } else if (movieState is MovieErrorState) {
                              return Center(
                                  child: Text(movieState.errorMessage));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
