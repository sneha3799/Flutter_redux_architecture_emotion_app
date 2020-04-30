import 'package:emotion_app/data/actions.dart';
import 'package:emotion_app/data/data_provider.dart';
import 'package:emotion_app/data/emotions_table.dart';
import 'package:emotion_app/model/saved_detail.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

List<Middleware<EmotionAppState>> createLoginMiddleware(
    [DataProvider provider]) {
  final openDatabase = _openDatabase(provider);
  final closeDatabase = _closeDatabase(provider);
  final navigateToCreateNewEmotion = _navigateToCreateNewEmotion(provider);
  final saveEmotion = _saveEmotion(provider);
  final loadEmotions = _loadEmotions(provider);
  final viewEmotion = _viewEmotions(provider);

  return [
    TypedMiddleware<EmotionAppState, OpenDatabase>(openDatabase),
    TypedMiddleware<EmotionAppState, CloseDatabase>(closeDatabase),
    TypedMiddleware<EmotionAppState, NavigateToCreateEmotion>(
        navigateToCreateNewEmotion),
    TypedMiddleware<EmotionAppState, SaveEmotion>(saveEmotion),
    TypedMiddleware<EmotionAppState, LoadEmotions>(loadEmotions),
    TypedMiddleware<EmotionAppState, ViewEmotion>(viewEmotion),
    NavigationMiddleware<EmotionAppState>()
  ];
}

Middleware<EmotionAppState> _openDatabase(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    await provider.open();
    next(DatabaseActions.OpenDatabase);
    List<SavedDetail> emotions = await provider.getEmotions();
    next(LoadedEmotions(details: emotions));
  };
}

Middleware<EmotionAppState> _closeDatabase(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    await provider.close();
    next(DatabaseActions.CloseDatabase);
  };
}

Middleware<EmotionAppState> _navigateToCreateNewEmotion(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    next(action);
  };
}

Middleware<EmotionAppState> _saveEmotion(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    SaveEmotion newAction = action;
    provider.insertEmotion(EmotionTable.fromMap({
      EmotionTableColumns.emotionType: newAction.emotion,
      EmotionTableColumns.emotionDescription: newAction.emotionDescription,
      EmotionTableColumns.emotionDate: DateTime.now().toIso8601String()
    }));
  };
}

Middleware<EmotionAppState> _loadEmotions(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    List<SavedDetail> emotions = await provider.getEmotions();
    next(LoadedEmotions(details: emotions));
  };
}

Middleware<EmotionAppState> _viewEmotions(DataProvider provider) {
  return (Store<EmotionAppState> store, action, NextDispatcher next) async {
    next(action);
  };
}