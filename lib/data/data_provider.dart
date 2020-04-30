import 'package:emotion_app/data/emotions_table.dart';
import 'package:emotion_app/model/saved_detail.dart';

abstract class DataProvider {
  Future open();

  Future close();

  Future<int> insertEmotion(EmotionTable emotion);

  Future<List<SavedDetail>> getEmotions();
}