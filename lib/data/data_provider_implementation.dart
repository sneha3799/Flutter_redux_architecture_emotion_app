import 'package:emotion_app/data/data_provider.dart';
import 'package:emotion_app/data/emotions_table.dart';
import 'package:emotion_app/model/saved_detail.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

final Map<String, String> emotionMapper = {
  "Happy": "😃",
  "Sad": "☹️",
  "Nervous": "😥",
  "Angry": "😠",
  "Surprised": "😮",
  "Disgusted": "🤢",
};

class DataProviderImplementation implements DataProvider {
  Database db;
  static const int VERSION = 1;

  @override
  Future open() async {
    var databasePath = await getDatabasesPath();
    var filename = "$databasePath/emotions.db";
    db = await openDatabase(filename, version: 1,
        onCreate: (Database db, int version) async {
          await db.transaction((txn) async {
            await txn.execute('''
        create table ${EmotionTable.TABLE_NAME}(
        ${EmotionTableColumns.emotionId} integer primary key,
        ${EmotionTableColumns.emotionType} text not null,
        ${EmotionTableColumns.emotionDescription} text not null,
        ${EmotionTableColumns.emotionDate} text not null
        );''');
          });
        });
  }

  @override
  Future close() async => db.close();

  @override
  Future<int> insertEmotion(EmotionTable emotion) async {
    return await db.insert(EmotionTable.TABLE_NAME, emotion.toMap());
  }

  @override
  Future<List<SavedDetail>> getEmotions() async {
    List<Map> result = await db.query(EmotionTable.TABLE_NAME, columns: [
      EmotionTableColumns.emotionId,
      EmotionTableColumns.emotionType,
      EmotionTableColumns.emotionDescription,
      EmotionTableColumns.emotionDate
    ]);
    if (result.length > 0) {
      List<EmotionTable> emotionTableItems =
      result.map((item) => EmotionTable.fromMap(item)).toList();
      List<SavedDetail> details = emotionTableItems
          .map((item) => SavedDetail(
          emoji: emotionMapper[item.emotionType],
          emotion: item.emotionType,
          emotionDescription: item.emotionDescription,
          emotionDate: _getFormattedDate(item.emotionDate),
          emotionTime: _getFormattedTime(item.emotionDate)))
          .toList();
      return details;
    }
    return null;
  }

  _getFormattedDate(String emotionDate) {
    return DateFormat.yMMMMd("en_US").format(DateTime.parse(emotionDate));
  }

  _getFormattedTime(String emotionDate) {
    return DateFormat.jm().format(DateTime.parse(emotionDate));
  }
}