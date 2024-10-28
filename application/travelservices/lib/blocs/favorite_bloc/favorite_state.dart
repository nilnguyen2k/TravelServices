import 'package:equatable/equatable.dart';
import 'package:travelservices/models/favorite_model.dart';

class FavoriteState extends Equatable {

  final bool getLoading;
  final bool statusAdd;
  final bool statusDelete;
  final List<FavoriteResponseModel> favorites;

  final bool reload;

  const FavoriteState({
    required this.getLoading,
    required this.statusAdd,
    required this.statusDelete,
    required this.favorites,
    required this.reload
  });

  factory FavoriteState.empty() {
    return const FavoriteState(
      statusAdd: false,
      statusDelete: false,
      favorites: <FavoriteResponseModel>[], 
      getLoading: false,
      reload: false
    );
  }

  FavoriteState copyWith({
    bool? getLoading,
    bool? statusAdd,
    bool? statusDelete,
    List<FavoriteResponseModel>? favorites,
    bool? reload,
  }) {
    return FavoriteState(
      getLoading: getLoading ?? this.getLoading, 
      favorites: favorites ?? this.favorites, 
      statusAdd: statusAdd?? this.statusAdd, 
      statusDelete: statusDelete ?? this.statusDelete,
      reload: reload ?? this.reload
    );
  }

  @override
  List<Object?> get props => [getLoading, favorites, statusAdd, statusDelete, reload];

}