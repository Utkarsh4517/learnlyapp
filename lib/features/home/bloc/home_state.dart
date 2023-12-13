part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeMilestoneExistState extends HomeState {
  final List<MilestoneModel> milestones;
  HomeMilestoneExistState({
    required this.milestones,
  });
}

class HomeMilestoneExistActionState extends HomeActionState {
  final List<MilestoneModel> milestones;
  HomeMilestoneExistActionState({
    required this.milestones,
  });
}

class HomeMilestoneDoesNotExistState extends HomeState {}

class AddMilestoneButtonClickedState extends HomeActionState {}

class AddedANewMilestoneState extends HomeActionState {
  final List<MilestoneModel> milestones;
  AddedANewMilestoneState({
    required this.milestones,
  });
}
