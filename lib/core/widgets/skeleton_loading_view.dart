import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoadingView extends StatelessWidget {
  const SkeletonLoadingView({
    super.key,
    required this.card,
    required this.cardsCount,
  });
  final Widget card;
  final int cardsCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cardsCount,
      itemBuilder:
          (context, index) => Skeletonizer(
            effect: ShimmerEffect(
              baseColor: Theme.of(context).scaffoldBackgroundColor,
              highlightColor: Colors.white,
              duration: const Duration(seconds: 2),
            ),
            child: card,
          ),
    );
  }
}
