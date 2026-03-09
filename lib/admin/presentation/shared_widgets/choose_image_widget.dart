import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ChooseImageWidget extends StatefulWidget {
  const ChooseImageWidget({
    super.key,
    this.initialImage,
    this.isCircular,
    this.isSecondaryImage,
  });
  final String? initialImage;
  final bool? isCircular;
  final bool? isSecondaryImage;

  @override
  State<ChooseImageWidget> createState() => _ChooseImageWidgetState();
}

class _ChooseImageWidgetState extends State<ChooseImageWidget> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await userCubit.pickImage(
          widget.isSecondaryImage == true ? true : false,
        );
        setState(() {});
      },
      child: Container(
        height: widget.isCircular == true ? 125.r : 150.h,
        width: widget.isCircular == true ? 125.r : double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            widget.isCircular == true ? 1000.r : 16.r,
          ),
          border: Border.all(
            color: theme.primaryColor.withAlpha(100),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.isCircular == true ? 1000.r : 16.r,
          ),
          // if the initial image is not null, show it
          child:
              userCubit.imageFile != null && widget.isSecondaryImage != true
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isCircular == true ? 1000.r : 16.r,
                    ),
                    child: Image.file(userCubit.imageFile!, fit: BoxFit.cover),
                  )
                  : userCubit.imageFileTwo != null &&
                      widget.isSecondaryImage == true
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isCircular == true ? 1000.r : 16.r,
                    ),
                    child: Image.file(
                      userCubit.imageFileTwo!,
                      fit: BoxFit.cover,
                    ),
                  )
                  : widget.initialImage != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isCircular == true ? 1000.r : 16.r,
                    ),
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          ),
                        );
                      },
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      imageUrl: widget.initialImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Center(child: ArabicTextWidget(text: 'اختر صورة')),
        ),
      ),
    );
  }
}
