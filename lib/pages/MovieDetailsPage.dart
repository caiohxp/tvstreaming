

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/Movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovielModel? movie;

  const MovieDetailsPage({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF0F111D),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 400, // Altura da imagem do filme
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${movie?.movie_poster_url ?? ''}]'),
                      fit: BoxFit.cover,
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
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 164, 112),
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
                              backgroundColor: Color.fromARGB(255, 0, 164, 112),
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
                '${movie?.movie_title ?? ''}',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 164, 112)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              child: Text(
                '${movie?.movie_release_year ?? ''} - 2h 46min - ${movie?.rating ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  _chipTag("Ação"),
                  _chipTag("Aventura"),
                  _chipTag("Ficção Científica")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 50, top: 0, bottom: 100, right: 50),
              child: Text(
                '${movie?.description}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Chip _chipTag(String nameTag) {
    return Chip(
      label: Text(nameTag, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 43, 43, 56),
    );
  }
}
