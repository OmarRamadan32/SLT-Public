import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/committees/data/models/committee_fields.dart';

class CommitteeModel {
  final String committeeName;
  final String committeeImage;
  final String committeeDescription;
  List<UserModel>? committeeMembers;
  String? committeeLeaderId;
  String? id;
  String? committeeLeaderName;

  CommitteeModel({
    required this.committeeName,
    required this.committeeImage,
    required this.committeeDescription,
    required this.committeeMembers,
    required this.committeeLeaderId,
    this.id,
    required this.committeeLeaderName,
  });

  CommitteeModel.forUpdate({
    required this.committeeName,
    required this.committeeImage,
    required this.committeeDescription,
  });

  factory CommitteeModel.fromJson(json) {
    return CommitteeModel(
      committeeName: json[CommitteeFields.committeeName],
      committeeImage: json[CommitteeFields.committeeImage],
      committeeDescription: json[CommitteeFields.committeeDescription],
      committeeMembers:
          List<UserModel>.from(
            json[CommitteeFields.committeeMembers] ?? [],
          ).map((e) => e).toList(),
      committeeLeaderId: json[CommitteeFields.committeeLeaderId],
      committeeLeaderName: json[CommitteeFields.committeeLeaderName],
      id: json[CommitteeFields.committeeId],
    );
  }

  Map<String, Object?> toJson() {
    return {
      CommitteeFields.committeeName: committeeName,
      CommitteeFields.committeeImage: committeeImage,
      CommitteeFields.committeeDescription: committeeDescription,
      CommitteeFields.committeeMembers: committeeMembers,
      CommitteeFields.committeeLeaderId: committeeLeaderId,
      CommitteeFields.committeeLeaderName: committeeLeaderName,
    };
  }

  Map<String, String> toJsonForUpdate() {
    return {
      CommitteeFields.committeeName: committeeName,
      CommitteeFields.committeeImage: committeeImage,
      CommitteeFields.committeeDescription: committeeDescription,
    };
  }
}
