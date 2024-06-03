import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_modulo_4/model/Multi_model.dart';
import 'dart:convert';

abstract class DiscoverSerieEvent {}

class FetchDiscoverSeriesEvent extends DiscoverSerieEvent {
  final List<int> genreIds;

  FetchDiscoverSeriesEvent(this.genreIds);
}

abstract class DiscoverSerieState {}

class DiscoverSerieLoadedState extends DiscoverSerieState {
  final List<MultiModel> series;

  DiscoverSerieLoadedState(this.series);
}

class DiscoverSerieErrorState extends DiscoverSerieState {
  final String errorMessage;

  DiscoverSerieErrorState(this.errorMessage);
}

class DiscoverSerieBloc extends Bloc<DiscoverSerieEvent, DiscoverSerieState> {
  final String apiKey = 'ce66f929b5e2c0cc28b17c0b741d0459';

  DiscoverSerieBloc() : super(DiscoverSerieLoadedState([])) {
    on<FetchDiscoverSeriesEvent>(_mapFetchDiscoverSeriesEventToState);
  }

  Future<void> _mapFetchDiscoverSeriesEventToState(
    FetchDiscoverSeriesEvent event,
    Emitter<DiscoverSerieState> emit,
  ) async {
    try {
      final genreIds = event.genreIds.join(',');
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&with_genres=$genreIds'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<MultiModel> series = (data['results'] as List)
            .map((itemJson) => MultiModel.fromJson(itemJson))
            .toList();
        emit(DiscoverSerieLoadedState(series));
      } else {
        throw Exception('Erro ao carregar séries');
      }
    } catch (e) {
      emit(DiscoverSerieErrorState('Erro ao carregar séries: $e'));
    }
  }
}
