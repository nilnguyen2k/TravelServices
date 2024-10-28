import 'package:equatable/equatable.dart';
import 'package:travelservices/models/category_model.dart';

class CategoryState extends Equatable {

  final List<CategoryData> categories;
  final bool getLoading;

  final bool statusClick;
  final CategoryData? clickCategory;

  const CategoryState({
    required this.categories,
    required this.getLoading,
    required this.statusClick,
    this.clickCategory
  });

  factory CategoryState.empty() {
    return const CategoryState(
      categories: <CategoryData>[], 
      getLoading: false, 
      statusClick: false, 
      clickCategory: null
    );
  }

  CategoryState copyWith ({
    List<CategoryData>? categories,
    bool? stateCategories,
    bool? getLoading,
    bool? statusClick,
    CategoryData? clickCategory
  }) {
    return CategoryState(
      categories: categories ?? this.categories, 
      getLoading: getLoading ?? this.getLoading,
      statusClick: statusClick ?? this.statusClick,
      clickCategory: clickCategory ?? this.clickCategory
    );
  }

  @override
  List<Object?> get props => [categories, getLoading, statusClick, clickCategory];

}