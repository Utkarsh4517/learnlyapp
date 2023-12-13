import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnlyapp/models/milestone_model.dart';
import 'package:learnlyapp/service/milestone_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeIntialEvent);
    on<AddMilestoneButtonClickedEvent>(addMilestoneButtonClickedEvent);
    on<SaveANewMilestoneEvent>(saveANewMilestoneEvent);
  }

  FutureOr<void> homeIntialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    final milestones = await MilestoneService.loadMilestones();
    if (milestones.isNotEmpty) {
      emit(HomeMilestoneExistState(milestones: milestones));
      emit(HomeMilestoneExistActionState(milestones: milestones));
    } else {
      emit(HomeMilestoneDoesNotExistState());
    }
  }

  FutureOr<void> addMilestoneButtonClickedEvent(
      AddMilestoneButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(AddMilestoneButtonClickedState());
  }

  FutureOr<void> saveANewMilestoneEvent(
      SaveANewMilestoneEvent event, Emitter<HomeState> emit) async {
    if (event.milestones.length == 1) {
      emit(HomeMilestoneExistState(milestones: event.milestones));
    }
    await MilestoneService.saveMilestones(milestones: event.milestones);
    emit(AddedANewMilestoneState(milestones: event.milestones));
  }
}
