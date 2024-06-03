import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import '../bloc/Genre_Bloc.dart';
import '../model/Genres_model.dart';

class SerieDetailsPage extends StatelessWidget {
  final MultiModel? serie;

  const SerieDetailsPage({Key? key, this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SerieGenreBloc()..add(FetchSerieGenres()),
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
                          '${serie?.backdropPath ?? ''}',
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
                        image: NetworkImage('${serie?.posterPath ?? ''}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 164, 112),
                        borderRadius: BorderRadius.circular(50)),
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 0, 164, 112),
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
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () => {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 164, 112),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                              ),
                              child: Text(
                                "Assistir",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () => {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 164, 112),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                              ),
                              child: Text(
                                "Trailer",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: Text(
                  '${serie?.name ?? ''}',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 164, 112)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${DateTime.parse(serie!.firstAirDate!).year} - ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber),
                    Text(
                      '${serie?.voteAverage!.toStringAsFixed(1) ?? ''}',
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
                child: BlocBuilder<SerieGenreBloc, GenreState>(
                  builder: (context, state) {
                    if (state is GenreLoading) {
                      return CircularProgressIndicator();
                    } else if (state is GenreLoaded) {
                      final List<dynamic> genres = state.genres;
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: serie?.genreIds
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
                  '${serie?.overview}',
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
