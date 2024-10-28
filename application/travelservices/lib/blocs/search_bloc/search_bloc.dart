import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/blocs/search_bloc/search_state.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/repositories/favorite_repositories.dart';
import 'package:travelservices/repositories/product_repositories.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {


  // Repo
  ProductRepository productRepository = ProductRepository();
  FavoriteRepository favoriteRepository = FavoriteRepository();
  
  // Bloc
  final FavoriteBloc favoriteBloc;
  final NavbarBloc navbarBloc;

  // Stream
  StreamSubscription? streamNavbar;
  
  SearchBloc({
    required this.favoriteBloc,
    required this.navbarBloc,
  }) : super(SearchState.empty()){
    on<SearchAreaEvent>(_onSearchArea);
    on<SearchCategoryEvent>(_onSearchCategory);
    on<SearchStringEvent>(_onSearchString);
    on<SearchFocusEvent>(_onSearchFocus);
    on<SearchLoadEvent>(_onSeachLoad);
    on<SearchSortEvent>(_onSearchSort);
    on<SearchByClickCategoryIconEvent>(_onSearchCategoryIcon);
    on<SearchByClickAreaIconEvent>(_onSearchAreaIcon);
    on<SearchResetEvent>(_onSearchReset);
  }
  

  void _onSearchArea(SearchAreaEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(statusAreaSearch: true, area: event.idArea));
    add(SearchLoadEvent());
  }

  void _onSearchCategory(SearchCategoryEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(statusCategorySearch: true, category: event.idCategory));
    add(SearchLoadEvent());
  }

  void _onSearchString(SearchStringEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      statusStrSearch: true, 
      strSearch: event.strSearch, 
      areaIsvisible: true, 
      categoryIsvisible: true
    ));
    add(SearchLoadEvent());
  }

  void _onSearchSort(SearchSortEvent event, Emitter<SearchState> emit) {
    List<bool> optionSort = List.generate(4, (index) => false);
    if (event.sort == "AscOrders") {
      optionSort[0] = true;
    }
    if (event.sort == "DescOrders") {
      optionSort[1] = true;
    }
    if (event.sort == "AscReviews") {
      optionSort[2] = true;
    }
    if (event.sort == "DescReviews") {
      optionSort[3] = true;
    }
    emit(state.copyWith(statusSearchSort: true, sortSearch: event.sort, optionSort: optionSort));
    add(SearchLoadEvent());
  }

  void _onSearchCategoryIcon(SearchByClickCategoryIconEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      statusCategorySearch: true, 
      category: event.idCategory,
      areaIsvisible: true, 
      categoryIsvisible: true,
    ));
    add(SearchLoadEvent());
  }

  void _onSearchAreaIcon(SearchByClickAreaIconEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      statusAreaSearch: true,
      area: event.idArea,
      areaIsvisible: true, 
      categoryIsvisible: true,
    ));
    add(SearchLoadEvent());
  }

  void _onSearchFocus(SearchFocusEvent event, Emitter<SearchState> emit) {

    emit(state.copyWith(statusBar: event.focusStatus));

    streamNavbar = navbarBloc.stream.listen((state) async {
      var navbarState = state;
      if (navbarState.statusSearch) {
        add(SearchFocusEvent(true));
      }
    });
  }

  void _onSearchReset(SearchResetEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      getLoading: false, 
      statusBar: false, 
      statusSearch: false,
      statusAreaSearch: false,
      statusCategorySearch: false,
      statusStrSearch: false,
      statusSearchSort: false,
      products: const <ProductData>[], 
      strSearch: '',
      area: 0,
      category: 0,
      sortSearch: '',
      categoryIsvisible: false,
      areaIsvisible: false,
      optionSort: List.generate(4, (index) => false)
    ));
  }

  void _onSeachLoad(SearchLoadEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(getLoading: true));
    List<ProductData> data = [];
    if (state.statusAreaSearch) {
      if (state.statusCategorySearch) {
        if (state.statusStrSearch) {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&area=${state.area}&category=${state.category}&search=${state.strSearch}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&area=${state.area}&category=${state.category}&search=${state.strSearch}");
          }
        } else {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&area=${state.area}&category=${state.category}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&area=${state.area}&category=${state.category}");
          }
        }
      } else {
        if (state.statusStrSearch) {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&area=${state.area}&search=${state.strSearch}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&area=${state.area}&search=${state.strSearch}");
          }
        } else {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&area=${state.area}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&area=${state.area}");
          }
        }
      } 
    } else {
      if (state.statusCategorySearch) {
        if (state.statusStrSearch) {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&category=${state.category}&search=${state.strSearch}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&category=${state.category}&search=${state.strSearch}");
          }
        } else {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&category=${state.category}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&category=${state.category}");
          }
        }
      } else {
        if (state.statusStrSearch) {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}&search=${state.strSearch}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&search=${state.strSearch}");
          }
        } else {
          if (state.statusSearchSort) {
            data = await productRepository.getListProduct("public/service?page=1&limit=99&sort=${state.sortSearch}");
          } else {
            data = await productRepository.getListProduct("public/service?page=1&limit=99");
          }
        } 
      }
    }
    emit(state.copyWith(getLoading: false, products: data, statusSearch: true));
  } 
}