import 'package:emotion_app/model/saved_detail.dart';
import 'package:flutter/material.dart';

@immutable
class EmotionAppState {
  final bool isDatabaseOpen;
  final String emoji;
  final String emotion;
  final List<SavedDetail> details;
  final int index;
  final bool loadComplete;

  EmotionAppState(
      {this.isDatabaseOpen,
        this.emoji,
        this.emotion,
        this.details,
        this.index,
        this.loadComplete});

  EmotionAppState copy({EmotionAppState newState}) {
    return EmotionAppState(
        isDatabaseOpen: _getDatabaseState(newState),
        emoji: _getEmoji(newState),
        emotion: _getEmotion(newState),
        details: _savedDetails(newState),
        index: _getIndex(newState),
        loadComplete: _getLoadStatus(newState));
  }

  bool _getDatabaseState(EmotionAppState newState) {
    if (newState.isDatabaseOpen != null) {
      return newState.isDatabaseOpen;
    } else {
      return isDatabaseOpen;
    }
  }

  String _getEmoji(EmotionAppState newState) {
    if (newState.emoji != null) {
      return newState.emoji;
    } else {
      return emoji;
    }
  }

  String _getEmotion(EmotionAppState newState) {
    if (newState.emotion != null) {
      return newState.emotion;
    } else {
      return emotion;
    }
  }

  List<SavedDetail> _savedDetails(EmotionAppState newState) {
    if (newState.details != null) {
      return newState.details;
    } else {
      return details;
    }
  }

  int _getIndex(EmotionAppState newState) {
    if (newState.index != null) {
      return newState.index;
    } else {
      return index;
    }
  }

  bool _getLoadStatus(EmotionAppState newState) {
    if (newState.loadComplete != null) {
      return newState.loadComplete;
    } else {
      return loadComplete;
    }
  }
}