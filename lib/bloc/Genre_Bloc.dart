import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tvabertaflix/model/Genres_model.dart';

// Events
abstract class GenreEvent {}

class FetchMovieGenres extends GenreEvent {}

class FetchSerieGenres extends GenreEvent {}

// States
abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<dynamic> genres;

  GenreLoaded({required this.genres});
}

class GenreError extends GenreState {
  final String errorMessage;

  GenreError({required this.errorMessage});
}

class MovieGenreBloc extends Bloc<GenreEvent, GenreState> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  MovieGenreBloc() : super(GenreInitial()) {
    on<FetchMovieGenres>((event, emit) async {
      emit(GenreLoading());
      try {
        final response = await http.get(
          Uri.parse('https://api.themoviedb.org/3/genre/movie/list'),
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> genres = data['genres'];
          emit(GenreLoaded(
              genres: genres
                  .map((genreJson) => GenreModel.fromJson(genreJson))
                  .toList()));
        } else {
          emit(GenreError(errorMessage: 'Failed to load genres'));
        }
      } catch (e) {
        emit(GenreError(errorMessage: e.toString()));
      }
    });
  }
}

class SerieGenreBloc extends Bloc<GenreEvent, GenreState> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  SerieGenreBloc() : super(GenreInitial()) {
    on<FetchSerieGenres>((event, emit) async {
      emit(GenreLoading());
      try {
        final response = await http.get(
          Uri.parse('https://api.themoviedb.org/3/genre/tv/list'),
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> genres = data['genres'];
          emit(GenreLoaded(
              genres: genres
                  .map((genreJson) => GenreModel.fromJson(genreJson))
                  .toList()));
        } else {
          emit(GenreError(errorMessage: 'Failed to load genres'));
        }
      } catch (e) {
        emit(GenreError(errorMessage: e.toString()));
      }
    });
  }
}
