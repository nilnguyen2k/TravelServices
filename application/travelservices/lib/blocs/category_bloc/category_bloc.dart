import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/repositories/category_repositories.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryRepository categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryState.empty()){
    on<CategoryLoadEvent>(onCategoryLoad);
    on<CategoryClickEvent>(onCategoryClick);
    on<CategoryResetEvent>(onCategoryReset);
  }  

  void onCategoryLoad(CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(getLoading: true));
    List<CategoryData> data = await categoryRepository.getListCategories("public/category");
    emit(state.copyWith(categories: data, getLoading: false));
  }

  void onCategoryClick(CategoryClickEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(clickCategory: event.category, statusClick: true));
  }

  void onCategoryReset(CategoryResetEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(
      categories: state.categories, 
      getLoading: false, 
      statusClick: false,
      clickCategory: null
    ));
  }
}