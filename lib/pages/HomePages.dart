import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Genre_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Movie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Multi_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/widgets/MultiSearchWidget.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

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

  @override
  Widget build(BuildContext context) {
    final multiBloc = context.read<MultiBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cinesquad',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0F111D),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white54,
                  size: 30,
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Buscar",
                      hintStyle: TextStyle(color: Colors.white54),
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
                if (searchQuery.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.white54),
                    onPressed: () {
                      setState(() {
                        searchQuery = "";
                      });
                      multiBloc.add(ClearSearchEvent());
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<MultiBloc, MultiState>(
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
                } else {
                  return BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, movieState) {
                      if (movieState is MoviesLoadedState) {
                        final List<MultiModel> movies = movieState.movies;
                        return BlocBuilder<SerieBloc, SerieState>(
                          builder: (context, serieState) {
                            if (serieState is SeriesLoadedState) {
                              final List<MultiModel> series = serieState.series;
                              return ListView(
                                padding: EdgeInsets.all(10),
                                children: [
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
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else if (movieState is MovieErrorState) {
                        return Center(child: Text(movieState.errorMessage));
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
