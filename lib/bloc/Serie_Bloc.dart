import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/model/SerieModelDefinition.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SerieEvent {}

class FetchSeriesEvent extends SerieEvent {}

class ToggleFavoriteEvent extends SerieEvent {
  final SerieModel serie;

  ToggleFavoriteEvent(this.serie);
}

abstract class SerieState {}

class SeriesLoadedState extends SerieState {
  final List<SerieModel> series;
  final Set<int> favoriteSeriesIds;

  SeriesLoadedState(this.series, this.favoriteSeriesIds);
}

class SerieErrorState extends SerieState {
  final String errorMessage;

  SerieErrorState(this.errorMessage);
}

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  SerieBloc() : super(SeriesLoadedState([], {})) {
    on<FetchSeriesEvent>(_mapFetchSeriesEventToState);
    on<ToggleFavoriteEvent>(_mapToggleFavoriteEventToState);
  }

  Future<void> fetchSeries() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/tv/airing_today'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final seriesData = json.decode(response.body);
        final List<SerieModel> series = (seriesData['results'] as List)
            .map((serieJson) => SerieModel.fromJson(serieJson))
            .toList();
        emit(SeriesLoadedState(series, state is SeriesLoadedState ? (state as SeriesLoadedState).favoriteSeriesIds : {}));
      } else {
        throw Exception('Erro ao carregar Séries');
      }
    } catch (e) {
      emit(SerieErrorState('Erro ao carregar Séries: $e'));
    }
  }

  Future<void> _mapFetchSeriesEventToState(
    FetchSeriesEvent event,
    Emitter<SerieState> emit,
  ) async {
    await fetchSeries();
  }

  void _mapToggleFavoriteEventToState(
    ToggleFavoriteEvent event,
    Emitter<SerieState> emit,
  ) {
    if (state is SeriesLoadedState) {
      final currentState = state as SeriesLoadedState;
      final Set<int> updatedFavorites = Set.from(currentState.favoriteSeriesIds);
      if (event.serie.id != null) {
        if (updatedFavorites.contains(event.serie.id)) {
          updatedFavorites.remove(event.serie.id);
        } else {
          updatedFavorites.add(event.serie.id!);
        }
        emit(SeriesLoadedState(currentState.series, updatedFavorites));
      }
    }
  }
}
