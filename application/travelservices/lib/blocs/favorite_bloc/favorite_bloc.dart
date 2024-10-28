import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/models/favorite_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/repositories/favorite_repositories.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  FavoriteRepository repo = FavoriteRepository();

  FavoriteBloc({
    required this.repo,
  }) : super(FavoriteState.empty()) {
    on<FavoriteReadEvent>(favoriteRead);
    on<FavoriteAddEvent>(favoriteAdd);
    on<FavoriteDeleteEvent>(favoriteDelete);
  }

  void favoriteRead(FavoriteReadEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(getLoading: true, statusAdd: true, statusDelete: true));
    var data = await repo.getListFavorite("favorite");
    emit(state.copyWith(favorites: data, getLoading: false, statusAdd: false, statusDelete: false));
  }

  void favoriteAdd(FavoriteAddEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(statusAdd: true));
    var data = await repo.insertFavorite("favorite?idService=", event.idProduct.toString());
    if (data is List<FavoriteResponseModel>) {
      emit(state.copyWith(statusAdd: false, favorites: data));
    } else {
      emit(state.copyWith(statusAdd: false, favorites: state.favorites));
    }
  }

  void favoriteDelete(FavoriteDeleteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(statusDelete: true));
    var data = await repo.deleteFavorite("favorite?idService=", event.idProduct.toString());
    if (data is List<FavoriteResponseModel>) {
      emit(state.copyWith(statusDelete: false, favorites: data));
    } else {
      emit(state.copyWith(statusDelete: false, favorites: state.favorites));
    }
  }

}