import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/highlight_feature/presentation/cubit/highlight_cubit.dart';
import 'package:new_slt/features/highlight_feature/presentation/widgets/highlight_card.dart';

class HighlightFeature extends StatefulWidget {
  const HighlightFeature({super.key});

  @override
  State<HighlightFeature> createState() => _HighlightFeatureState();
}

class _HighlightFeatureState extends State<HighlightFeature> {
  @override
  void initState() {
    context.read<HightlightCubit>().getHighlight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HightlightCubit, HighlightState>(
      builder: (context, state) {
        if (state is HighlightLoaded && state.models.isNotEmpty) {
          return Column(
            children: [
              Spaces.inSectionSpace20,
              ExpandablePageView.builder(
                padEnds: false,
                animationDuration: const Duration(milliseconds: 500),
                animateFirstPage: true,
                alignment: Alignment.center,
                controller: PageController(
                  viewportFraction: state.models.length < 2 ? 1 : 0.95,
                ),
                itemCount: state.models.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: state.models.length > 1 ? 5.w : 0,
                      ),
                      child: HighlightCard(highlightModel: state.models[index]),
                    ),
              ),
              Spaces.space10,
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
