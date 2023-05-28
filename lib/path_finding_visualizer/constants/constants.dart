import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';

const Map<AlgoType, String> gAlgoNames = {
  AlgoType.eDijkstra: "Dijkstra",
  AlgoType.eAStar: "A*",
  AlgoType.eBFS: "Breadth First Search",
  AlgoType.eDFS: "Depth First Search",
};

const Map<PatternType, String> gPatternNames = {
  PatternType.eRandom: "Random",
  PatternType.eMazeV: "Random Maze",
};
