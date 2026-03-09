import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';

class UserRepoImpl implements UserRepo {
  DatabaseService db;
  UserRepoImpl({required this.db});

  @override
  Future<Either<Failure, UserModel>> getUserById(String id) async {
    try {
      var docInstance = await db.getData(
        path: BackendEndpoints.usersCollection,
        docuementId: id,
      );
      if (docInstance != null) {
        return Right(UserModel.fromJson(docInstance));
      } else {
        return const Left(ServerFailure(message: "المستخدم غير موجود"));
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersByIds(
    List<dynamic> ids,
  ) async {
    try {
      final futures = ids.map<Future<dynamic>>((id) {
        if (id is String) {
          return db.getData(
            path: BackendEndpoints.usersCollection,
            docuementId: id,
          );
        } else {
          return Future.value(null);
        }
      });
      final docs = await Future.wait(futures);

      final users =
          docs
              .where((doc) => doc != null)
              .map((doc) => UserModel.fromJson(doc!))
              .toList();

      return Right(users);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<UserModel> getCurrentUser(String uid) async {
    var docInstance = await db.getData(
      path: BackendEndpoints.usersCollection,
      docuementId: uid,
    );
    return UserModel.fromJson(docInstance);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllTeamUsers() async {
    try {
      List<Map<String, dynamic>> teamUsers = await db.getData(
        path: BackendEndpoints.usersCollection,
        query: {
          'orderBy': UserFields.userName,

          'where': [
            {
              'field': UserFields.userAccountType,
              'isEqualTo': Constants.normalMember,
            },
          ],
        },
      );
      List<UserModel> teamUsersModels =
          teamUsers.map((e) => UserModel.fromJson(e)).toList();
      return Right(teamUsersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersFromCollection({
    required String path,
    Map<String, dynamic>? where,
  }) async {
    try {
      late List<Map<String, dynamic>> users;
      if (where != null) {
        users = await db.getData(
          path: path,
          query: {
            'where': [
              {'field': where.keys.first, 'isEqualTo': where.values.first},
            ],
          },
        );
      } else {
        users = await db.getData(
          path: path,
          query: {
            'where': [
              {
                'field': UserFields.userAccountType,
                'isEqualTo': Constants.normalMember,
              },
            ],
          },
        );
      }
      List<UserModel> usersModels =
          users.map((e) => UserModel.fromJson(e)).toList();
      return Right(usersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersFromField({
    required String path,
    required String fieldName,
    required String documentId,
  }) async {
    try {
      Map<String, dynamic> document = await db.getData(
        path: path,
        docuementId: documentId,
      );
      var usersFeild = document[fieldName] as List;
      var users = await getUsersByIds(usersFeild);
      return users.fold(
        (e) {
          return Left(ServerFailure.fromException(e));
        },
        (users) {
          return Right(users);
        },
      );
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getNewUsers() async {
    try {
      List<Map<String, dynamic>> users = await db.getData(
        path: BackendEndpoints.usersCollection,
        query: {
          'orderBy': UserFields.userName,
          'where': [
            {
              'field': UserFields.userAccountType,
              'isEqualTo': Constants.guestMember,
            },
          ],
        },
      );
      List<UserModel> usersModels =
          users.map((e) => UserModel.fromJson(e)).toList();
      return Right(usersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateUsersAccessLevel({
    required List<String> usersIds,
    required int accessLevel,
    int? downgradeFrom, // the access level he should had
    bool? downgrade, // if true force to change the access level
  }) async {
    try {
      Either<Failure, List<UserModel>> users = await getUsersByIds(usersIds);
      final List<UserModel> usersList = users.fold(
        (l) => [],
        (usersModels) => usersModels,
      );
      if (usersList.isNotEmpty) {
        Future.wait(
          usersList.map((user) async {
            if (user.accessLevel! > accessLevel) {
              if (downgrade == true && user.accessLevel! <= downgradeFrom!) {
                // if user access level == 3
                // and downgradeFrom == 2
                // it means the user should not be downgraded, because he has a higher access level from different event
                await db.updateData(
                  path: BackendEndpoints.usersCollection,
                  data: {UserFields.userAccessLevel: accessLevel},
                  documentId: user.id!,
                );
              }
            } else {
              await db.updateData(
                path: BackendEndpoints.usersCollection,
                data: {UserFields.userAccessLevel: accessLevel},
                documentId: user.id!,
              );
            }
          }),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
