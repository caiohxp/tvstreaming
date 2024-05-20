import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_modulo_4/widgets/MovieGenres_model.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/Serie_model.dart';
import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> movies = [];
  List<SerieModel> series = [];
  List<MovieGenreModel> genres = [];
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  @override
  void initState() {
    super.initState();
    upComingMovies();
    fetchMovies();
    fetchSeries();
  }

  Future<void> upComingMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://developer.themoviedb.org/reference/movie-upcoming-list'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      setState(() {
        movies =
            results.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      });

      print(
          'Movies Attributes: ${json.encode(results[0])}'); // Print título do primeiro filme
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> fetchMovies() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      setState(() {
        movies =
            results.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      });

      print(
          'Movies Attributes: ${json.encode(results[0])}'); // Print título do primeiro filme
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> fetchSeries() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/airing_today'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      setState(() {
        series =
            results.map((serieJson) => SerieModel.fromJson(serieJson)).toList();
      });

      print(
          'Series Attributes: ${json.encode(results[0])}'); // Print título do primeiro filme
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Cinesquad",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.symmetric(horizontal: 10),
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
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(left: 5),
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
            SizedBox(height: 30),
            UpcomingWidget(movies: movies),
            SizedBox(height: 30),
            NewMoviesWidget(movies: movies),
            SizedBox(height: 30),
            NewSeriesWidget(series: series),
            SizedBox(height: 40),
          ],
        ),
      ),
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}
