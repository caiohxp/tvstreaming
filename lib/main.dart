import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/bloc/Genre_Bloc.dart';
import 'package:projeto_modulo_4/pages/CategoryPage.dart';
import 'package:projeto_modulo_4/pages/HomePages.dart';
import 'package:projeto_modulo_4/bloc/Movie_Bloc.dart';
import 'package:projeto_modulo_4/bloc/Serie_Bloc.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF0F111D),
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
