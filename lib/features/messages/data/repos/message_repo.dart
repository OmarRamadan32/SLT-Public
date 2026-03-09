import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';

abstract class MessageRepo {
  Future<Either<Failure, void>> sendMessageToUsersByIds({
    required MessageModel messageModel,
    required List<String> usersIds,
  });
  Future<Either<Failure, void>> sendMessageToMembers({
    required MessageModel messageModel,
    required List<String> receiversIds,
    required List<String> receiversTokens,
  });
  Future<Either<Failure, void>> sendMessageToAllTeam({
    required MessageModel messageModel,
  });
  Future<Either<Failure, List<MessageModel>>> getAllTeamMessages({
    int? limit,
    dynamic startAfter,
  });
  Future<Either<Failure, List<MessageModel>>> getAllMessages({
    required String userId,
    int? limit,
    dynamic startAfterTeam,
    dynamic startAfterUser,
  });
  Future<Either<Failure, List<MessageModel>>> getCurrentUserMessages({
    required String userId,
    int? limit,
    dynamic startAfter,
  });
  Future<Either<Failure, List<MessageModel>>> getTodayMessages({
    required String userId,
  });
}
