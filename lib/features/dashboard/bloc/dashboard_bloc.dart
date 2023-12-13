import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnlyapp/models/milestone_model.dart';
import 'package:learnlyapp/service/milestone_service.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
    on<DashboardDeleteButtonClickedEvent>(dashboardDeleteButtonClickedEvent);
    on<DashboardEditButtonClickedEvent>(dashboardEditButtonClickedEvent);
    on<DashboardSaveButtonClickedEvent>(dashboardSaveButtonClickedEvent);
  }

  FutureOr<void> dashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    final milestones = await MilestoneService.loadMilestones();
    if (milestones.isNotEmpty) {
      emit(DashboardMilestoneExistState(milestones: milestones));
      emit(DashboardMilestonesLoadedState(milestones: milestones));
    } else {
      emit(DashboardMilestoneDoesNotExistState());
    }
  }

  FutureOr<void> dashboardDeleteButtonClickedEvent(
      DashboardDeleteButtonClickedEvent event, Emitter<DashboardState> emit) {
    final milestones = MilestoneService.deleteMilestones(
        milestones: event.milestones, index: event.index);
    emit(DashboardDeleteMilestoneState(milestones: milestones));
  }

  FutureOr<void> dashboardEditButtonClickedEvent(
      DashboardEditButtonClickedEvent event, Emitter<DashboardState> emit) {
    emit(DashboardEditButtonClickedState(
      index: event.index,
      milestones: event.milestones,
    ));
  }

  FutureOr<void> dashboardSaveButtonClickedEvent(
      DashboardSaveButtonClickedEvent event, Emitter<DashboardState> emit) {
    emit(DashboardMilestoneSavedState(
        index: event.index,
        milestones: event.milestones,
        newAdditionalNotes: event.newAdditionalNotes,
        newMilestoneType: event.newMilestoneType));
  }
}
