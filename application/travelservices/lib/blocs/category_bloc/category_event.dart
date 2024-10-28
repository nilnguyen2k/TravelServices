import 'package:equatable/equatable.dart';
import 'package:travelservices/models/category_model.dart';

class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryLoadEvent extends CategoryEvent {}

class CategoryClickEvent extends CategoryEvent {
  final CategoryData category;
  const CategoryClickEvent({
    required this.category
  });
}

class CategoryResetEvent extends CategoryEvent{
  const CategoryResetEvent();
}