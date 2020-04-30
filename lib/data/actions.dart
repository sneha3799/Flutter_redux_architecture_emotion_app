import 'package:emotion_app/model/saved_detail.dart';

enum DatabaseActions { OpenDatabase, CloseDatabase }

class OpenDatabase {}

class CloseDatabase {}

class LoadEmotions {}

class NavigateToCreateEmotion {
  final String emoji;
  final String emotion;

  const NavigateToCreateEmotion({this.emoji, this.emotion});
}

class SaveEmotion {
  final String emotion;
  final String emotionDescription;

  const SaveEmotion({this.emotion, this.emotionDescription});
}

class LoadedEmotions {
  final List<SavedDetail> details;

  const LoadedEmotions({this.details});
}

class ViewEmotion {
  final int index;

  const ViewEmotion({this.index});
}