import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/algo_constants.dart';

class BarWidgetProvider extends ChangeNotifier {
  var myWidgets = [];

  BarWidgetProvider() {
    notifyListeners();
  }

  int _widgetCounter = 0;
  bool isAlgoRunning = false;
  Duration _speed = const Duration(
    milliseconds: 1,
  );

  int selectedAlgo = 0;

  void updateAlgoName(int idx) {
    selectedAlgo = idx;
    notifyListeners();
  }

  final List<String> _algoNames = AlgoConstants.algoNames;

  final List<Map> _algoData = AlgoConstants.algoData;

  int _pseudoCounter = 0;

  int get pseudoCounter => _pseudoCounter;

  final List _pseudoCodeData = AlgoConstants.pseudoCodeData;

  List getPseudoData() {
    return _pseudoCodeData[selectedAlgo];
  }

  Map getCurrentAlgoName() {
    return _algoData[selectedAlgo];
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
      case 3:
        _mergeSort();
        break;
      case 4:
        _quickSort();
        break;
      default:
        _bubbleSortAlgo();
    }
  }

  void updateSpeed(int speed) {
    _speed = Duration(
      milliseconds: speed,
    );
    notifyListeners();
  }

  int get calcSpeed => _speed.inMilliseconds;
  int get totalData => widgetCounts;

  int widgetCounts = 10;
  void updateWidgetCount(int count) {
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
            child: widgetCounts < 30
                ? Text(
                    height.toInt().toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )
                : const Offstage(),
          ),
        ),
        "color": Colors.red,
      });
      notifyListeners();
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  // Bubble sort
  void _bubbleSortAlgo() async {
    isAlgoRunning = true;
    bool needSort = false;
    int alen = myWidgets.length - 1;
    int swapCounter = 0;
    while (!needSort) {
      needSort = true;
      _pseudoCounter = 1;
      notifyListeners();
      await Future.delayed(_speed);

      _pseudoCounter = 2;
      notifyListeners();
      await Future.delayed(_speed);
      for (int i = 0; i < alen - swapCounter; i++) {
        myWidgets[i]["color"] = Colors.green;
        myWidgets[i + 1]["color"] = Colors.green;
        _pseudoCounter = 3;
        notifyListeners();
        await Future.delayed(_speed);

        if (myWidgets[i]["height"] > myWidgets[i + 1]["height"]) {
          _pseudoCounter = 4;
          notifyListeners();
          await Future.delayed(_speed);

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
        // await Future.delayed(_speed);
        myWidgets[i]["color"] = Colors.red;
        notifyListeners();
      }
      _pseudoCounter = 5;
      swapCounter += 1;
      notifyListeners();
      await Future.delayed(_speed);

      _pseudoCounter = 6;
      notifyListeners();
      await Future.delayed(_speed);
    }
    isAlgoRunning = false;
    for (int i = 0; i <= alen - swapCounter; i++) {
      if (myWidgets[i]["color"] == Colors.green) break;
      myWidgets[i]["color"] = Colors.green;
    }
    _pseudoCounter = 7;
    notifyListeners();
  }

  // Insertion Sort
  void _insertionSortAlgo() async {
    isAlgoRunning = true;
    int alen = myWidgets.length;
    for (int i = 1; i < alen; i++) {
      _pseudoCounter = 1;
      notifyListeners();
      await Future.delayed(_speed);
      int j = i;
      _pseudoCounter = 2;
      notifyListeners();
      await Future.delayed(_speed);
      _pseudoCounter = 3;
      notifyListeners();
      await Future.delayed(_speed);
      while (j > 0 && myWidgets[j]["height"] < myWidgets[j - 1]["height"]) {
        Widget temp = myWidgets[j - 1]["widget"];
        myWidgets[j - 1]["color"] = Colors.deepPurple;
        myWidgets[j]["color"] = Colors.orange;
        _pseudoCounter = 4;
        notifyListeners();
        await Future.delayed(_speed);
        _pseudoCounter = 5;
        notifyListeners();
        await Future.delayed(_speed);
        myWidgets[j - 1]["widget"] = myWidgets[j]["widget"];
        myWidgets[j]["widget"] = temp;
        myWidgets[j]["color"] = Colors.green;
        myWidgets[j - 1]["color"] = Colors.green;
        // changing height
        double tempHeight = myWidgets[j - 1]["height"];
        myWidgets[j - 1]["height"] = myWidgets[j]["height"];
        myWidgets[j]["height"] = tempHeight;
        j -= 1;
        await Future.delayed(_speed);
        notifyListeners();
      }
      _pseudoCounter = 6;
      notifyListeners();
      await Future.delayed(_speed);
    }
    await Future.delayed(_speed);
    for (int i = 0; i < alen; i++) {
      myWidgets[i]["color"] = Colors.green;
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  void _selectionSort() async {
    isAlgoRunning = true;
    int n = myWidgets.length;
    int currSmall = 0;
    for (int i = 0; i < n - 1; i++) {
      int min_idx = i;
      _pseudoCounter = 1;
      notifyListeners();
      await Future.delayed(_speed);
      for (int j = i + 1; j < n; j++) {
        _pseudoCounter = 2;
        notifyListeners();
        await Future.delayed(_speed);
        _pseudoCounter = 3;
        notifyListeners();
        // await Future.delayed(_speed);
        if (myWidgets[j]["height"] < myWidgets[min_idx]["height"]) {
          myWidgets[currSmall]["color"] = Colors.red;
          min_idx = j;
          currSmall = min_idx;
          myWidgets[currSmall]["color"] = Colors.deepPurple;
          _pseudoCounter = 4;
          notifyListeners();
          await Future.delayed(_speed);
        }
        if (currSmall != j) {
          myWidgets[i]["color"] = Colors.green;
          myWidgets[j]["color"] = Colors.green;
          notifyListeners();
          await Future.delayed(_speed);
          myWidgets[j]["color"] = Colors.red;
        }
      }
      myWidgets[currSmall]["color"] = Colors.red;
      Widget temp = myWidgets[min_idx]["widget"];
      myWidgets[min_idx]["widget"] = myWidgets[i]["widget"];
      myWidgets[i]["widget"] = temp;
      //
      double tempHeight = myWidgets[min_idx]["height"];
      myWidgets[min_idx]["height"] = myWidgets[i]["height"];
      myWidgets[i]["height"] = tempHeight;
      _pseudoCounter = 5;
      notifyListeners();
      await Future.delayed(_speed);
    }
    for (int i = 0; i < n; i++) {
      myWidgets[i]["color"] = Colors.green;
    }
    _pseudoCounter = 6;
    await Future.delayed(_speed);
    isAlgoRunning = false;
    notifyListeners();
  }

  int _left = -1;
  int _right = -1;

  void _mergeSort() async {
    isAlgoRunning = true;
    final List copyarr = List.from(myWidgets);
    await _merging(myWidgets, 0, myWidgets.length - 1, copyarr);
    isAlgoRunning = false;
    notifyListeners();
  }

  Future _merging(List main, int start, int end, List copy) async {
    if (start == end) {
      return;
    }

    final int mid = (start + end) ~/ 2;
    await Future.delayed(_speed);
    await _merging(copy, start, mid, main);
    await Future.delayed(_speed);
    await _merging(copy, mid + 1, end, main);
    await Future.delayed(_speed);
    await _mergeArr(main, start, mid, end, copy);
  }

  Future _mergeArr(List main, int start, int mid, int end, List copy) async {
    _left = start;
    _right = mid + 1;
    int counter = start;
    notifyListeners();
    while (_left <= mid && _right <= end) {
      if (copy[_left]["height"] < copy[_right]["height"]) {
        main[counter++] = copy[_left++];
      } else {
        main[counter++] = copy[_right++];
      }
      notifyListeners();
      await Future.delayed(_speed);
    }
    while (_left <= mid) {
      main[counter++] = copy[_left++];
      notifyListeners();
      await Future.delayed(_speed);
    }
    while (_right <= end) {
      main[counter++] = copy[_right++];
      notifyListeners();
      await Future.delayed(_speed);
    }
  }

  void _quickSort() async {
    isAlgoRunning = true;
    await _quickSortAlgo(myWidgets, 0, myWidgets.length - 1);
    isAlgoRunning = false;
    notifyListeners();
  }

  Future<void> _quickSortAlgo(List arr, int low, int high) async {
    if (low >= high) {
      return;
    }

    int s = low;
    int e = high;

    int mid = s + (e - s) ~/ 2;

    int pivot = arr[mid]["height"];

    while (s <= e) {
      while (arr[s]["height"] < pivot) {
        s++;
      }
      while (arr[e]["height"] > pivot) {
        e--;
      }
      if (s <= e) {
        var temp = arr[s];
        arr[s] = arr[e];
        arr[e] = temp;
        notifyListeners();
        await Future.delayed(_speed);
        s++;
        e--;
      }
      notifyListeners();
      await Future.delayed(_speed);
    }

    _quickSortAlgo(arr, low, e);
    _quickSortAlgo(arr, s, high);
  }
}
