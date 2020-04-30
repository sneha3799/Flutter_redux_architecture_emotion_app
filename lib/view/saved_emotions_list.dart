import 'package:emotion_app/data/actions.dart';
import 'package:emotion_app/data/app_state.dart';
import 'package:emotion_app/model/saved_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class SavedEmotionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<EmotionAppState, _ViewModelSavedEmotion>(
      converter: _ViewModelSavedEmotion.fromStore,
      builder: (context, vm) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              SavedEmotionsListItem(
                index: index,
                emotionImage: vm.getEmotionImage(index),
                emotionDescription: vm.getEmotionDescription(index),
                emotionDate: vm.getDate(index),
                emotionTime: vm.getTime(index),
              ),
          itemCount: vm.getEmotionCount(),
        );
      },
    );
  }
}

class _ViewModelSavedEmotion {
  final Store<EmotionAppState> store;

  const _ViewModelSavedEmotion({this.store});

  static _ViewModelSavedEmotion fromStore(Store<EmotionAppState> store) {
    return _ViewModelSavedEmotion(store: store);
  }

  String getEmotionImage(int index) {
    return store.state.details[index].emoji;
  }

  String getEmotion(int index) {
    return store.state.details[index].emotion;
  }

  String getEmotionDescription(int index) {
    return store.state.details[index].emotionDescription;
  }

  String getDate(int index) {
    return store.state.details[index].emotionDate;
  }

  String getTime(int index) {
    return store.state.details[index].emotionTime;
  }

  int getEmotionCount() {
    List<SavedDetail> details = store.state.details ?? [];
    return details.length;
  }
}

class SavedEmotionsListItem extends StatelessWidget {
  final int index;
  final String emotionImage;
  final String emotionDescription;
  final String emotionDate;
  final String emotionTime;

  const SavedEmotionsListItem(
      {this.index,
        this.emotionImage,
        this.emotionDescription,
        this.emotionDate,
        this.emotionTime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Store<EmotionAppState> store =
        StoreProvider.of<EmotionAppState>(context);
        store.dispatch(
            NavigateToAction.push("/view-saved-emotion", preNavigation: () {
              store.dispatch(ViewEmotion(index: index));
            }));
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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    emotionDate,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Text(
                    emotionTime,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                    emotionDescription,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}