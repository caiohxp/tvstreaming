import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';

void main() {
  testWidgets('"Filmes recentes:" Teste da cor do texto ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewMoviesWidget(movies: []),
      ),
    ));

   
    final textWidget = find.text("Filmes recentes");


    expect(textWidget, findsOneWidget);

    
    final TextStyle? textStyle = tester.widget<Text>(textWidget).style;

  
    expect(textStyle?.color, Colors.white); 
  });

  testWidgets( "Filmes recentes: "'Teste do tamanho da fonte do texto', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewMoviesWidget(movies: []),
      ),
    ));

   
    final textWidget = find.text("Filmes recentes");


    expect(textWidget, findsOneWidget);


    final TextStyle? textStyle = tester.widget<Text>(textWidget).style;

  
    expect(textStyle?.fontSize, 25); 
  });
}
