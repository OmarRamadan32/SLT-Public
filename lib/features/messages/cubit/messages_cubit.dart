import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessageRepo messageRepo;
  MessagesCubit({required this.messageRepo}) : super(MessagesInitialState());
  List<MessageModel> allMessages = [];
  List<MessageModel> currentUserMessages = [];
  List<MessageModel> todayMessages = [];
  List<MessageModel> teamMessages = [];

  Future<void> getAllMessages({
    required String userId,
    dynamic startAfterTeam,
    dynamic startAfterUser,
    bool append = false,
  }) async {
    const limit = 10;
    if (!append) {
      emit(MessagesLoadingState());
    } else {
      emit(MessagesLoadingMoreState());
    }
    var result = await messageRepo.getAllMessages(
      startAfterTeam: startAfterTeam,
      startAfterUser: startAfterUser,
      limit: limit,
      userId: userId,
    );
    result.fold((l) => emit(MessagesErrorState(error: l.message)), (r) {
      if (r.isEmpty) {
        emit(MessagesNoMoreState());
      } else {
        if (append) {
          allMessages.addAll(r);
        } else {
          allMessages = r;
          currentUserMessages =
              r.where((element) => element.isPrivate == true).toList();
          teamMessages =
              r.where((element) => element.isPrivate == false).toList();
        }
        if (!isClosed) {
          if (r.length < limit) {
            emit(MessagesNoMoreState());
          } else {
            emit(MessagesSuccessState());
          }
        }
      }
    });
  }

  //* this function is used to load more Team messages
  Future<void> loadMoreTeamMessages({dynamic startAfter}) async {
    const limit = 10;
    emit(MessagesLoadingMoreState());
    var result = await messageRepo.getAllTeamMessages(
      startAfter: startAfter,
      limit: limit,
    );
    result.fold((l) => emit(MessagesErrorState(error: l.message)), (r) {
      if (r.isEmpty) {
        emit(MessagesNoMoreTeamState());
      } else {
        teamMessages.addAll(r);
        if (!isClosed) {
          if (r.length < limit) {
            emit(MessagesNoMoreTeamState());
          } else {
            emit(MessagesSuccessState());
          }
        }
      }
    });
  }

  // * this function is used to load more Private messages
  Future<void> loadMorePrivateMessages({
    dynamic startAfter,
    required String userId,
  }) async {
    const limit = 10;
    emit(MessagesLoadingMoreState());
    var result = await messageRepo.getCurrentUserMessages(
      startAfter: startAfter,
      limit: limit,
      userId: userId,
    );
    result.fold((l) => emit(MessagesErrorState(error: l.message)), (r) {
      if (r.isEmpty) {
        emit(MessagesNoMorePrivateState());
      } else {
        currentUserMessages.addAll(r);
        if (!isClosed) {
          if (r.length < limit) {
            emit(MessagesNoMorePrivateState());
          } else {
            emit(MessagesSuccessState());
          }
        }
      }
    });
  }

  Future<void> getTodayMessages({required String userId}) async {
    emit(MessagesLoadingState());
    var result = await messageRepo.getTodayMessages(userId: userId);
    result.fold((l) => emit(MessagesErrorState(error: l.message)), (r) {
      todayMessages = r;
      if (!isClosed) emit(MessagesSuccessState());
    });
  }
}
