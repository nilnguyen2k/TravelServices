import 'package:equatable/equatable.dart';
import 'package:travelservices/models/area_model.dart';

class AreaEvent extends Equatable {
  const AreaEvent();
  @override
  List<Object?> get props => [];
}

class AreaLoadEvent extends AreaEvent {}

class AreaClickEvent extends AreaEvent {
  final AreaData? area;
  const AreaClickEvent({
    required this.area
  });
}

class AreaResetEvent extends AreaEvent{
  const AreaResetEvent();
}