import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:projeto_modulo_4/main.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/model/Movie_model.dart';

class UpcomingWidget extends StatelessWidget {
  final List<MovieModel> movies;

  UpcomingWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Próximas estreias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieItem(movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}

class MovieItem extends HookWidget {
  final MovieModel movie;

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
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Stack(alignment: Alignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.backdropPath!,
                  height: 180,
                  width: 300,
                  fit: BoxFit.cover,
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
            ]),
          ),
        ),
      ),
    );
  }
}
