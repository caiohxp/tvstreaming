import 'package:flutter_test/flutter_test.dart';


 void addToFavorites(List<String> favorites, String movie) {
    if (!favorites.contains(movie)) {
      favorites.add(movie);
    }
  }

  void removeFromFavorites(List<String> favorites, String movie) {
    favorites.remove(movie);
  }


void main() {
  group('Funções de favoritos:', () {
    test('Adicionar aos favoritos', () {
      final favorites = <String>[];
      addToFavorites(favorites, 'Movie 1');
      expect(favorites, contains('Movie 1'));
    });

    test('Remover dos favoritos', () {
      final favorites = ['Movie 1'];
      removeFromFavorites(favorites, 'Movie 1');
      expect(favorites, isNot(contains('Movie 1')));
    });
  });
}




 