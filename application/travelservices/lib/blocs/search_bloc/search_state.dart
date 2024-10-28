import 'package:equatable/equatable.dart';
import 'package:travelservices/models/product_model.dart';

class SearchState extends Equatable {
  
  final bool statusBar;
  final bool statusSearch;
  final bool getLoading;


  final List<ProductData> products;

  final String strSearch;
  final bool statusStrSearch;

  final int area;
  final bool statusAreaSearch;

  final int category;
  final bool statusCategorySearch;

  final String sortSearch;
  final bool statusSearchSort;

  final bool categoryIsvisible;
  final bool areaIsvisible;

  final List<bool> optionSort;

  const SearchState({
    required this.strSearch,
    required this.area,
    required this.category,
    required this.products,
    required this.getLoading,
    required this.statusBar,
    required this.statusSearch,
    required this.statusStrSearch,
    required this.statusAreaSearch,
    required this.statusCategorySearch,
    required this.sortSearch,
    required this.statusSearchSort,
    required this.categoryIsvisible,
    required this.areaIsvisible,
    required this.optionSort
  });

  factory SearchState.empty() {
    return SearchState(
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
    );
  }

  SearchState copyWith({
    bool? getLoading,
    bool? statusBar,
    bool? statusSearch,
    bool? statusStrSearch,
    bool? statusAreaSearch,
    bool? statusCategorySearch,
    bool? statusSearchSort,
    List<ProductData>? products,
    int? category,
    int? area,
    String? strSearch,
    String? sortSearch,
    bool? categoryIsvisible,
    bool? areaIsvisible,
    List<bool>? optionSort,
  }) {
    return SearchState(
      getLoading: getLoading ?? this.getLoading, 
      statusBar: statusBar ?? this.statusBar,
      statusSearch: statusSearch ?? this.statusSearch,
      statusStrSearch: statusStrSearch ?? this.statusStrSearch,
      statusAreaSearch: statusAreaSearch ?? this.statusAreaSearch,
      statusCategorySearch: statusCategorySearch ?? this.statusCategorySearch,
      statusSearchSort: statusSearchSort ?? this.statusSearchSort,
      products: products ?? this.products,  
      area: area ?? this.area, 
      category: category ?? this.category, 
      strSearch: strSearch ?? this.strSearch,
      sortSearch: sortSearch ?? this.sortSearch,
      categoryIsvisible: categoryIsvisible ?? this.categoryIsvisible,
      areaIsvisible: areaIsvisible ?? this.areaIsvisible,
      optionSort: optionSort ?? this.optionSort
    );
  }
  
  @override
  List<Object?> get props => [
    getLoading, 
    statusBar, 
    statusSearch, 
    statusStrSearch, 
    statusAreaSearch, 
    statusCategorySearch, 
    statusSearchSort, 
    products, 
    area, 
    strSearch, 
    category, 
    sortSearch,
    categoryIsvisible,
    areaIsvisible,
    optionSort
  ];
}