import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/cellWidget.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/patternController.dart';
import "package:sorting_visualizer_flutter/path_finding_visualizer/models/cellData.dart";
import "package:sorting_visualizer_flutter/path_finding_visualizer/models/graphData.dart";
import 'package:sorting_visualizer_flutter/path_finding_visualizer/notifiers/cellDataNotifier.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/notifiers/gridSettingsNotifier.dart';

GridWidgetController gridWidgetController = GridWidgetController();

class GridWidgetController {
  static int sRows = 25;
  static int sColumns = 60;
  static int sMaxDist = sRows * sColumns;

  static int sStartCellIndex = getIndex(sRows ~/ 2, sColumns ~/ 4);
  static int sEndCellIndex = getIndex(sRows ~/ 2, 3 * sColumns ~/ 4);
  static bool sIsPathVisible = false;
  static bool sShouldRecompute = false;
  static GridMode sGridMode = GridMode.eNoReaction;

  final List<CellDataNotifier> cellDataList = [];
  final GridSettingsNotifier gridSettings = GridSettingsNotifier(
    GridSettings(
      false,
      AlgoType.eDijkstra,
      PatternType.eRandom,
      1,
      () => null,
      () => null,
      (context) => null,
      (animSpeed) => null,
      (algoType) => null,
      (patternType) => null,
    ),
  );

  void onVisualizePressed() {
    sIsPathVisible = false;
    visualizePath();
  }

  void visualizePath() {
    sShouldRecompute = false;

    switch (gridSettings.algoType) {
      case AlgoType.eDijkstra:
      case AlgoType.eAStar:
        {
          _findPathWeighted();
          break;
        }
      case AlgoType.eBFS:
        {
          _bfs();
          break;
        }
      case AlgoType.eDFS:
        {
          _dfs();
          break;
        }
    }
  }

  int heuristic(int idx) {
    switch (gridSettings.algoType) {
      case AlgoType.eAStar:
        {
          int endX = sEndCellIndex ~/ sColumns;
          int endY = sEndCellIndex % sColumns;
          int x = idx ~/ sColumns;
          int y = idx % sColumns;
          return (x - endX).abs() + (y - endY).abs();
        }
      case AlgoType.eDijkstra:
        return 0;
      default:
        return 0;
    }
  }

  // distance from start cell, for animation timing purposes
  int animDist(int idx) {
    int startX = sStartCellIndex ~/ sColumns;
    int startY = sStartCellIndex % sColumns;
    int x = idx ~/ sColumns;
    int y = idx % sColumns;
    return (x - startX).abs() + (y - startY).abs();
  }

  void _findPathWeighted() async {
    if (gridSettings.isVisualizing) return;

    if (!sIsPathVisible) setVisualizing(true);

    List<int> distances =
        List.generate(sRows * sColumns, ((index) => sMaxDist), growable: false);

    distances[sStartCellIndex] = 0;

    List<int> previousNode =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    HeapPriorityQueue<GraphData> minHeap =
        HeapPriorityQueue<GraphData>((p0, p1) {
      int fScore0 = p0.distance;
      int fScore1 = p1.distance;
      if (fScore0 > fScore1) return 1;
      if (fScore0 == fScore1) return 0;
      return -1;
    });

    minHeap.add(GraphData(sStartCellIndex, 0));

    List<int> visitOrder =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    int currVisitIdx = 0;

    BoolList visited = BoolList(sRows * sColumns);

    while (minHeap.isNotEmpty && !visited[sEndCellIndex]) {
      if (sShouldRecompute) return;

      GraphData currNode = minHeap.removeFirst();
      int currIdx = currNode.index;

      getNeighborIndices(currIdx).forEach((element) {
        if (visited[element]) return;

        int altDistance = distances[currIdx] + 1;
        if (altDistance < distances[element]) {
          distances[element] = altDistance;
          previousNode[element] = currIdx;
          minHeap
              .add(GraphData(element, distances[element] + heuristic(element)));
        }
      });

      visited[currIdx] = true;
      visitOrder[currVisitIdx++] = currIdx;
    }

    List<int> revPath = [];

    // Only display a path if there is one
    if (previousNode[sEndCellIndex] != -1) {
      int currPath = sEndCellIndex;
      while (currPath != -1) {
        revPath.add(currPath);
        currPath = previousNode[currPath];
      }
    }

    await _showCellStates(visitOrder, distances, visited, revPath);
    setVisualizing(false);
  }

  void _bfs() async {
    if (gridSettings.isVisualizing) return;

    if (!sIsPathVisible) setVisualizing(true);

    List<int> previousNode =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    List<int> visitOrder =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    int currVisitIdx = 0;

    Queue<int> bfsQueue = Queue.from({sStartCellIndex});
    int currIdx = -1;

    BoolList visited = BoolList(sRows * sColumns);
    BoolList seen = BoolList(sRows * sColumns);

    seen[sStartCellIndex] = true;

    while (bfsQueue.isNotEmpty && !visited[sEndCellIndex]) {
      if (sShouldRecompute) return;
      currIdx = bfsQueue.removeFirst();

      List<int> neighbours = getNeighborIndices(currIdx);
      for (int i = 0; i < neighbours.length; ++i) {
        int idx = neighbours[i];
        if (visited[idx] || seen[idx]) continue;

        seen[idx] = true;
        previousNode[idx] = currIdx;
        bfsQueue.add(idx);
      }

      visited[currIdx] = true;
      visitOrder[currVisitIdx++] = currIdx;
    }

    List<int> revPath = [];

    // Only display a path if there is one
    if (previousNode[sEndCellIndex] != -1) {
      int currPath = sEndCellIndex;
      while (currPath != -1) {
        revPath.add(currPath);
        currPath = previousNode[currPath];
      }
    }

    await _showNonWeightedCellStates(visitOrder, visited, revPath);
    setVisualizing(false);
  }

  void _dfs() async {
    if (gridSettings.isVisualizing) return;

    if (!sIsPathVisible) setVisualizing(true);

    List<int> previousNode =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    List<int> visitOrder =
        List.generate(sRows * sColumns, ((index) => -1), growable: false);

    int currVisitIdx = 0;

    // use it as a stack
    Queue<int> dfsQueue = Queue.from({sStartCellIndex});
    int currIdx = -1;

    BoolList visited = BoolList(sRows * sColumns);
    BoolList seen = BoolList(sRows * sColumns);

    seen[sStartCellIndex] = true;

    while (dfsQueue.isNotEmpty && !visited[sEndCellIndex]) {
      if (sShouldRecompute) return;
      currIdx = dfsQueue.removeFirst();

      List<int> neighbours = getNeighborIndices(currIdx);
      for (int i = 0; i < neighbours.length; ++i) {
        int idx = neighbours[i];
        if (visited[idx] || seen[idx]) continue;

        seen[idx] = true;
        previousNode[idx] = currIdx;
        dfsQueue.addFirst(idx);
      }

      visited[currIdx] = true;
      visitOrder[currVisitIdx++] = currIdx;
    }

    List<int> revPath = [];

    // Only display a path if there is one
    if (previousNode[sEndCellIndex] != -1) {
      int currPath = sEndCellIndex;
      while (currPath != -1) {
        revPath.add(currPath);
        currPath = previousNode[currPath];
      }
    }

    await _showNonWeightedCellStates(visitOrder, visited, revPath);
    setVisualizing(false);
  }

  Future<void> _showCellStates(List<int> visitOrder, List<int> distances,
      BoolList visited, List<int> revPath) async {
    // if the path is already visible, we don't need to animate, just set all the states

    if (visitOrder.isEmpty) {
      _clearVisitStates();
      return;
    }

    if (sIsPathVisible) {
      for (int i = 0; i < sRows * sColumns; ++i) {
        if (sShouldRecompute) return;
        if (cellDataList[i].visitState == CellState.eWall) continue;
        cellDataList[i].visitState =
            visited[i] ? CellState.eVisited : CellState.eUnvisited;
      }

      for (int i = 0; i < revPath.length; ++i) {
        if (sShouldRecompute) return;
        cellDataList[revPath[i]].visitState = CellState.ePath;
      }
    }
    // otherwise, we need to animate, with each step being determined by the distance
    else {
      int originalDuration = 30;
      int currDist = 0;
      int currNode = visitOrder[0];
      int visitIdx = 0;
      _clearVisitStates();

      while (currNode != -1 && visitIdx < sRows * sColumns - 1) {
        if (currDist >= distances[currNode] + heuristic(currNode)) {
          cellDataList[currNode].visitState = CellState.eVisited;
          currNode = visitOrder[++visitIdx];
        } else {
          currDist = distances[currNode] + heuristic(currNode);
          await _delay(originalDuration ~/ gridSettings.animSpeed);
        }
      }

      for (int i = revPath.length - 1; i >= 0; --i) {
        cellDataList[revPath[i]].visitState = CellState.ePath;
        await _delay(originalDuration ~/ gridSettings.animSpeed);
      }

      sIsPathVisible = true;
    }
  }

  Future<void> _showNonWeightedCellStates(
      List<int> visitOrder, BoolList visited, List<int> revPath) async {
    if (visitOrder.isEmpty) {
      _clearVisitStates();
      return;
    }

    if (sIsPathVisible) {
      for (int i = 0; i < sRows * sColumns; ++i) {
        if (sShouldRecompute) return;
        if (cellDataList[i].visitState == CellState.eWall) continue;
        cellDataList[i].visitState =
            visited[i] ? CellState.eVisited : CellState.eUnvisited;
      }

      for (int i = 0; i < revPath.length; ++i) {
        if (sShouldRecompute) return;
        cellDataList[revPath[i]].visitState = CellState.ePath;
      }
    }
    // otherwise, we need to animate, with each step being determined by the distance
    else {
      int originalDuration = 30;
      int currNode = visitOrder[0];
      int visitIdx = 0;
      _clearVisitStates();

      while (currNode != -1 && visitIdx < sRows * sColumns - 1) {
        cellDataList[currNode].visitState = CellState.eVisited;
        currNode = visitOrder[++visitIdx];
        await Future.delayed(
            Duration(microseconds: 3 ~/ gridSettings.animSpeed));
      }

      for (int i = revPath.length - 1; i >= 0; --i) {
        cellDataList[revPath[i]].visitState = CellState.ePath;
        await _delay(originalDuration ~/ gridSettings.animSpeed);
      }

      sIsPathVisible = true;
    }
  }

  Future<void> _delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  void setVisualizing(bool isVisualizing) {
    gridSettings.isVisualizing = isVisualizing;
  }

  void onAlgorithmChanged(AlgoType algo) {
    gridSettings.algoType = algo;
  }

  void onPatternTypeChanged(PatternType pattern) {
    sIsPathVisible = false;
    gridSettings.patternType = pattern;
    switch (pattern) {
      case PatternType.eRandom:
        {
          _addWalls(patternController.getRandomIndices(sRows, sColumns));
          break;
        }
      case PatternType.eMazeV:
        {
          _addWalls(patternController.getMazeVIndices(sRows, sColumns));
          break;
        }
    }
  }

  Future<void> _addWalls(List<int> wallIndices) async {
    _clearGrid(onlyClearWalls: true);
    _clearVisitStates();

    for (int i = 0; i < wallIndices.length; ++i) {
      int idx = wallIndices[i];
      if (idx == sStartCellIndex || idx == sEndCellIndex) continue;
      _toggleWall(idx);
      //await Future.delayed(const Duration(microseconds: 1));
    }
  }

  void populateCellDataList() {
    cellDataList.clear();
    for (int i = 0; i < sRows * sColumns; ++i) {
      CellDataNotifier cdn = CellDataNotifier(CellData(
          i,
          _onGridCellTap,
          _onGridCellEnter,
          _onGridCellExit,
          _onGridCellMouseRelease,
          CellState.eUnvisited,
          CellType.eDefault));
      cellDataList.add(cdn);
    }
  }

  void _clearGrid({bool onlyClearWalls = false}) {
    for (int i = 0; i < sRows * sColumns; ++i) {
      if (!onlyClearWalls || _isWall(i)) cellDataList[i].clear();
    }
  }

  void _clearVisitStates() {
    for (int i = 0; i < sRows * sColumns; ++i) {
      if (cellDataList[i].cellType != CellType.eWall) {
        cellDataList[i].visitState = CellState.eUnvisited;
      }
    }
  }

  void resetGrid() {
    sIsPathVisible = false;
    _clearGrid();

    sStartCellIndex = getIndex(sRows ~/ 2, sColumns ~/ 4);
    sEndCellIndex = getIndex(sRows ~/ 2, 3 * sColumns ~/ 4);

    cellDataList[sStartCellIndex].cellType = CellType.eStart;
    cellDataList[sEndCellIndex].cellType = CellType.eEnd;
  }

  void onAnimSpeedChanged(double newAnimSpeed) {
    gridSettings.animSpeed = newAnimSpeed;
  }

  bool _isWall(int index) {
    return cellDataList[index].visitState == CellState.eWall ||
        cellDataList[index].cellType == CellType.eWall;
  }

  bool _shouldRestoreWall(int index) {
    return cellDataList[index].shouldRestoreWall;
  }

  void _changeStart(int newIndex) {
    cellDataList[sStartCellIndex].cellType = _shouldRestoreWall(sStartCellIndex)
        ? CellType.eWall
        : CellType.eDefault;
    cellDataList[sStartCellIndex].visitState =
        _shouldRestoreWall(sStartCellIndex)
            ? CellState.eWall
            : CellState.eUnvisited;

    cellDataList[newIndex].cellType = CellType.eStart;
    cellDataList[newIndex].visitState = CellState.eUnvisited;
    sStartCellIndex = newIndex;
  }

  void _changeEnd(int newIndex) {
    cellDataList[sEndCellIndex].cellType =
        _shouldRestoreWall(sEndCellIndex) ? CellType.eWall : CellType.eDefault;
    cellDataList[sEndCellIndex].visitState = _shouldRestoreWall(sEndCellIndex)
        ? CellState.eWall
        : CellState.eUnvisited;
    cellDataList[newIndex].cellType = CellType.eEnd;
    cellDataList[newIndex].visitState = CellState.eUnvisited;
    sEndCellIndex = newIndex;
  }

  void _toggleWall(int cellIndex) {
    if (_isWall(cellIndex)) {
      cellDataList[cellIndex].cellType = CellType.eDefault;
      cellDataList[cellIndex].visitState = CellState.eUnvisited;
      cellDataList[cellIndex].shouldRestoreWall = false;
    } else if (cellDataList[cellIndex].cellType == CellType.eDefault) {
      cellDataList[cellIndex].cellType = CellType.eWall;
      cellDataList[cellIndex].visitState = CellState.eWall;
      cellDataList[cellIndex].shouldRestoreWall = true;
    }
  }

  void _onGridCellTap(int cellIndex) {
    if (cellIndex == sStartCellIndex) {
      sGridMode = GridMode.eStartChange;
    } else if (cellIndex == sEndCellIndex) {
      sGridMode = GridMode.eEndChange;
    } else {
      sGridMode = GridMode.eWallPlace;
    }
  }

  void _onGridCellEnter(int cellIndex) {
    // mouse entered while mouse button is down
    if (cellIndex == sStartCellIndex || cellIndex == sEndCellIndex) return;
    if (gridSettings.isVisualizing && !sIsPathVisible) return;

    switch (sGridMode) {
      case GridMode.eStartChange:
        {
          _changeStart(cellIndex);
          break;
        }
      case GridMode.eEndChange:
        {
          _changeEnd(cellIndex);
          break;
        }
      case GridMode.eWallPlace:
        {
          // shouldn't happen
          break;
        }
      case GridMode.eWallMove:
        {
          _toggleWall(cellIndex);
          break;
        }
      case GridMode.eNoReaction:
        // shouldn't happen
        return;
    }

    if (sIsPathVisible) {
      sShouldRecompute = true;
      visualizePath();
    }
  }

  void _onGridCellExit(int cellIndex) {
    if (sGridMode == GridMode.eWallPlace) {
      sGridMode = GridMode.eWallMove;
      _toggleWall(cellIndex);
    }
  }

  void _onGridCellMouseRelease(int cellIndex) {
    if (gridSettings.isVisualizing && !sIsPathVisible) {
      sGridMode = GridMode.eNoReaction;
      return;
    }

    // start and end will not need to be handled here, just walls
    if (sGridMode == GridMode.eWallPlace) {
      _toggleWall(cellIndex);

      if (sIsPathVisible) {
        sShouldRecompute = true;
        visualizePath();
      }
    }

    sGridMode = GridMode.eNoReaction;
  }

  bool isValidCell(int x, int y) {
    bool isWithinBounds = (x >= 0 && y >= 0 && x < sRows && y < sColumns);
    return isWithinBounds &&
        cellDataList[getIndex(x, y)].cellType != CellType.eWall;
  }

  List<int> getNeighborIndices(int idx) {
    List<int> neighborIndices = [];
    int x = idx ~/ sColumns;
    int y = idx % sColumns;

    if (!isValidCell(x, y)) return neighborIndices;

    if (isValidCell(x, y + 1)) neighborIndices.add(getIndex(x, y + 1));
    if (isValidCell(x, y - 1)) neighborIndices.add(getIndex(x, y - 1));
    if (isValidCell(x + 1, y)) neighborIndices.add(getIndex(x + 1, y));
    if (isValidCell(x - 1, y)) neighborIndices.add(getIndex(x - 1, y));

    return neighborIndices;
  }

  static int getIndex(int row, int column) {
    return (row * sColumns) + column;
  }

  void setGridDimensions(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    int cols = queryData.size.width ~/ CellWidget.dimension;
    int rows = (queryData.size.height * 0.75) ~/ CellWidget.dimension;

    if (rows == sRows && cols == sColumns) {
      return; // don't erase grid if nothing changed
    }

    sRows = rows;
    sColumns = cols;
    sMaxDist = sRows * sColumns;
    populateCellDataList();
    resetGrid();
  }
}
