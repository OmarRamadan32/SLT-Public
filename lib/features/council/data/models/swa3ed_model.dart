import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/council/data/models/swa3ed_fields.dart';

class Swa3edModel {
  final String? id;
  final int councilNumber;
  final String swa3edImage;
  final List<UserModel> swa3edMembers; 
  final String swa3edLeaderId;
  final String swa3edLeaderName;
  final String swa3edLeaderTwoId;
  final String swa3edLeaderTwoName;

  Swa3edModel({
     this.id,
    required this.councilNumber,
    required this.swa3edImage,
    required this.swa3edMembers,
    required this.swa3edLeaderId,
  required   this.swa3edLeaderName,
    required this.swa3edLeaderTwoId,
    required  this.swa3edLeaderTwoName,
  });

  factory Swa3edModel.fromJson(Map<String, dynamic> json) => Swa3edModel(
    id: json[Swa3edFields.id],
    councilNumber: json[Swa3edFields.councilNumber],
    swa3edImage: json[Swa3edFields.swa3edImage],
    swa3edMembers:
        List<UserModel>.from(
          json[Swa3edFields.swa3edMembers] ?? [],
        ).map((e) => e).toList(),
    swa3edLeaderId: json[Swa3edFields.swa3edLeaderId],
    swa3edLeaderName: json[Swa3edFields.swa3edLeaderName],
    swa3edLeaderTwoId: json[Swa3edFields.swa3edLeaderTwoId],
    swa3edLeaderTwoName: json[Swa3edFields.swa3edLeaderTwoName],
  );
  Map<String, dynamic> toJson() => {
    Swa3edFields.councilNumber: councilNumber,
    Swa3edFields.swa3edImage: swa3edImage,
    Swa3edFields.swa3edMembers: swa3edMembers,
    Swa3edFields.swa3edLeaderId: swa3edLeaderId,
    Swa3edFields.swa3edLeaderName: swa3edLeaderName,
    Swa3edFields.swa3edLeaderTwoId: swa3edLeaderTwoId,
    Swa3edFields.swa3edLeaderTwoName: swa3edLeaderTwoName,
  };
}
