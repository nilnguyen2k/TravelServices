import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_event.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_state.dart';
import 'package:travelservices/screens/pages/favorite_page.dart';
import 'package:travelservices/screens/pages/home_page.dart';
import 'package:travelservices/screens/pages/profile_page.dart';
import 'package:travelservices/screens/pages/search_page.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    on<NavbarHomePageEvent>(_onHomePageEvent);
    on<NavbarSearchPageEvent>(_onSearchPageEvent);
    on<NavbarFavoritePageEvent>(_onFavoritePageEvent);
    on<NavbarProfilePageEvent>(_onProfilePageEvent);
    on<NavbarSearchStatusEvent>(_onSearchStatusEvent);
  }

  void _onHomePageEvent(NavbarHomePageEvent event, Emitter<NavbarState> emit) {
    emit(state.copyWith(widget: const HomePage(), indexItem: 0, statusSearch: false));
  }

  void _onSearchPageEvent(NavbarSearchPageEvent event, Emitter<NavbarState> emit) {
    emit(state.copyWith(widget: const SearchPage(), indexItem: 1, statusSearch: false));
  }

  void _onFavoritePageEvent(NavbarFavoritePageEvent event, Emitter<NavbarState> emit) {
    emit(state.copyWith(widget: const FavoritePage(), indexItem: 2));
  }

  void _onProfilePageEvent(NavbarProfilePageEvent event, Emitter<NavbarState> emit) {
    emit(state.copyWith(widget: const ProfilePage(), indexItem: 3, statusSearch: false));
  }

  void _onSearchStatusEvent(NavbarSearchStatusEvent event, Emitter<NavbarState> emit) {
    emit(state.copyWith(statusSearch: true));
  }
}