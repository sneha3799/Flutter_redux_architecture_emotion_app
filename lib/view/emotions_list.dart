import 'package:emotion_app/data/actions.dart';
import 'package:emotion_app/data/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class EmotionsList extends StatelessWidget {
  final List<String> emotionImage = [
    "😃",
    "☹",
    "😶",
    "😥",
    "😠",
    "😮",
    "🤢",
    "🤑",
    "❤"
  ];

  final List<String> emotionDescription = [
    "Happy",
    "Sad",
    "Speechless",
    "Nervous",
    "Angry",
    "Surprised",
    "Disgusted",
    "NotoEmoji",
    "Love"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How are you feeling?"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => EmotionsListItem(
          emotionImage: emotionImage[index],
          emotionDescription: emotionDescription[index],
        ),
        itemCount: emotionImage.length,
      ),
    );
  }
}

class EmotionsListItem extends StatelessWidget {
  final String emotionImage;
  final String emotionDescription;

  const EmotionsListItem({this.emotionImage, this.emotionDescription});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<EmotionAppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return InkWell(
            onTap: () {
              vm.addEmotionDescription(emotionImage, emotionDescription);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    emotionImage,
                    style: TextStyle(fontSize: 72.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    emotionDescription,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final Store<EmotionAppState> store;

  const _ViewModel({this.store});

  static _ViewModel fromStore(Store<EmotionAppState> store) {
    return _ViewModel(store: store);
  }

  void addEmotionDescription(String emotionType, String emotionDescription) {
    store.dispatch(NavigateToAction.push('/add-emotion', preNavigation: () {
      store.dispatch(NavigateToCreateEmotion(
          emoji: emotionType, emotion: emotionDescription));
    }));
  }
}