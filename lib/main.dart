import 'package:emotion_app/data/app_state.dart';
import 'package:emotion_app/view/add_emotion_detail.dart';
import 'package:emotion_app/view/emotions_list.dart';
import 'package:emotion_app/view/home_page.dart';
import 'package:emotion_app/view/view_emotion_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import 'data/actions.dart';
import 'data/app_reducer.dart';
import 'data/data_provider_implementation.dart';
import 'data/middleware.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final Store<EmotionAppState> store = new Store<EmotionAppState>(
    emotionAppReducer,
    initialState: EmotionAppState(isDatabaseOpen: false, loadComplete: false),
    middleware: createLoginMiddleware(DataProviderImplementation()),
  );

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<EmotionAppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emotions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: NavigatorHolder.navigatorKey,
        home: MyHomePage(),
        routes: {
          '/all-emotions': (BuildContext context) => MyHomePage(),
          '/list-emotions': (BuildContext context) => EmotionsList(),
          '/add-emotion': (BuildContext context) => AddDetail(),
          '/view-saved-emotion': (BuildContext context) => ViewDetail(),
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.store.dispatch(OpenDatabase());
  }

  @override
  void dispose() {
    super.dispose();
    widget.store.dispatch(CloseDatabase());
  }
}
