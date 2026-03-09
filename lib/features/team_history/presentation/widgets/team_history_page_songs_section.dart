import 'package:flutter/material.dart';
import 'package:new_slt/features/team_history/data/models/team_song_model.dart';
import 'package:new_slt/features/team_history/presentation/widgets/history_card.dart';

class TeamHistoryPageSongsSection extends StatelessWidget {
  const TeamHistoryPageSongsSection({super.key, required this.songs});
  final List<TeamSongModel> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          cardTitle: songs[index].songName,
          cardContent: songs[index].songContent,
        );
      },
    );
  }
}
