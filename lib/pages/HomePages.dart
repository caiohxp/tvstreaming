import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Movie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/model/Movie_model.dart';
import 'package:projeto_modulo_4/model/SerieModelDefinition.dart';


import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => MovieBloc(),
          child: BlocProvider(
            create: (_) => SerieBloc(),
            child: HomeBody(),
          ),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();
    final serieBloc = context.read<SerieBloc>();

    movieBloc.fetchMovies();
    serieBloc.fetchSeries();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cinesquad', 
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color((0xFF0F111D))
      ),
      body: FutureBuilder(
        future: Future.wait([
          movieBloc.fetchMovies(),
          serieBloc.fetchSeries(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar Filmes e Séries'));
          } else {
           
            return BlocBuilder<MovieBloc, MovieState>(
              builder: (context, movieState) {
                if (movieState is MoviesLoadedState) {
                  final List<MovieModel> movies = movieState.movies;
                  
                  return BlocBuilder<SerieBloc, SerieState>(
                    builder: (context, serieState) {
                      if (serieState is SeriesLoadedState) {
                  
                        final List<SerieModel> series = serieState.series;
                       
                        return ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            Container(
                              height: 60,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFF292B37),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white54,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Buscar",
                                        hintStyle: TextStyle(color: Colors.white54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UpcomingWidget(movies: movies),
                            SizedBox(height: 20),
                            NewMoviesWidget(movies: movies),
                            SizedBox(height: 20),
                            NewSeriesWidget(series: series),
                            SizedBox(height: 20),
                          ],
                        );
                      } else if (serieState is SerieErrorState) {
                        return Center(child: Text(serieState.errorMessage));
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
    );
  }
}
