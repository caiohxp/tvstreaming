import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_modulo_4/model/Movie_model.dart';
import 'package:projeto_modulo_4/model/Serie_model.dart';

import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';

import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  @override
  void initState() {
    super.initState();
  }

 
  Future<Map<String, dynamic>> fetchAllData() async {
    final moviesResponse = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    final seriesResponse = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/airing_today'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (moviesResponse.statusCode == 200 && seriesResponse.statusCode == 200) {
      final moviesData = json.decode(moviesResponse.body);
      final seriesData = json.decode(seriesResponse.body);

      final List<MovieModel> movies = (moviesData['results'] as List)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList();

      final List<SerieModel> series = (seriesData['results'] as List)
          .map((serieJson) => SerieModel.fromJson(serieJson))
          .toList();

      return {'movies': movies, 'series': series};
    } else {
      throw Exception('Erro ao carregar Filmes e Series.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load movies and series'));
            } else if (snapshot.hasData) {
              final movies = snapshot.data!['movies'] as List<MovieModel>;
              final series = snapshot.data!['series'] as List<SerieModel>;

              return ListView(
                children: [
                  const Padding(
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
                            ),
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
                        const Icon(
                          Icons.search,
                          color: Colors.white54,
                          size: 30,
                        ),
                        Container(
                          width: 300,
                          margin: EdgeInsets.only(left: 5),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
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
              );
            }
            return Container();
          },
        ),
      ),
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}
