import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/images_manager_cubit/images_manager_cubit.dart';

class SelectedImagesView extends StatelessWidget {
  const SelectedImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    ImagesManagerCubit imagesManagerCubit = context.read<ImagesManagerCubit>();
    return const Placeholder();
  }
}
// this widget will show the selected images from images manager cubit