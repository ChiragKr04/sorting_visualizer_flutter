import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';

class BarWidgetProvider extends ChangeNotifier {
  var myWidgets = [];

  BarWidgetProvider() {
    notifyListeners();
  }

  int _widgetCounter = 0;
  bool isAlgoRunning = false;
  Duration _speed = const Duration(
    milliseconds: 20,
  );

  int selectedAlgo = 0;

  void updateAlgoName(int idx) {
    selectedAlgo = idx;
    notifyListeners();
  }

  void algoRunner() {
    switch (selectedAlgo) {
      case 0:
        _bubbleSortAlgo();
        break;
      case 1:
        _insertionSortAlgo();
        break;
      case 2:
        _selectionSort();
        break;
      default:
        _bubbleSortAlgo();
    }
  }

  int widgetCounts = 20;
  void updateWidgetCount(int count) {
    if (count <= 40) {
      _speed = const Duration(
        milliseconds: 20,
      );
    } else if (count >= 40 && count <= 100) {
      _speed = const Duration(
        milliseconds: 5,
      );
    } else if (count > 100) {
      _speed = const Duration(
        milliseconds: 1,
      );
    }
    widgetCounts = count;
    notifyListeners();
  }

  void updateBarData(double screenWidth) async {
    myWidgets.clear();
    isAlgoRunning = true;
    _widgetCounter = 0;
    while (_widgetCounter < widgetCounts) {
      dev.log(_widgetCounter.toString());
      await Future.delayed(_speed);
      _widgetCounter++;
      double height = Random().nextInt(screenWidth ~/ 2) + 20;
      dev.log("height $height");
      myWidgets.add({
        "height": height,
        "widget": SizedBox(
          height: height,
          width: (screenWidth.toInt()) / widgetCounts,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              height.toInt().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        "color": Colors.red,
      });
      notifyListeners();
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  void _bubbleSortAlgo() async {
    isAlgoRunning = true;
    bool needSort = false;
    int alen = myWidgets.length - 1;
    int swapCounter = 0;
    while (!needSort) {
      needSort = true;
      for (int i = 0; i < alen - swapCounter; i++) {
        myWidgets[i]["color"] = Colors.green;
        if (myWidgets[i]["height"] > myWidgets[i + 1]["height"]) {
          // changing widgets
          Widget temp = myWidgets[i + 1]["widget"];
          myWidgets[i + 1]["widget"] = myWidgets[i]["widget"];
          myWidgets[i]["widget"] = temp;
          // changing height
          double tempHeight = myWidgets[i + 1]["height"];
          myWidgets[i + 1]["height"] = myWidgets[i]["height"];
          myWidgets[i]["height"] = tempHeight;
          needSort = false;
        }
        await Future.delayed(_speed);
        myWidgets[i]["color"] = Colors.red;
        notifyListeners();
      }
      swapCounter += 1;
      for (int i = 0; i < alen; i++) {
        dev.log("myWidgets ${myWidgets[i]["widget"].toString()} ");
      }
      notifyListeners();
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  void _insertionSortAlgo() async {
    isAlgoRunning = true;
    int alen = myWidgets.length;
    for (int i = 1; i < alen; i++) {
      int j = i;
      while (j > 0 && myWidgets[j]["height"] < myWidgets[j - 1]["height"]) {
        Widget temp = myWidgets[j - 1]["widget"];
        myWidgets[j - 1]["widget"] = myWidgets[j]["widget"];
        myWidgets[j]["widget"] = temp;
        // changing height
        double tempHeight = myWidgets[j - 1]["height"];
        myWidgets[j - 1]["height"] = myWidgets[j]["height"];
        myWidgets[j]["height"] = tempHeight;
        j -= 1;
        await Future.delayed(_speed);
        notifyListeners();
      }
    }
    await Future.delayed(_speed);
    isAlgoRunning = false;
    notifyListeners();
  }

  void _selectionSort() async {
    isAlgoRunning = true;
    int n = myWidgets.length;
    for (int i = 0; i < n - 1; i++) {
      int min_idx = i;
      for (int j = i + 1; j < n; j++) {
        if (myWidgets[j]["height"] < myWidgets[min_idx]["height"]) {
          min_idx = j;
        }
        myWidgets[i]["color"] = Colors.green;
        myWidgets[j]["color"] = Colors.green;
        await Future.delayed(_speed);
        myWidgets[i]["color"] = Colors.red;
        myWidgets[j]["color"] = Colors.red;
        notifyListeners();
      }
      Widget temp = myWidgets[min_idx]["widget"];
      myWidgets[min_idx]["widget"] = myWidgets[i]["widget"];
      myWidgets[i]["widget"] = temp;
      //
      double tempHeight = myWidgets[min_idx]["height"];
      myWidgets[min_idx]["height"] = myWidgets[i]["height"];
      myWidgets[i]["height"] = tempHeight;
      await Future.delayed(_speed);
      notifyListeners();
    }
    await Future.delayed(_speed);
    isAlgoRunning = false;
    notifyListeners();
  }
}
