import 'package:emotion_app/data/actions.dart';
import 'package:emotion_app/data/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class AddDetail extends StatefulWidget {
  const AddDetail();

  @override
  _AddDetailState createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  final _formKey = GlobalKey<FormState>();
  String description;

  Future<void> _cancelConfirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Go back"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Are you sure you want to go back? Your description will not be saved.",
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Store<EmotionAppState> store =
                StoreProvider.of<EmotionAppState>(context);
                store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                    '/all-emotions', (Route<dynamic> route) => false));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<EmotionAppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add new emotion"),
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
                            vm.getEmotionType(),
                            style: TextStyle(fontSize: 72.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "What makes you feel ${vm.getEmotionDescription()}?",
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        height: 300.0,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            onSaved: (String value) {
                              description = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Description is empty';
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.display1,
                            decoration: InputDecoration(
                                labelStyle:
                                Theme.of(context).textTheme.display1,
                                labelText: 'Provide a description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                )),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        height: 76.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                onPressed: () {
                                  _cancelConfirmation();
                                },
                                child: const Text('Cancel',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    // Process data.
                                    _formKey.currentState.save();
                                    vm.saveEmotion(
                                        emotionDescription: description);
                                  }
                                },
                                child: const Text('Save',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
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

  String getEmotionType() {
    return store.state.emoji;
  }

  String getEmotionDescription() {
    return store.state.emotion;
  }

  void saveEmotion({String emotionDescription}) {
    store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
        '/all-emotions', (Route<dynamic> route) => false, preNavigation: () {
      store.dispatch(
        SaveEmotion(
            emotion: store.state.emotion,
            emotionDescription: emotionDescription),
      );
    }));
  }
}