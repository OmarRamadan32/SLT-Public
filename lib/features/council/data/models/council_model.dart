import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/council/data/models/council_fields.dart';

class CouncilModel {
  final String? id;
  final String councilLeaderId;
  final String councilLeaderName;
  final String? councilLeaderTwoId;
  final bool isCurrent;
  final int councilNewMembersCount;
  final String? councilLeaderTwoName;
  final int councilNumber;
  final String councilImage;
  final List<UserModel> councilMembersModel;

  CouncilModel({
    this.id,
    required this.councilLeaderId,
    required this.councilLeaderName,
    this.councilLeaderTwoId,
    this.councilLeaderTwoName,
    required this.councilNewMembersCount,
    required this.isCurrent,
    required this.councilNumber,
    required this.councilImage,
    required this.councilMembersModel,
  });

  factory CouncilModel.fromJson(Map<String, dynamic> json) {
    return CouncilModel(
      id: json[CouncilFields.id],
      councilLeaderId: json[CouncilFields.councilLeaderId],
      councilLeaderName: json[CouncilFields.councilLeaderName],
      councilLeaderTwoId: json[CouncilFields.councilLeaderTwoId] ?? "",
      councilNewMembersCount: json[CouncilFields.councilNewMembersCount],
      councilLeaderTwoName: json[CouncilFields.councilLeaderTwoName],
      isCurrent: json[CouncilFields.isCurrent],
      councilNumber: json[CouncilFields.councilNumber],
      councilImage: json[CouncilFields.councilImage],
      councilMembersModel:
          List<UserModel>.from(
            json[CouncilFields.councilMembersIds] ?? [],
          ).map((e) => e).toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      CouncilFields.councilLeaderId: councilLeaderId,
      CouncilFields.councilLeaderName: councilLeaderName,
      CouncilFields.councilLeaderTwoId: councilLeaderTwoId,
      CouncilFields.councilLeaderTwoName: councilLeaderTwoName,
      CouncilFields.councilNumber: councilNumber,
      CouncilFields.councilImage: councilImage,
      CouncilFields.councilNewMembersCount: councilNewMembersCount,
      CouncilFields.isCurrent: isCurrent,
      CouncilFields.councilMembersIds: [
        councilLeaderId,
        councilLeaderTwoId,
      ], // the initial list will be the leaders ids
    };
  }
}
