import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:responsive_styles/breakpoints/breakpoints.dart';
import 'package:responsive_styles/responsive/responsive.dart';

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
  bool isMovieFiltering = false;
  bool isSerieFiltering = false;
  final TextEditingController _controller = TextEditingController();
  bool showFavorite = false;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var responsive = Responsive(context);
    final multiBloc = context.read<MultiBloc>();
    final discoverSerieBloc = context.read<DiscoverSerieBloc>();
    final discoverMovieBloc = context.read<DiscoverMovieBloc>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Cinesquad',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0F111D),
        elevation: 100,
        actions: [
          IconButton(
            icon: Icon(showFavorite ? Icons.favorite : Icons.favorite_outline,
                color: const Color.fromARGB(255, 255, 7, 7)),
            onPressed: () {
              setState(
                () {
                  showFavorite = !showFavorite;
                },
              );
            },
          ),
          isSearching
              ? Container(
                  width: responsive.value({
                    Breakpoints.xs: 100,
                    Breakpoints.sm: 150,
                    Breakpoints.md: 200,
                    Breakpoints.lg: 300,
                    Breakpoints.xl: 300,
                  }),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 39, 43, 66),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Buscar",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                      if (query.isNotEmpty) {
                        multiBloc.add(FetchMultiEvent(query));
                      }
                    },
                  ))
              : Container(),
          showFavorite
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(
                      () {
                        showFavorite = !showFavorite;
                      },
                    );
                  },
                )
              : IconButton(
                  icon: Icon(isSearching ? Icons.clear : Icons.search,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      if (isSearching) {
                        searchQuery = "";
                        _controller.clear();
                        multiBloc.add(ClearSearchEvent());
                      }
                      isSearching = !isSearching;
                    });
                  },
                ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showFavorite
                    ? Text(
                        'Lista de Favoritos',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Text(
                              'Filtrar por:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                selectedTVGenreId == null
                                    ? Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isMovieFiltering =
                                                    !isMovieFiltering;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 0, 164, 112)),
                                            child: Text(
                                              'Filmes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          isMovieFiltering && !isSerieFiltering
                                              ? DropdownButton<int>(
                                                  value: selectedMovieGenreId,
                                                  hint: Text(
                                                      "selecione o gênero",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  dropdownColor:
                                                      Color(0xFF292B37),
                                                  items:
                                                      movieGenres.map((genre) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: genre['id'],
                                                      child: Text(
                                                        genre['name'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedMovieGenreId =
                                                          value;
                                                    });
                                                    if (value != null) {
                                                      discoverMovieBloc.add(
                                                          FetchDiscoverMoviesEvent(
                                                              [value]));
                                                    }
                                                  },
                                                )
                                              : Container(),
                                          if (selectedMovieGenreId != null)
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedMovieGenreId = null;
                                                });
                                                discoverMovieBloc.add(
                                                    FetchDiscoverMoviesEvent(
                                                        []));
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Colors.white54),
                                            ),
                                        ],
                                      )
                                    : Container(),
                                selectedMovieGenreId == null &&
                                        selectedTVGenreId == null
                                    ? SizedBox(
                                        width: responsive.value({
                                          Breakpoints.xs: 10,
                                          Breakpoints.sm: 10,
                                          Breakpoints.md: 100,
                                          Breakpoints.lg: 150,
                                          Breakpoints.xl: 200,
                                        }),
                                      )
                                    : Container(),
                                selectedMovieGenreId == null
                                    ? Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isSerieFiltering =
                                                    !isSerieFiltering;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 0, 164, 112)),
                                            child: Text(
                                              'Séries',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          isSerieFiltering && !isMovieFiltering
                                              ? DropdownButton<int>(
                                                  value: selectedTVGenreId,
                                                  hint: Text(
                                                      "selecione o gênero",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  dropdownColor:
                                                      Color(0xFF292B37),
                                                  items: tvGenres.map((genre) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: genre['id'],
                                                      child: Text(
                                                        genre['name'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedTVGenreId = value;
                                                    });
                                                    if (value != null) {
                                                      discoverSerieBloc.add(
                                                          FetchDiscoverSeriesEvent(
                                                              [value]));
                                                    }
                                                  },
                                                )
                                              : Container(),
                                          if (selectedTVGenreId != null)
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedTVGenreId = null;
                                                });
                                                discoverSerieBloc.add(
                                                    FetchDiscoverSeriesEvent(
                                                        []));
                                              },
                                              icon: Icon(Icons.clear,
                                                  color: Colors.white54),
                                            ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            child: showFavorite
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
                              responsive: responsive,
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
