import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';
import 'package:learnlyapp/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:learnlyapp/features/dashboard/widgets/milestone_listtile.dart';
import 'package:learnlyapp/models/milestone_model.dart';
import 'package:learnlyapp/service/milestone_service.dart';
import 'package:learnlyapp/shared/custom_button.dart';
import 'package:learnlyapp/shared/custom_text.dart';
import 'package:learnlyapp/shared/details_text_field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardBloc = DashboardBloc();
  List<MilestoneModel> milestones = [];

  @override
  void initState() {
    dashboardBloc.add(DashboardInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {
        if (state is DashboardMilestonesLoadedState) {
          setState(() {
            milestones = state.milestones;
          });
        } else if (state is DashboardDeleteMilestoneState) {
          setState(() {
            milestones = state.milestones;
          });
        } else if (state is DashboardEditButtonClickedState) {
          // open a dialog box to edit milestones
          _showEditBox(
            context: context,
            index: state.index,
            milestones: state.milestones,
          );
        } else if (state is DashboardMilestoneSavedState) {
          setState(() {
            milestones[state.index].milestoneType = state.newMilestoneType;
            milestones[state.index].additionalNotes = state.newAdditionalNotes;
          });
          MilestoneService.saveMilestones(milestones: milestones);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DashboardMilestoneDoesNotExistState:
            return const Scaffold(
              body: Center(
                child: Text('No milestones exist'),
              ),
            );
          case DashboardMilestoneExistState:
            // final successState = state as DashboardMilestoneExistState;
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getScreenWidth(context) * 0.05,
                      ),
                      const CustomPinkText(
                        text: 'Manage all the milestones : ',
                        sizeFactor: 0.05,
                      ),
                      SizedBox(
                        height: getScreenheight(context) * 0.8,
                        child: ListView.builder(
                          itemCount: milestones.length,
                          itemBuilder: (context, index) {
                            MilestoneModel milestoneModel = milestones[index];
                            return MileStoneListtile(
                              dashboardBloc: dashboardBloc,
                              milestones: milestones,
                              milestoneModel: milestoneModel,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          default:
            return const Scaffold(
              body: Center(
                child: Text('ERROR STATE'),
              ),
            );
        }
      },
    );
  }

  // function to return a dialog box to edit milestones
  void _showEditBox({
    required BuildContext context,
    required List<MilestoneModel> milestones,
    required int index,
  }) {
    final milestoneTypeController =
        TextEditingController(text: milestones[index].milestoneType);
    final additionalNotesController =
        TextEditingController(text: milestones[index].additionalNotes);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: lightPink, borderRadius: BorderRadius.circular(20)),
            height: getScreenheight(context) * 0.5,
            child: Column(
              children: [
                DetailsTextField(
                    controller: milestoneTypeController,
                    label: 'Milestone type'),
                DetailsTextField(
                    controller: additionalNotesController,
                    label: 'Any additional notes'),
                SizedBox(height: getScreenWidth(context) * 0.12),
                CustomButton(
                    text: 'Done',
                    function: () {
                      dashboardBloc.add(DashboardSaveButtonClickedEvent(
                        milestones: milestones,
                        index: index,
                        newAdditionalNotes: additionalNotesController.text,
                        newMilestoneType: milestoneTypeController.text,
                      ));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
