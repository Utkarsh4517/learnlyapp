import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';
import 'package:learnlyapp/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:learnlyapp/models/milestone_model.dart';

class MileStoneListtile extends StatefulWidget {
  final List<MilestoneModel> milestones;
  final DashboardBloc dashboardBloc;
  final MilestoneModel milestoneModel;
  final int index;
  const MileStoneListtile({
    required this.dashboardBloc,
    required this.milestones,
    required this.milestoneModel,
    required this.index,
    super.key,
  });

  @override
  State<MileStoneListtile> createState() => _MileStoneListtileState();
}

class _MileStoneListtileState extends State<MileStoneListtile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: widget.dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: getScreenWidth(context),
          decoration: BoxDecoration(
              color: lightPink, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(
            horizontal: getScreenWidth(context) * 0.05,
            vertical: getScreenWidth(context) * 0.03,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(context) * 0.05,
            vertical: getScreenWidth(context) * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.milestoneModel.time.toString(),
                    style: GoogleFonts.chivo(
                      color: purpleColor,
                      fontSize: getScreenWidth(context) * 0.05,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                            onPressed: () {
                              widget.dashboardBloc
                                  .add(DashboardEditButtonClickedEvent(
                                milestones: widget.milestones,
                                index: widget.index,
                              ));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                            onPressed: () {
                              widget.dashboardBloc
                                  .add(DashboardDeleteButtonClickedEvent(
                                milestones: widget.milestones,
                                index: widget.index,
                              ));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'Milestone type: ',
                style: GoogleFonts.roboto(
                  color: purpleColor,
                  fontSize: getScreenWidth(context) * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: getScreenWidth(context) * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white.withAlpha(90),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(
                  getScreenWidth(context) * 0.015,
                ),
                child: Text(widget.milestoneModel.milestoneType),
              ),
              Text(
                'Additional Notes: ',
                style: GoogleFonts.roboto(
                  color: purpleColor,
                  fontSize: getScreenWidth(context) * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: getScreenWidth(context) * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white.withAlpha(90),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(
                  getScreenWidth(context) * 0.015,
                ),
                child: Text(widget.milestoneModel.additionalNotes),
              ),
            ],
          ),
        );
      },
    );
  }
}
