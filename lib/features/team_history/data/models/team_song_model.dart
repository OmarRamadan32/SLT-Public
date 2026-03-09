import 'package:new_slt/features/team_history/data/models/team_song_fields.dart';

class TeamSongModel {
  final String songName;
  final String songContent;

  TeamSongModel({
    required this.songName,
    required this.songContent,
  });

  factory TeamSongModel.fromJson(Map<String, dynamic> json) => TeamSongModel(
    songName: json[TeamSongFields.songName],
    songContent: json[TeamSongFields.songContent],
  );
}
