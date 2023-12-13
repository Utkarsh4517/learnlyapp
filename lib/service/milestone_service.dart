import 'package:learnlyapp/models/milestone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MilestoneService {
  static Future<List<MilestoneModel>> loadMilestones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? milestonesJson = prefs.getStringList('milestones');
    if (milestonesJson != null) {
      final milestones =
          milestonesJson.map((json) => MilestoneModel.fromJson(json)).toList();
      return milestones;
    } else {
      return [];
    }
  }

  static Future<void> saveMilestones(
      {required List<MilestoneModel> milestones}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> milestonesJson =
        milestones.map((milestone) => milestone.toJson()).toList();
    prefs.setStringList('milestones', milestonesJson);
  }

  static List<MilestoneModel> deleteMilestones({
    required List<MilestoneModel> milestones,
    required int index,
  }) {
    milestones.removeAt(index);
    saveMilestones(milestones: milestones);
    return milestones;
  }

  // static Future<void> editMilestone({
  //   required List<MilestoneModel> milestones,
  //   required int index,
  //   required String milestoneType_,
  //   required String additionalNotes_,
  // }) async {
  //   milestones[index].co
  // }
}
