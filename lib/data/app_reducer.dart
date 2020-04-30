import 'package:emotion_app/data/actions.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

final emotionAppReducer = combineReducers<EmotionAppState>([
  TypedReducer<EmotionAppState, DatabaseActions>(_handleDatabaseAction),
  TypedReducer<EmotionAppState, NavigateToCreateEmotion>(
      _handleNavigateToCreateNewEmotion),
  TypedReducer<EmotionAppState, LoadedEmotions>(_handleLoadedEmotions),
  TypedReducer<EmotionAppState, ViewEmotion>(_handleViewEmotion),
]);

EmotionAppState _handleDatabaseAction(
    EmotionAppState previousState, DatabaseActions action) {
  EmotionAppState state;
  switch (action) {
    case DatabaseActions.OpenDatabase:
      state =
          previousState.copy(newState: EmotionAppState(isDatabaseOpen: true));
      break;
    case DatabaseActions.CloseDatabase:
      state =
          previousState.copy(newState: EmotionAppState(isDatabaseOpen: false));
      break;
  }
  return state;
}

EmotionAppState _handleNavigateToCreateNewEmotion(
    EmotionAppState previousState, NavigateToCreateEmotion action) {
  EmotionAppState state;
  state = previousState.copy(
      newState: EmotionAppState(emoji: action.emoji, emotion: action.emotion));
  return state;
}

EmotionAppState _handleLoadedEmotions(
    EmotionAppState previousState, LoadedEmotions action) {
  EmotionAppState state;
  state = previousState.copy(
      newState: EmotionAppState(details: action.details, loadComplete: true));
  return state;
}

EmotionAppState _handleViewEmotion(
    EmotionAppState previousState, ViewEmotion action) {
  EmotionAppState state;
  state = previousState.copy(newState: EmotionAppState(index: action.index));
  return state;
}