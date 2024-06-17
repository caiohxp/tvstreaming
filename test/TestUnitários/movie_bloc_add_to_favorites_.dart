 void addToFavorites(List<String> favorites, String movie) {
    if (!favorites.contains(movie)) {
      favorites.add(movie);
    }
  }

  void removeFromFavorites(List<String> favorites, String movie) {
    favorites.remove(movie);
  }

