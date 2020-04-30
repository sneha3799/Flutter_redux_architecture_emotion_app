import 'package:emotion_app/data/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ViewDetail extends StatefulWidget {
  const ViewDetail();

  @override
  _ViewDetailState createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<EmotionAppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Emotion"),
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            vm.getEmotionImage(),
                            style: TextStyle(fontSize: 72.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
                        child: Center(
                          child: Text(
                            vm.getDate(),
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: Center(
                          child: Text(
                            vm.getTime(),
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          vm.getEmotionDescription(),
                          style: Theme.of(context).textTheme.body1,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
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

  String getEmotionImage() {
    int index = store.state.index;
    return store.state.details[index].emoji;
  }

  String getEmotion() {
    int index = store.state.index;
    return store.state.details[index].emotion;
  }

  String getEmotionDescription() {
    int index = store.state.index;
    return store.state.details[index].emotionDescription;
  }

  String getDate() {
    int index = store.state.index;
    return store.state.details[index].emotionDate;
  }

  String getTime() {
    int index = store.state.index;
    return store.state.details[index].emotionTime;
  }
}