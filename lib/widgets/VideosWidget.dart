import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tvabertaflix/widgets/PlayerScreen.dart';

class YouTubeVideoWidget extends StatelessWidget {
  final List<String> videoIds;

  YouTubeVideoWidget({required this.videoIds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoIds.length,
      itemBuilder: (context, index) {
        final videoId = YoutubePlayer.convertUrlToId(videoIds[index]);

        return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PLayerScreen(videoId: videoId)));
            },
              child:
                  Image.network(YoutubePlayer.getThumbnail(videoId: videoId!)));
      },
    );
  }

  Widget thumbNail(){
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 200,
          child: const Center(
            child: Text("THUMBNAIL"),
          )
        );
  }
}
