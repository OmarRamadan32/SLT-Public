import 'package:new_slt/features/user/data/models/user_fields.dart';

// BOD = Board of Directors
class UserModel {
  final int? accessLevel;
  String name;
  final String? id;
  String imageUrl;
  final String? bio;
  final String? backgroundImageUrl;
  final String token;
  final String accountType;
  String title;
  int councilNumber;
  int groupNumber;
  final bool isMainBOD;
  final bool isSubBOD;

  UserModel({
    required this.name,
    this.id,
    required this.imageUrl,
    required this.token,
    required this.accountType,
    required this.title,
    required this.councilNumber,
    required this.groupNumber,
    required this.isMainBOD,
    required this.isSubBOD,
    this.backgroundImageUrl,
    this.bio,
    this.accessLevel,
  });
  factory UserModel.fakeModel() => UserModel(
    name: 'عمر رمضان',
    id: 'id',
    imageUrl: 'imageUrl',
    token: 'token',
    accountType: 'عضو فريق',
    title: 'راجل',
    councilNumber: 1,
    groupNumber: 1,
    isMainBOD: true,
    isSubBOD: true,
    backgroundImageUrl: 'backgroundImageUrl',
    bio: 'دع الايام تفعل ما تشاء وطب نفسا إذا حكم القضاء',
    accessLevel: 0,
  );

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json[UserFields.userName],
      id: json[UserFields.userId],
      imageUrl: json[UserFields.userImageUrl],
      token: json[UserFields.userToken],
      accountType: json[UserFields.userAccountType],
      title: json[UserFields.userTitle],
      councilNumber: json[UserFields.userCouncilNumber],
      groupNumber: json[UserFields.userGroupNumber],
      isMainBOD: json[UserFields.userIsMainBOD],
      isSubBOD: json[UserFields.userIsSubBOD],
      backgroundImageUrl: json[UserFields.userBackgroundImageUrl],
      bio: json[UserFields.userBio],
      accessLevel: json[UserFields.userAccessLevel],
    );
  }

  Map<String, dynamic> toJson() => {
    UserFields.userName: name,
    UserFields.userId: id,
    UserFields.userImageUrl: imageUrl,
    UserFields.userToken: token,
    UserFields.userAccountType: accountType,
    UserFields.userTitle: title,
    UserFields.userCouncilNumber: councilNumber,
    UserFields.userGroupNumber: groupNumber,
    UserFields.userIsMainBOD: isMainBOD,
    UserFields.userIsSubBOD: isSubBOD,
    UserFields.userBackgroundImageUrl: backgroundImageUrl,
    UserFields.userBio: bio,
    UserFields.userAccessLevel: accessLevel,
  };
}
