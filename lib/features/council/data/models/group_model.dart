import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/council/data/models/group_fields.dart';

class GroupModel {
  final String? id;
  final String groupName;
  final int groupNumber;
  final String groupImage;
  final int councilNumber;
  final List<UserModel> groupMembers; 
  final String groupLeaderId;
  final String groupLeaderName;
  final String groupFemaleLeaderId;
  final String groupFemaleLeaderName;
  final String groupCaptainId;
  final String groupCaptainName;
  final List<dynamic> groupShields;

  GroupModel({
     this.id,
    required this.groupName,
    required this.groupNumber,
    required this.councilNumber,
    required this.groupImage,
    required this.groupMembers,
    required this.groupLeaderId,
    required  this.groupLeaderName,
    required this.groupFemaleLeaderId,
     required this.groupFemaleLeaderName,
    required this.groupCaptainId,
    required this.groupCaptainName,
    required this.groupShields,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      councilNumber: json[GroupFields.councilNumber],
      groupCaptainId: json[GroupFields.groupCaptainId],
      groupCaptainName: json[GroupFields.groupCaptainName],
      groupFemaleLeaderId: json[GroupFields.groupFemaleLeaderId],
      groupFemaleLeaderName: json[GroupFields.groupFemaleLeaderName],
      groupImage: json[GroupFields.groupImage],
      groupLeaderId: json[GroupFields.groupLeaderId],
      groupLeaderName: json[GroupFields.groupLeaderName],
      groupMembers:
          List<UserModel>.from(
            json[GroupFields.groupMembers] ?? [],
          ).map((e) => e).toList(),
      groupNumber: json[GroupFields.groupNumber],
      groupName: json[GroupFields.groupName],
      groupShields: json[GroupFields.groupShields],
      id: json[GroupFields.id],
    );
  }

  Map<String, dynamic> toJson() => {
    GroupFields.councilNumber: councilNumber,
    GroupFields.groupCaptainId: groupCaptainId,
    GroupFields.groupCaptainName: groupCaptainName,
    GroupFields.groupFemaleLeaderId: groupFemaleLeaderId,
    GroupFields.groupFemaleLeaderName: groupFemaleLeaderName,
    GroupFields.groupLeaderId: groupLeaderId,
    GroupFields.groupLeaderName: groupLeaderName,
    GroupFields.groupMembers: groupMembers,
    GroupFields.groupNumber: groupNumber,
    GroupFields.groupName: groupName,
    GroupFields.groupShields: groupShields,
    GroupFields.groupImage: groupImage
  };
}
