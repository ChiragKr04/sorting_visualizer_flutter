import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';

class CellData {
  CellData(this.index, this.onMouseDown, this.onMouseEnter, this.onMouseExit,
      this.onMouseRelease, this.visitState, this.cellType);

  int index;
  void Function(int) onMouseDown;
  void Function(int) onMouseEnter;
  void Function(int) onMouseExit;
  void Function(int) onMouseRelease;
  CellState visitState;
  CellType cellType;
  double borderRadius = 0;
}
