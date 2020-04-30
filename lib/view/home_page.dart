import 'package:emotion_app/data/actions.dart';
import 'package:emotion_app/data/app_state.dart';
import 'package:emotion_app/view/saved_emotions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<EmotionAppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          var widgets = <Widget>[SavedEmotionsList()];
          if (vm.isLoading()) {
            widgets.add(
              Align(
                alignment: Alignment.center,
                child: Container(
                    width: 48.0,
                    height: 48.0,
                    child: CircularProgressIndicator()),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Emotions"),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: widgets,
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  vm.addNewEmotion();
                },
                tooltip: 'Add Emotion',
                child: Icon(Icons.add),
              ),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Store<EmotionAppState> store = StoreProvider.of<EmotionAppState>(context);
    EmotionAppState state = store.state;
    if (state.isDatabaseOpen) {
      store.dispatch(LoadEmotions());
    }
  }
}

class _ViewModel {
  final Store<EmotionAppState> store;

  const _ViewModel({this.store});

  static _ViewModel fromStore(Store<EmotionAppState> store) {
    return _ViewModel(store: store);
  }

  void addNewEmotion() {
    store.dispatch(NavigateToAction.push('/list-emotions'));
  }

  bool isLoading() => !store.state.loadComplete;
}