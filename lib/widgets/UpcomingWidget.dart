import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tvabertaflix/bloc/Movie_Bloc.dart';
import 'package:tvabertaflix/main.dart';
import 'package:tvabertaflix/model/Multi_model.dart';
import 'package:tvabertaflix/pages/MovieDetailsPage.dart';

class UpcomingWidget extends HookWidget {
  final List<MultiModel> movies;

  UpcomingWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
        SizedBox(
          height: 200,
          child: BlocProvider<MovieBloc>(
            create: (_) => MovieBloc(),
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieItem(movie: movies[index]);
                },
              ),
              thumbColor: Color.fromARGB(255, 125, 49, 71),
              radius: Radius.circular(8.0),
              thickness: 8.0,
            ),
          ),
        ),
      ],
    );
  }
}

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
