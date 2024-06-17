import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';

void main() {
  testWidgets('Teste da cor do texto "Filmes recentes"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewMoviesWidget(movies: []),
      ),
    ));

   
    final textWidget = find.text("Filmes recentes");

    // Verificar se o widget foi encontrado
    expect(textWidget, findsOneWidget);

    // Verificar o estilo do texto
    final TextStyle? textStyle = tester.widget<Text>(textWidget).style;

    // Verificar a cor do texto
    expect(textStyle?.color, Colors.white); 
  });

  testWidgets('Teste do tamanho da fonte do texto "Filmes recentes"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewMoviesWidget(movies: []),
      ),
    ));

    // Encontrar o widget que contém o texto "Filmes recentes"
    final textWidget = find.text("Filmes recentes");

    // Verificar se o widget foi encontrado
    expect(textWidget, findsOneWidget);

    // Verificar o estilo do texto
    final TextStyle? textStyle = tester.widget<Text>(textWidget).style;

    // Verificar o tamanho da fonte
    expect(textStyle?.fontSize, 25); 
  });
}
