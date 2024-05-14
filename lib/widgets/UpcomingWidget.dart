import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';

class UpcomingWidget extends StatelessWidget {
  static List<MovielModel> main_movies_list = [
    MovielModel(
        "Furiosa",
        "",
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiT56K1sSDetrYPt4IJmZPlD90qvdoK7rLcfB5YgEfTyoW7FeamhpUoly-r6Bk-6vsDyTl6GNM82mS4wgkfyzv3eXpC2CNXP4DTdbKJieuD_jpBUR9EEriWfTaKmgYkOuUJ8hkrh0GDN-Hs072_bbSeEElcAxC7zdSg1gbA1sj6rYKg7vrJmV8050lRheuU/s16000-rw/mad%20max%20nerdview.png",
        9.9,
        ""),
    MovielModel(
        "BadBoy",
        "",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPCosO26RXMqYGvkT2ToANORS7w5YO0WRWivEtc6UaYA&s",
        9.9,
        ""),
    MovielModel(
        "Mulher",
        "",
        "https://oyster.ignimgs.com/wordpress/stg.ign.com/2021/03/GDVK003DOM_Exclusive_1200x1200_ENG_DR_V2_R1_watermark.jpg",
        9.9,
        ""),
    MovielModel(
        "Homem",
        "",
        "https://feira.tangerina.news/wp-content/uploads/2024/03/poster-godzilla-kong-novo-imperio-warner-bros.jpg",
        9.9,
        ""),
    MovielModel(
        "Marvel",
        "",
        "https://pbs.twimg.com/media/GGZTlXnWMAARolB.jpg:large",
        9.9,
        ""),
    
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
                        )),
                  )
              ],
            ))
      ],
    );
  }
}
