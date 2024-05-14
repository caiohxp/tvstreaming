import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';

class NewMoviesWidget extends StatelessWidget {
  static List<MovielModel> main_movies_list = [
    MovielModel(
        "Deadpool 3 ",
        "Herói",
        "https://i.pinimg.com/736x/85/e0/9c/85e09c65f67cff0a9b32159817675656.jpg",
        8.1,
        ""),
    MovielModel(
        "Bob Marley",
        "Biografia",
        "https://a-static.mlcdn.com.br/450x450/poster-cartaz-bob-marley-one-love-a-pop-arte-poster/poparteskins2/pos-03511-40x60cm/7ce157f8a26072197cdaad1358028e16.jpeg",
        6.9,
        ""),
    MovielModel(
        "Capitã Marvel",
        "Herói",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8e3JTsJ4aZNTJDYT8AW5S1kSwJLqSxC7OWnGHeCgQJg&s",
        7.8,
        "Capitã Marvel é uma alienígena Kree que se encontra no meio de uma batalha entre seu povo e os Skrulls. Com a ajuda de Nick Fury, ela tenta impedir uma invasão na Terra, descobrir os segredos de seu passado e pôr um fim ao antigo conflito."),
    MovielModel(
        "Homem dos Sonhos ",
        "Drama",
        "https://infonet.com.br/wp-content/uploads/2024/03/h1.jpg",
        8.8,
        ""),
    // MovielModel(
    //     "Marvel",
    //     "Drama",
    //     "https://s2.glbimg.com/2QnEImPirqci_2qnvpXlvHeYwIk=/620x350/e.glbimg.com/og/ed/f/original/2019/04/26/1.jpg",
    //     9.8,
    //     ""),
    // MovielModel(
    //     "Marvel",
    //     "Drama",
    //     "https://media.gettyimages.com/id/951460824/pt/foto/paris-france-a-dc-comics-universe-poster-batman-superman-wonder-woman-the-joker-is-displayed.jpg?s=612x612&w=gi&k=20&c=tzU0NznQL7tM7MCIz5dEBZmAuKNxg5RL0CH-lZ3Tbi8=",
    //     2.9,
    //     ""),
  ];

  List<MovielModel> display_list = List.from(main_movies_list);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Filmes recentes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                display_list.map((movie) => MovieItem(movie: movie)).toList(),
          ),
        ),
      ],
    );
  }
}

class MovieItem extends StatelessWidget {
  final MovielModel movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: Container(
        width: 190,
        height: 300,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xFF292B37),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                movie.movie_poster_url!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
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
                    movie.movie_title!,
                    style: TextStyle(
                      color: Color(0xFF00A470),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    movie.movie_release_year!,
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text(
                        movie.rating.toString(),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
