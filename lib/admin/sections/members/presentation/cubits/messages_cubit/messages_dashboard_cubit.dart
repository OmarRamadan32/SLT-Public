import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';

part 'messages_dashboard_state.dart';

class MessagesDashboardCubit extends Cubit<MessagesDashboardState> {
  final MessageRepo messageRepo;
  MessagesDashboardCubit({required this.messageRepo})
    : super(MessagesDashboardInitialState());

  Future<void> sendMessageToAllTeam({
    required MessageModel messageModel,
  }) async {
    emit(MessagesDashboardLoadingState());
    var result = await messageRepo.sendMessageToAllTeam(
      messageModel: messageModel,
    );
    result.fold(
      (l) => emit(MessagesDashboardErrorState(l.message)),
      (r) => emit(MessagesDashboardSuccessState()),
    );
  }
  // --
  Future<void> sendMessageToMembers({
        required MessageModel messageModel,
        required List<String> receiversIds,
        required List<String> receiversTokens
  })async{
        emit(MessagesDashboardLoadingState());
        var result = await messageRepo.sendMessageToMembers(
          receiversIds: receiversIds,
      messageModel: messageModel,
        receiversTokens: receiversTokens
    );
    result.fold(
      (l) => emit(MessagesDashboardErrorState(l.message)),
      (r) => emit(MessagesDashboardSuccessState()),
    );
  }
}
