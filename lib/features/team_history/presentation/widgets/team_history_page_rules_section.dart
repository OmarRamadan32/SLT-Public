import 'package:flutter/material.dart';
import 'package:new_slt/features/team_history/data/models/team_rule_model.dart';
import 'package:new_slt/features/team_history/presentation/widgets/history_card.dart';

class TeamHistoryPageRulesSection extends StatelessWidget {
  const TeamHistoryPageRulesSection({super.key, required this.rules});
  final List<TeamRuleModel> rules;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rules.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          cardTitle: rules[index].ruleName,
          cardContent: rules[index].ruleContent,
        );
      },
    );
  }
}
