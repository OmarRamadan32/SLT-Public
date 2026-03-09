import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/data/models/images_selector_model.dart';
import 'package:new_slt/features/user/presentation/cubits/images_manager_cubit/images_manager_cubit.dart';

class ImagesSelectorWidget extends StatelessWidget {
  const ImagesSelectorWidget({super.key, required this.iamgesSelectorModel});
  final ImagesSelectorModel iamgesSelectorModel;
  @override
  Widget build(BuildContext context) {
    ImagesManagerCubit imagesManagerCubit = context.read<ImagesManagerCubit>();
    return const Placeholder();
  }
}

enum ImageSelectorType { singleImage, singleSecondImage, multipleImages }
