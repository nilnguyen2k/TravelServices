import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchAreaEvent extends SearchEvent {
  final int idArea;
  SearchAreaEvent(this.idArea);
}

class SearchCategoryEvent extends SearchEvent {
  final int idCategory;
  SearchCategoryEvent(this.idCategory);
}

class SearchStringEvent extends SearchEvent {
  final String strSearch;
  SearchStringEvent(this.strSearch);
}

class SearchSortEvent extends SearchEvent {
  final String sort;
  SearchSortEvent(this.sort);
}

class SearchFocusEvent extends SearchEvent {
  final bool focusStatus;
  SearchFocusEvent(this.focusStatus);
}

class SearchLoadEvent extends SearchEvent {
  SearchLoadEvent();
}

class SearchByClickCategoryIconEvent extends SearchEvent{
  final int idCategory;
  SearchByClickCategoryIconEvent(this.idCategory);
}

class SearchByClickAreaIconEvent extends SearchEvent{
  final int idArea;
  SearchByClickAreaIconEvent(this.idArea);
}

class SearchResetEvent extends SearchEvent {
  SearchResetEvent();
}