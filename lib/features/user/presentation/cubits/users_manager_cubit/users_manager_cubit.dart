import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'users_manager_state.dart';

class UsersManagerCubit extends Cubit<UsersManagerState> {
  UsersManagerCubit() : super(UsersManagerInitial());
}
