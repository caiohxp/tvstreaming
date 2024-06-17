import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'package:projeto_modulo_4/widgets/MovieItem.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';

void main() {
  testWidgets('Teste de Renderização do NewMoviesWidget',
      (WidgetTester tester) async {
    // Dados de teste para o NewMoviesWidget
    final movies = [
      MultiModel(
        id: 1,
        mediaType: 'movie',
        title: 'Filme 1',
        overview: 'Overview do Filme 1',
        posterPath: '/path1.jpg',
        genreIds: [1, 2],
        voteAverage: 8.5,
        releaseDate: '2023-01-01',
      ),
      MultiModel(
        id: 2,
        mediaType: 'movie',
        title: 'Filme 2',
        overview: 'Overview do Filme 2',
        posterPath: '/path2.jpg',
        genreIds: [3, 4],
        voteAverage: 7.5,
        releaseDate: '2023-02-01',
      ),
    ];

    // Renderiza o widget NewMoviesWidget para teste
    await tester.pumpWidget(MaterialApp(
      home: NewMoviesWidget(movies: movies),
    ));

    // Verifica se os elementos dos filmes são renderizados corretamente
    expect(find.text('Filmes recentes'), findsOneWidget);
    expect(find.text('Filme 1'), findsOneWidget);
    expect(find.text('Filme 2'), findsOneWidget);
    expect(find.byType(MovieItem),
        findsNWidgets(2)); // Verifica se há dois MovieItems
  });
}
