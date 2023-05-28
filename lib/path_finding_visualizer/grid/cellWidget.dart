import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/controller.dart';
import "package:sorting_visualizer_flutter/path_finding_visualizer/models/cellData.dart";

class CellWidget extends StatelessWidget {
  const CellWidget(this.cellData, {Key? key}) : super(key: key);

  final ValueListenable<CellData> cellData;

  CellState get visitState => cellData.value.visitState;

  void _onMouseEnter(PointerEvent details) {
    if (details.down) {
      cellData.value.onMouseEnter(cellData.value.index);
    }
  }

  void _onMouseExit(PointerEvent details) {
    if (details.down) {
      cellData.value.onMouseExit(cellData.value.index);
    }
  }

  static const Map<CellState, Color> _colorMap = {
    CellState.eUnvisited: Colors.white,
    CellState.eVisited: Color.fromARGB(255, 0, 195, 255),
    CellState.ePath: Colors.amber,
    CellState.eWall: Colors.black
  };

  static const Map<CellType, Icon> _iconMap = {
    CellType.eDefault: Icon(null),
    CellType.eEnd: Icon(
      Icons.location_on,
      color: Colors.black,
    ),
    CellType.eStart: Icon(
      Icons.adjust,
      color: Colors.black,
    ),
    CellType.eWall: Icon(null)
  };

  static const int dimension = 25;

  Widget _getWidgetToDisplay() {
    if (GridWidgetController.sIsPathVisible) {
      return Container(
        decoration: BoxDecoration(
          color: _colorMap[cellData.value.visitState],
        ),
        child: Center(child: _iconMap[cellData.value.cellType]),
      );
    }

    return AnimatedContainer(
      decoration: BoxDecoration(
        color: _colorMap[cellData.value.visitState],
        borderRadius: BorderRadius.circular(cellData.value.borderRadius),
      ),
      duration: const Duration(milliseconds: 250),
      child: Center(child: _iconMap[cellData.value.cellType]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: _onMouseEnter,
        onExit: _onMouseExit,
        child: Listener(
          child: _getWidgetToDisplay(),
          onPointerDown: (eventDetails) {
            cellData.value.onMouseDown(cellData.value.index);
          },
          onPointerUp: (eventDetails) {
            cellData.value.onMouseRelease(cellData.value.index);
          },
        ));
  }
}
