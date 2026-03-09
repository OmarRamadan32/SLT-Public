import 'package:new_slt/features/team_history/data/models/team_rule_fields.dart';

class TeamRuleModel {
  final String ruleName;
  final String ruleContent;

  TeamRuleModel({
    required this.ruleName,
    required this.ruleContent,
  });

  factory TeamRuleModel.fromJson(Map<String, dynamic> json) => TeamRuleModel(
        ruleName: json[TeamRuleFields.ruleName],
        ruleContent: json[TeamRuleFields.ruleContent],
      );
}
