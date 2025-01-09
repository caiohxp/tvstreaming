// import 'package:flutter/material.dart';
// import 'package:better_player/better_player.dart';

// class StreamPlayerWidget extends StatelessWidget {
//   final String streamUrl;

//   const StreamPlayerWidget({
//     required this.streamUrl,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       streamUrl,
//     );

//     return Container(
//       height: 370, // Altura do player
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.black,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8.0),
//         child: BetterPlayer(
//           controller: BetterPlayerController(
//             BetterPlayerConfiguration(
//               aspectRatio: 16 / 9, // Configuração do aspecto do vídeo
//               autoPlay: true, // Reprodução automática
//               looping: true, // Looping automático
//               fit: BoxFit.contain,
//             ),
//             betterPlayerDataSource: dataSource,
//           ),
//         ),
//       ),
//     );
//   }
// }
