import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvabertaflix/bloc/DIscoverMovie_Bloc.dart';
import 'package:tvabertaflix/bloc/DiscoverSerie_Bloc.dart';
import 'package:tvabertaflix/bloc/Genre_Bloc.dart';
import 'package:tvabertaflix/pages/CategoryPage.dart';
import 'package:tvabertaflix/pages/HomePages.dart';
import 'package:tvabertaflix/bloc/Movie_Bloc.dart';
import 'package:tvabertaflix/bloc/Serie_Bloc.dart';
import 'package:tvabertaflix/pages/MovieDetailsPage.dart';
import 'package:tvabertaflix/pages/login/SplashLoginPage.dart';
import 'package:tvabertaflix/pages/login/ViewLoginPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(create: (_) => MovieBloc()),
        BlocProvider<SerieBloc>(create: (_) => SerieBloc()),
        BlocProvider<MovieGenreBloc>(create: (_) => MovieGenreBloc()),
        BlocProvider<SerieGenreBloc>(create: (_) => SerieGenreBloc()),
        BlocProvider<DiscoverMovieBloc>(create: (_) => DiscoverMovieBloc()),
        BlocProvider<DiscoverSerieBloc>(create: (_) => DiscoverSerieBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 32, 31, 31),
        ),
        routes: {
          "/": (context) => HomePage(),
          "categoryPage": (context) => CategoryPage(),
          "movieDetailsPage": (context) => MovieDetailsPage(movie: null),
        },
      ),
    );
  }
}
