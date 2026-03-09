import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/views/campaign_section.dart';

class CampaignsView extends StatefulWidget {
  const CampaignsView({super.key});

  @override
  State<CampaignsView> createState() => _CampaignsViewState();
}

class _CampaignsViewState extends State<CampaignsView> {
  @override
  void initState() {
    context.read<CampaignCubit>().getAllCampaigns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Spaces.space10,
          const CampaignSection(
            campaignName: "عشان ربنا",
            campaignDescription:
                "هي حملة سنوية خيرية يقوم بها الفريق وتتكون من مجموعة أنشطة أبرزها إفطار صائم, مائدة رحمن, فطار الفريق والهدف منها هو نشر الخير والمساعدات في الشهر الكريم.",
          ),
          Spaces.sectionsSpace40,
          const CampaignSection(
            campaignName: "قادة الخير",
            campaignDescription:
                "هي حملة تُقام كل عيد أضحي وتتكون من أنشطة خيرية مثل عيدية القادة, أضحية القادة, والهدف منها هو نشر الخير والمساعدات في عيد الأضحي المبارك.",
          ),
          Spaces.screenLastItemSpace70,
        ],
      ),
    );
  }
}
