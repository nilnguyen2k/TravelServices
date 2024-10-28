import 'package:equatable/equatable.dart';

class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteReadEvent extends FavoriteEvent {
  FavoriteReadEvent();
}

class FavoriteAddEvent extends FavoriteEvent {
  final int idProduct;
  FavoriteAddEvent({
    required this.idProduct
  });
}

class FavoriteDeleteEvent extends FavoriteEvent {
  final int idProduct;
  FavoriteDeleteEvent({
    required this.idProduct
  });
}
