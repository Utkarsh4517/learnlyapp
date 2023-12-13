part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class AddMilestoneButtonClickedEvent extends HomeEvent {

}

class SaveANewMilestoneEvent extends HomeEvent {
  final List<MilestoneModel> milestones;
  SaveANewMilestoneEvent({
    required this.milestones,
  });
}
