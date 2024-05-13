import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_modulo_4/pages/CategoryPage.dart';
import 'package:projeto_modulo_4/pages/HomePages.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF0F111D),
        ),
        routes: {
          "/": (context) => HomePage(),
          "categoryPage": (context) => CategoryPage(),
          "movieDetailsPage": (context) => MovieDetailsPage(movie: null),
        });
  }
}
