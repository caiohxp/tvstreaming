import 'package:flutter_test/flutter_test.dart';
import 'movie_bloc_add_to_favorites_.dart';




void main() {
  group('Favorite Functions', () {
    test('Add to Favorites', () {
      final favorites = <String>[];
      addToFavorites(favorites, 'Movie 1');
      expect(favorites, contains('Movie 1'));
    });

    test('Remove from Favorites', () {
      final favorites = ['Movie 1'];
      removeFromFavorites(favorites, 'Movie 1');
      expect(favorites, isNot(contains('Movie 1')));
    });
  });
}




