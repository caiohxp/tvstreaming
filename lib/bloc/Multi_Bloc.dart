import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tvabertaflix/model/Multi_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MultiEvent {}

class FetchMultiEvent extends MultiEvent {
  final String query;

  FetchMultiEvent(this.query);
}

class ToggleFavoriteEvent extends MultiEvent {
  final MultiModel item;

  ToggleFavoriteEvent(this.item);
}

class ClearSearchEvent extends MultiEvent {}

abstract class MultiState {}

class MultiLoadedState extends MultiState {
  final List<MultiModel> items;
  final Set<int> favoriteItemIds;

  MultiLoadedState(this.items, this.favoriteItemIds);
}

class MultiErrorState extends MultiState {
  final String errorMessage;

  MultiErrorState(this.errorMessage);
}

class MultiBloc extends Bloc<MultiEvent, MultiState> {
  final String apiKey = 'ce66f929b5e2c0cc28b17c0b741d0459';

  MultiBloc() : super(MultiLoadedState([], {})) {
    on<FetchMultiEvent>(_mapFetchMultiEventToState);
    on<ToggleFavoriteEvent>(_mapToggleFavoriteEventToState);
    on<ClearSearchEvent>(_mapClearSearchEventToState);
    _loadFavoriteIds();
  }

  Future<void> fetchMulti(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<MultiModel> items = (data['results'] as List)
            .map((itemJson) => MultiModel.fromJson(itemJson))
            .toList();
        print(jsonEncode(items[0]));
        emit(MultiLoadedState(
            items,
            state is MultiLoadedState
                ? (state as MultiLoadedState).favoriteItemIds
                : {}));
      } else {
        throw Exception('Erro ao carregar resultados da busca');
      }
    } catch (e) {
      emit(MultiErrorState('Erro ao carregar resultados da busca: $e'));
    }
  }

  Future<void> _mapFetchMultiEventToState(
    FetchMultiEvent event,
    Emitter<MultiState> emit,
  ) async {
    await fetchMulti(event.query);
  }

  Future<void> _mapToggleFavoriteEventToState(
    ToggleFavoriteEvent event,
    Emitter<MultiState> emit,
  ) async {
    if (state is MultiLoadedState) {
      final currentState = state as MultiLoadedState;
      final Set<int> updatedFavorites = Set.from(currentState.favoriteItemIds);
      if (event.item.id != null) {
        if (updatedFavorites.contains(event.item.id)) {
          updatedFavorites.remove(event.item.id);
        } else {
          updatedFavorites.add(event.item.id);
        }
        await _saveFavoriteIds(updatedFavorites);
        emit(MultiLoadedState(currentState.items, updatedFavorites));
      }
    }
  }

  void _mapClearSearchEventToState(
    ClearSearchEvent event,
    Emitter<MultiState> emit,
  ) {
    emit(MultiLoadedState(
        [],
        state is MultiLoadedState
            ? (state as MultiLoadedState).favoriteItemIds
            : {}));
  }

  Future<void> _loadFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs
            .getStringList('favoriteItemIds')
            ?.map((id) => int.parse(id))
            .toSet() ??
        {};
    if (state is MultiLoadedState) {
      emit(MultiLoadedState((state as MultiLoadedState).items, favoriteIds));
    }
  }

  Future<void> _saveFavoriteIds(Set<int> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favoriteItemIds', favoriteIds.map((id) => id.toString()).toList());
  }
}
