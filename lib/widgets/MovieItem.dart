import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/FavoriteMovie.dart';

class MovieItem extends HookWidget {
  final MultiModel movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movie: movie),
            ),
          );
        },
        child: Container(
          width: 250,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      // Se movie.posterPath for nulo, usa uma imagem padrão
                      movie.posterPath ?? 'https://via.placeholder.com/250x300',
                      height: 300,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    width: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(162, 41, 43, 55),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                // Se movie.voteAverage for nulo, usa 0.0
                                (movie.voteAverage ?? 0.0).toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(101, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20)),
                          child: FavoriteMovie(movie: movie),
                        )
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isHovered.value ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      Icons.play_circle_outline_rounded,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // Se movie.title for nulo, usa "Título Desconhecido"
                      movie.title ?? 'Título Desconhecido',
                      style: TextStyle(
                        color: Color(0xFF00A470),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      // Se movie.releaseDate for nulo, usa "Data Desconhecida"
                      movie.releaseDate != null
                          ? DateTime.parse(movie.releaseDate!).year.toString()
                          : 'Data Desconhecida',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
