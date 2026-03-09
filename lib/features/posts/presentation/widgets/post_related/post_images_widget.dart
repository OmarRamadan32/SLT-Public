import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_image.dart';

class PostImagesWidget extends StatelessWidget {
  const PostImagesWidget({super.key, required this.imagesList});
  final List<dynamic> imagesList;

  @override
  Widget build(BuildContext context) {
    if (imagesList.isNotEmpty) {
      if (imagesList.length == 1) {
        return PostImage(imageWidth: double.infinity, imageUrl: imagesList[0]);
      } else if (imagesList.length == 2) {
        return Row(
          children: [
            Expanded(
              child: PostImage(
                imageWidth: double.infinity,
                imageUrl: imagesList[0],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: PostImage(
                imageWidth: double.infinity,
                imageUrl: imagesList[1],
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostImage(imageWidth: double.infinity, imageUrl: imagesList[0]),
            const SizedBox(height: 8),
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagesList.length - 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: PostImage(
                      imageWidth: 150.w,
                      imageUrl: imagesList[index + 1],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
