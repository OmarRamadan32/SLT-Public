import 'package:new_slt/features/highlight_feature/data/models/highlight_fields.dart';

class HighlightModel {
  final String? title;
  final String image;
  final String? content;
  final String? id;
  final String? memberOfTheMonthId;
  final DateTime? countDown;
  final bool? isActive;
  final String? actionLink;

  HighlightModel({
    this.title,
    required this.image,
    this.isActive,
    this.content,
    this.memberOfTheMonthId,
    this.countDown,
    this.actionLink,
    this.id,
  });

  factory HighlightModel.fromMemberOfMonthJson(Map<String, dynamic> json) {
    return HighlightModel(
      title: json[HighlightFields.title],
      image: json[HighlightFields.image],
      content: json[HighlightFields.content],
      id: json[HighlightFields.id],
      memberOfTheMonthId: json[HighlightFields.starMemberId],
    );
  }

  factory HighlightModel.fromHighlightJson(Map<String, dynamic> json) {
    return HighlightModel(
      title: json[HighlightFields.title],
      image: json[HighlightFields.image],
      content: json[HighlightFields.content],
      isActive: json[HighlightFields.isActive],
      actionLink: json[HighlightFields.actionLink],
      countDown:
          json[HighlightFields.countDown] != null
              ? DateTime.tryParse(json[HighlightFields.countDown])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      HighlightFields.title: title,
      HighlightFields.image: image,
      HighlightFields.content: content,
      HighlightFields.starMemberId: memberOfTheMonthId,
    };
  }

  int? get remainingDays {
    if (countDown == null) return null;

    final Duration difference = countDown!.difference(DateTime.now());

    if (difference.isNegative) {
      return 0;
    }

    return difference.inDays;
  }
}
