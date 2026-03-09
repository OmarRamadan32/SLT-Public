import 'package:flutter/material.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/mention_card.dart';

class CommentMentions extends StatelessWidget {
  const CommentMentions({
    super.key,
    required this.mentionedNames,
    required this.isAuthor,
  });
  final List<String> mentionedNames;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          ...List.generate(
            mentionedNames.length > 5 ? 5 : mentionedNames.length,
            (index) {
              return MentionCard(
                isAuthor: isAuthor,
                cardName: "@ ${mentionedNames[index]}",
              );
            },
          ),
          if (mentionedNames.length > 5)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        backgroundColor: theme.primaryColor,
                        content: Wrap(
                          alignment: WrapAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            ...List.generate(mentionedNames.length, (index) {
                              return MentionCard(
                                isAuthor: isAuthor,
                                cardName: mentionedNames[index],
                              );
                            }),
                          ],
                        ),
                      ),
                );
              },
              child: const MentionCard(isAuthor: false, cardName: "عرض الكل"),
            ),
        ],
      ),
    );
  }
}
