import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tvabertaflix/model/Multi_model.dart';
import 'dart:convert';

abstract class DiscoverMovieEvent {}

class FetchDiscoverMoviesEvent extends DiscoverMovieEvent {
  final List<int> genreIds;

  FetchDiscoverMoviesEvent(this.genreIds);
}

abstract class DiscoverMovieState {}

class DiscoverMovieLoadedState extends DiscoverMovieState {
  final List<MultiModel> movies;

  DiscoverMovieLoadedState(this.movies);
}

class DiscoverMovieErrorState extends DiscoverMovieState {
  final String errorMessage;

  DiscoverMovieErrorState(this.errorMessage);
}

class DiscoverMovieBloc extends Bloc<DiscoverMovieEvent, DiscoverMovieState> {
  final String apiKey = 'ce66f929b5e2c0cc28b17c0b741d0459';

  DiscoverMovieBloc() : super(DiscoverMovieLoadedState([])) {
    on<FetchDiscoverMoviesEvent>(_mapFetchDiscoverMoviesEventToState);
  }

  Future<void> _mapFetchDiscoverMoviesEventToState(
    FetchDiscoverMoviesEvent event,
    Emitter<DiscoverMovieState> emit,
  ) async {
    try {
      final genreIds = event.genreIds.join(',');
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreIds'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<MultiModel> movies = (data['results'] as List)
            .map((itemJson) => MultiModel.fromJson(itemJson))
            .toList();
        emit(DiscoverMovieLoadedState(movies));
      } else {
        throw Exception('Erro ao carregar filmes');
      }
    } catch (e) {
      emit(DiscoverMovieErrorState('Erro ao carregar filmes: $e'));
    }
  }
}
