import 'package:equatable/equatable.dart';

class NavbarEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class NavbarHomePageEvent extends NavbarEvent {
  NavbarHomePageEvent();
}

class NavbarSearchPageEvent extends NavbarEvent {
  NavbarSearchPageEvent();
}

class NavbarFavoritePageEvent extends NavbarEvent {
  NavbarFavoritePageEvent();
}

class NavbarProfilePageEvent extends NavbarEvent {
  NavbarProfilePageEvent();
}

class NavbarSearchStatusEvent extends NavbarEvent {
  NavbarSearchStatusEvent();
}