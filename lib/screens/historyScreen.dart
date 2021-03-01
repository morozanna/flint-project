import 'package:flint_project/models/historyModel.dart';
import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/utils/services/historyService.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    List<History> list = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Container(
          child: Consumer<HistoryService>(builder: (context, service, child) {
        var _history = service.getAllHistory().then((value) {
          list = value;
        });
        return FutureBuilder(
            future: _history,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(); //TODO: add error screen
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var i = list[index].id;
                      History _history;
                      String _wish_id;
                      return Card(
                        color: Colors.blueGrey[800],
                        elevation: 20,
                        child: FutureBuilder(
                          future: service.getHistory(i).then((history) {
                            _history = history;
                            _wish_id = _history.wishRef.id;
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListTile(
                                contentPadding: EdgeInsets.all(13),
                                title: Consumer<WishService>(
                                    builder: (context, wishService, child) {
                                  var _wish = wishService.getWish(_wish_id);
                                  return FutureBuilder(
                                    future: _wish,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Container(); //TODO: add error screen
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        Wish w = snapshot.data;
                                        if (w != null)
                                          return Text(
                                            "selected wish: \n" + w.content,
                                            textAlign: TextAlign.center,
                                          );
                                        else
                                          return Text(
                                            "[deleted wish]",
                                            textAlign: TextAlign.center,
                                          );
                                      }
                                      return Container();
                                    },
                                  );
                                }),
                                leading: Text(
                                  "sent to:\n\n" + _history.phoneNr.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                  "sent at: " + _history.dateSend.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      );
                    });
              }
              return Container();
            });
      })),
    );
  }
}
