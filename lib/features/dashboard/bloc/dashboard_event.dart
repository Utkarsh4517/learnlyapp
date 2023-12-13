part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardDeleteButtonClickedEvent extends DashboardEvent {
  final List<MilestoneModel> milestones;
  final int index;
  DashboardDeleteButtonClickedEvent({
    required this.milestones,
    required this.index,
  });
}

class DashboardEditButtonClickedEvent extends DashboardEvent {
  final List<MilestoneModel> milestones;
  final int index;
  DashboardEditButtonClickedEvent({
    required this.milestones,
    required this.index,
  });
}

class DashboardSaveButtonClickedEvent extends DashboardEvent {
  final List<MilestoneModel> milestones;
  final int index;
  final String newMilestoneType;
  final String newAdditionalNotes;
  DashboardSaveButtonClickedEvent({
    required this.milestones,
    required this.index,
    required this.newAdditionalNotes,
    required this.newMilestoneType,
  });
}
