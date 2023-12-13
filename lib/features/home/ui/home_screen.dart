import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';
import 'package:learnlyapp/features/home/bloc/home_bloc.dart';
import 'package:learnlyapp/models/milestone_model.dart';
import 'package:learnlyapp/shared/custom_button.dart';
import 'package:learnlyapp/shared/custom_text.dart';
import 'package:learnlyapp/shared/details_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc();
  String selectedDate = '';
  List<MilestoneModel> milestones = [];
  int lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeMilestoneExistActionState) {
            setState(() {
              milestones = state.milestones;
              lastIndex = state.milestones.length - 1;
            });
          } else if (state is AddMilestoneButtonClickedState) {
            _showDialog(context);
          } else if (state is AddedANewMilestoneState) {
            setState(() {
              milestones = state.milestones;
              lastIndex = state.milestones.length - 1;
            });
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            // when milestones exist
            case HomeMilestoneExistState:
              return Scaffold(
                backgroundColor: whiteColor,
                floatingActionButton: SizedBox(
                  width: getScreenWidth(context) * 0.4,
                  child: FloatingActionButton(
                    onPressed: () {
                      _homeBloc.add(AddMilestoneButtonClickedEvent());
                    },
                    backgroundColor: pinkColor,
                    child: const Text(
                      'Add Milestone',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CustomPinkText(
                          text: 'Capture Milestones',
                          sizeFactor: 0.07,
                        ),
                        SizedBox(
                          height: getScreenheight(context) * 0.3,
                          child: Image.asset('assets/img/hug.png'),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const CustomPinkText(
                            text: "Your's child latest milestone :",
                            sizeFactor: 0.05,
                          ),
                        ),

                        // Show the latest milestone
                        Container(
                          width: getScreenWidth(context),
                          decoration: BoxDecoration(
                              color: lightPink,
                              borderRadius: BorderRadius.circular(10)),
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
                              Text(
                                milestones[lastIndex].time.toString(),
                                style: GoogleFonts.chivo(
                                  color: purpleColor,
                                  fontSize: getScreenWidth(context) * 0.05,
                                  fontWeight: FontWeight.w900,
                                ),
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
                                child:
                                    Text(milestones[lastIndex].milestoneType),
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
                                child:
                                    Text(milestones[lastIndex].additionalNotes),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            // when no milestone exists
            case HomeMilestoneDoesNotExistState:
              return Scaffold(
                backgroundColor: whiteColor,
                floatingActionButton: SizedBox(
                  width: getScreenWidth(context) * 0.4,
                  child: FloatingActionButton(
                    onPressed: () {
                      _homeBloc.add(AddMilestoneButtonClickedEvent());
                    },
                    backgroundColor: pinkColor,
                    child: const Text(
                      'Add Milestone',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        const CustomPinkText(
                          text: 'Capture Milestones',
                          sizeFactor: 0.07,
                        ),
                        SizedBox(
                          height: getScreenheight(context) * 0.3,
                          child: Image.asset('assets/img/hug.png'),
                        ),
                        SizedBox(height: getScreenheight(context) * 0.2),
                        Container(
                          alignment: Alignment.center,
                          child: const CustomPinkText(
                            text: "Create a new milestone !!",
                            sizeFactor: 0.06,
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
                  child: Text(''),
                ),
              );
          }
        });
  }

  // show dialog box to create a new milestone
  void _showDialog(BuildContext context) {
    final milestoneTypeController = TextEditingController();
    final additionalNotesController = TextEditingController();

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
                
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.05,
                  ),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: const Text(
                        'Select date',
                        style: TextStyle(
                          color: purpleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                SizedBox(height: getScreenWidth(context) * 0.12),
                CustomButton(
                    text: 'Done',
                    function: () {
                      MilestoneModel newMilestone = MilestoneModel(
                        time: selectedDate,
                        milestoneType: milestoneTypeController.text,
                        additionalNotes: additionalNotesController.text,
                      );

                      setState(() {
                        milestones.add(newMilestone);
                      });
                      _homeBloc
                          .add(SaveANewMilestoneEvent(milestones: milestones));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    final formattedDate = DateFormat('dd-MMM, yyyy').format(picked!);

    setState(() {
      selectedDate = formattedDate;
    });
  }
}
