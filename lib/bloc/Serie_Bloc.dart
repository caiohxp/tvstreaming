import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/model/Serie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SerieEvent {}

class FetchSeriesEvent extends SerieEvent {}

abstract class SerieState {}

class SeriesLoadedState extends SerieState {
  final List<SerieModel> series;

  SeriesLoadedState(this.series);
}

class SerieErrorState extends SerieState {
  final String errorMessage;

  SerieErrorState(this.errorMessage);
}

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  SerieBloc() : super(SeriesLoadedState([]));
   
  

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
        emit(SeriesLoadedState(series));
      } else {
        throw Exception('Erro ao carregar Séries');
      }
    } catch (e) {
      emit(SerieErrorState('Erro ao carregar Séries: $e'));
    }
  }

  @override
  Stream<SerieState> mapEventToState(SerieEvent event) async* {
    if (event is FetchSeriesEvent) {
      yield* _mapFetchSeriesEventToState(event);
    }
  }

  

  Stream<SerieState> _mapFetchSeriesEventToState(
    FetchSeriesEvent event,
  ) async* {
    try {
      await fetchSeries();
    } catch (e) {
      yield SerieErrorState('Erro ao carregar Séries: $e');
    }
  }
}
