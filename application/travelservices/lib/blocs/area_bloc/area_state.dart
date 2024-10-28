import 'package:equatable/equatable.dart';
import 'package:travelservices/models/area_model.dart';

class AreaState extends Equatable {

  final List<AreaData> areas;
  final bool getLoading;

  final bool statusClick;
  final AreaData? clickArea;

  const AreaState({
    required this.areas,
    required this.getLoading,
    required this.statusClick,
    required this.clickArea
  });

  factory AreaState.empty() {
    return const AreaState(
      areas: <AreaData>[], 
      getLoading: false, 
      statusClick: false,
      clickArea: null
    );
  }

  AreaState copyWith ({
    List<AreaData>? areas,
    bool? getLoading,
    bool? statusClick,
    AreaData? clickArea
  }) {
    return AreaState(
      areas: areas ?? this.areas, 
      getLoading: getLoading ?? this.getLoading,
      clickArea: clickArea ?? this.clickArea,
      statusClick: statusClick ?? this.statusClick
    );
  }

  @override
  List<Object?> get props => [areas, getLoading, clickArea, statusClick];

}