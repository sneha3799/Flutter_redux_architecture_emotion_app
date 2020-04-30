class EmotionTable {
  static const String TABLE_NAME = "EMOTIONS_TABLE";
  int emotionId;
  String emotionType;
  String emotionDescription;
  String emotionDate;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      EmotionTableColumns.emotionId: emotionId,
      EmotionTableColumns.emotionType: emotionType,
      EmotionTableColumns.emotionDescription: emotionDescription,
      EmotionTableColumns.emotionDate: emotionDate,
    };
    return map;
  }

  EmotionTable.fromMap(Map<String, dynamic> map) {
    emotionId = map[EmotionTableColumns.emotionId];
    emotionType = map[EmotionTableColumns.emotionType];
    emotionDescription = map[EmotionTableColumns.emotionDescription];
    emotionDate = map[EmotionTableColumns.emotionDate];
  }

}

class EmotionTableColumns {
  static const String emotionId = "emotionId";
  static const String emotionType = "emotionType";
  static const String emotionDescription = "emotionDescription";
  static const String emotionDate = "emotionDate";
}