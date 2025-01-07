import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tvabertaflix/bloc/Movie_Bloc.dart';
import 'package:tvabertaflix/model/Multi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieBloc', () {
    late MovieBloc movieBloc;
    late MockClient mockClient;

    setUp(() {

      SharedPreferences.setMockInitialValues({});
   
      mockClient = MockClient((request) async {
        final movieJson = {
          'id': 1,
          'title': 'Test Movie',
          'media_type': '',
          'overview': '',
          'genre_ids': [],
          'vote_average': 7.5,
          'release_date': '2023-01-01',
          'poster_path': '/example.jpg',
        };
        final movieResponse = jsonEncode({
          'results': [movieJson]
        });
        return http.Response(movieResponse, 200);
      });

  
      movieBloc = MovieBloc()..httpClient = mockClient;
    });

    tearDown(() {
      movieBloc.close();
    });

 

    test('Alternar favorito e Atualizar estado', () async {
  
      final movie = MultiModel(
        id: 1,
        title: 'Test Movie',
        mediaType: '',
        overview: '',
        genreIds: [],
        voteAverage: 7.5,
        releaseDate: '2023-01-01',
        posterPath: '/example.jpg',
      );

      movieBloc.add(FetchMoviesEvent());
      await Future.delayed(Duration.zero); 

  
      movieBloc.add(ToggleFavoriteEvent(movie));
      await Future.delayed(Duration.zero); 

      
      expect(movieBloc.state, isA<MoviesLoadedState>());
      final currentState = movieBloc.state as MoviesLoadedState;
      expect(currentState.favoriteMovieIds.contains(movie.id), isTrue);
    });
  });
}
