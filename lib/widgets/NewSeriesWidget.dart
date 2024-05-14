import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';

class NewSeriesWidget extends StatelessWidget {
  static List<MovielModel> main_movies_list = [
    MovielModel(
        
        "The Boys",
        "Drama",
        "https://rukminim2.flixcart.com/image/750/900/l407mvk0/poster/e/z/5/large-the-boys-poster-18-x-12-inch-300-gsm-t0141-original-imagezaw5ezbgptp.jpeg?q=20&crop=false",
        8.8,
        "The Boys se passa em um universo onde indivíduos superpoderosos são reconhecidos como heróis pelo público em geral e pertencem à poderosa corporação Vought International, que os comercializa e monetiza."),

        
        
       
    MovielModel(
        "Mr. Robot ",
        "Drama",
        "https://assets.papelpop.com/wp-content/uploads/2019/08/mr-robot-season-four.jpg",
        8.9,
        ""),
    MovielModel(
        "Origem",
        "Ficção Fientífica",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpkFAwd5mgPkkXI35aRqUIfqD-OzIwsGUYc1DmvlsP3A&s",
        5.5,
        ""),
    MovielModel(
        "Arcajo",
        "Drama",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgr91zohv8Qtwu6j1gKLw6tSAHyMkQZZeZCPKo5hGJ5g&s",
        6.8,
        ""),
    MovielModel(
        "The Last of Us",
        "Ficção Fientífica ",
        "https://m.media-amazon.com/images/I/719fH-oJd2L._AC_UF1000,1000_QL80_.jpg",
        9.7,
        ""),
    // MovielModel(
    //     "Marvel",
    //     "Drama",
    //     "https://media.gettyimages.com/id/951460824/pt/foto/paris-france-a-dc-comics-universe-poster-batman-superman-wonder-woman-the-joker-is-displayed.jpg?s=612x612&w=gi&k=20&c=tzU0NznQL7tM7MCIz5dEBZmAuKNxg5RL0CH-lZ3Tbi8=",
    //     2.9,
    //     "")
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
                "Séries recentes",
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
