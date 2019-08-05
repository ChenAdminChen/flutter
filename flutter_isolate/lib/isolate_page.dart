import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage {
  static int time = 80;
  static Isolate _isolate;
  static ReceivePort _receivePort = ReceivePort();

  static BuildContext buildContext;

  static StreamController<int> _streamController = StreamController.broadcast();

  Stream get stream => _streamController.stream;

  static final IsolatePage _isolatePage = new IsolatePage._internal();

  factory IsolatePage(BuildContext context) {
    buildContext = context;

    return _isolatePage;
  }

  IsolatePage._internal();

  get receivePortLister => _receivePort;
  get isolate => _isolate;

  static void start() async {
    //port for this main isolate to receive messages.
    // receivePort.sendPort

    _isolate = await Isolate.spawn(runTimer, _receivePort.sendPort);

    _receivePort.listen((data) {
      print("page1-- ============" + data.toString());
      stdout.write('RECEIVE: ' + data.toString() + ', ');

      _streamController.add(data);

      if (data > time) {

        stop();

        Navigator.of(buildContext).pushNamed('/page1');
      }
    });
  }

  static void runTimer(SendPort sendPort) {
    int counter = 0;
    Timer.periodic(new Duration(seconds: 1), (Timer t) {
      counter++;
      String msg = 'notification ' + counter.toString();

      print(msg);

      stdout.write('SEND: ' + msg + ' - ');

      sendPort.send(counter);

      if (counter > time) {
        t.cancel();
      }
    });
  }

  static void stop() {
    if (_isolate != null) {
      stdout.writeln('killing isolate');
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }
}
