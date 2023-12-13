part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

abstract class DashboardActionState extends DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardMilestoneExistState extends DashboardState {
  final List<MilestoneModel> milestones;
  DashboardMilestoneExistState({
    required this.milestones,
  });
}

class DashboardMilestoneDoesNotExistState extends DashboardState {}

class DashboardMilestonesLoadedState extends DashboardActionState {
  final List<MilestoneModel> milestones;
  DashboardMilestonesLoadedState({
    required this.milestones,
  });
}

class DashboardDeleteMilestoneState extends DashboardActionState {
  final List<MilestoneModel> milestones;
  DashboardDeleteMilestoneState({
    required this.milestones,
  });
}

class DashboardEditButtonClickedState extends DashboardActionState {
  final List<MilestoneModel> milestones;
  final int index;
  DashboardEditButtonClickedState({
    required this.index,
    required this.milestones,
  });
}

class DashboardMilestoneSavedState extends DashboardActionState {
  final List<MilestoneModel> milestones;
  final int index;
  final String newMilestoneType;
  final String newAdditionalNotes;
  DashboardMilestoneSavedState({
    required this.index,
    required this.milestones,
    required this.newAdditionalNotes,
    required this.newMilestoneType,
  });
}
