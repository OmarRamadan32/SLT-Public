import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'images_manager_state.dart';

class ImagesManagerCubit extends Cubit<ImagesManagerState> {
  ImagesManagerCubit() : super(ImagesManagerInitial());
}
