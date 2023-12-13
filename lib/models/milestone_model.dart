import 'dart:convert';

class MilestoneModel {
  final dynamic time;
  String milestoneType;
  String additionalNotes;

  MilestoneModel({
    required this.time,
    required this.milestoneType,
    required this.additionalNotes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'milestoneType': milestoneType,
      'additionalNotes': additionalNotes,
    };
  }

  factory MilestoneModel.fromMap(Map<String, dynamic> map) {
    return MilestoneModel(
      time: map['time'] as String,
      milestoneType: map['milestoneType'] as String,
      additionalNotes: map['additionalNotes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestoneModel.fromJson(String source) =>
      MilestoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
