import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';

class UpcomingWidget extends StatelessWidget{
  
static List<MovielModel> main_movies_list = [
    MovielModel(
        "Marvel",
        "",
        "https://s2.glbimg.com/2QnEImPirqci_2qnvpXlvHeYwIk=/620x350/e.glbimg.com/og/ed/f/original/2019/04/26/1.jpg",
        9.9),
    MovielModel(
        "Capitao",
        "",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgXX4PNN4ZPSmOiuHVQyNlo-Mlip8bOlZDjO5dRAZmQA&s",
        9.9),
    MovielModel(
        "Mulher",
        "",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8e3JTsJ4aZNTJDYT8AW5S1kSwJLqSxC7OWnGHeCgQJg&s",
        9.9),
    MovielModel(
        "Homem",
        "",
        "https://s2.glbimg.com/2QnEImPirqci_2qnvpXlvHeYwIk=/620x350/e.glbimg.com/og/ed/f/original/2019/04/26/1.jpg",
        9.9),
    MovielModel(
        "Marvel",
        "",
        "https://s2.glbimg.com/2QnEImPirqci_2qnvpXlvHeYwIk=/620x350/e.glbimg.com/og/ed/f/original/2019/04/26/1.jpg",
        9.9),
    MovielModel(
        "Marvel",
        "",
        "https://media.gettyimages.com/id/951460824/pt/foto/paris-france-a-dc-comics-universe-poster-batman-superman-wonder-woman-the-joker-is-displayed.jpg?s=612x612&w=gi&k=20&c=tzU0NznQL7tM7MCIz5dEBZmAuKNxg5RL0CH-lZ3Tbi8=",
        9.9)
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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
          for (var movie in display_list)
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
              movie.movie_poster_url!,
              
              height: 180,
              width: 300,
              fit: BoxFit.cover,
              )        
            ),
            )
        ],)
      )

      ],
    );
  }

}