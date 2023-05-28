import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/models/cellData.dart';

class CellDataNotifier extends ValueNotifier<CellData> {
  CellDataNotifier(CellData value) : super(value);

  int get index => value.index;

  bool shouldRestoreWall = false;

  CellState get visitState => value.visitState;
  set visitState(CellState visitState) {
    if (value.visitState != visitState) {
      value.visitState = visitState;
      notifyListeners();
    }
  }

  CellType get cellType => value.cellType;
  set cellType(CellType cellType) {
    if (value.cellType != cellType) {
      value.cellType = cellType;
      notifyListeners();
    }
  }

  void clear() {
    value.cellType = CellType.eDefault;
    value.visitState = CellState.eUnvisited;
    shouldRestoreWall = false;
    notifyListeners();
  }
}
