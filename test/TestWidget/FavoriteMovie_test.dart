import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_modulo_4/widgets/FavoriteMoviesWidget.dart';


import 'package:responsive_styles/responsive/responsive.dart';

void main() {
  group('Testes de FavoriteMoviesWidget:', () {
    testWidgets('Teste da cor do texto e do botão "Favorite Movies"',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return FavoriteMoviesWidget(
                favoriteMovies: [],
                favoriteSeries: [],
                responsive: Responsive(context),
              );
            },
          ),
        ),
      ));

      final favoriteMoviesButton =
          find.widgetWithText(ElevatedButton, 'Favorite Movies');
      expect(favoriteMoviesButton, findsOneWidget);

      final textWidget =
          tester.widget<ElevatedButton>(favoriteMoviesButton).child as Text;
      expect(textWidget.style?.color, Colors.white);
    });

    testWidgets('Teste do tamanho da fonte do texto do botão "Favorite Movies"',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return FavoriteMoviesWidget(
                favoriteMovies: [],
                favoriteSeries: [],
                responsive: Responsive(context),
              );
            },
          ),
        ),
      ));

      final favoriteMoviesButton =
          find.widgetWithText(ElevatedButton, 'Favorite Movies');
      expect(favoriteMoviesButton, findsOneWidget);

      final textWidget =
          tester.widget<ElevatedButton>(favoriteMoviesButton).child as Text;
      expect(textWidget.style?.fontSize, 15);
    });
  });
}
