import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo.dart';

class MemberOfTheMonthRepoImpl implements MemberOfTheMonthRepo {
  DatabaseService db;
  MessageRepo messageRepo;
  MemberOfTheMonthRepoImpl({required this.db, required this.messageRepo});
  static const collection = BackendEndpoints.memberOfTheMonthCollection;
  @override
  Future<Either<Failure, void>> addMemberOfTheMonth(
    HighlightModel memberOfTheMonthModel,
  ) async {
    try {
      // first delete the previous member of the month
      await db.deleteData(path: collection);
      // add the member of the month
      await db.addData(path: collection, data: memberOfTheMonthModel.toJson());
      // send notification
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel(
          senderName: "فريق القادة الإجتماعيين",
          text: "تم اختيارك ${memberOfTheMonthModel.content}",
          date: DateTime.now(),
          isPrivate: true,
        ),
        usersIds: [memberOfTheMonthModel.memberOfTheMonthId!],
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel(
          senderName: "فريق القادة الإجتماعيين",
          text:
              "تم اختيار ${memberOfTheMonthModel.title} ${memberOfTheMonthModel.content}",
          date: DateTime.now(),
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<HighlightModel>>> getMemberOfTheMonth() async {
    try {
      final List<Map<String, dynamic>> data = await db.getData(
        path: collection,
      );
      return Right(
        List.of(data.map((e) => HighlightModel.fromMemberOfMonthJson(e))),
      );
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMemberOfTheMonth() async {
    try {
      await db.deleteData(path: collection);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
