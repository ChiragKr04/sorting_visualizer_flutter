import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:sorting_visualizer_flutter/path_finding_visualizer/constants/constants.dart";
import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/notifiers/gridSettingsNotifier.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/constants/constant_colors.dart';

class GridSettingsWidget extends StatelessWidget {
  const GridSettingsWidget(this.gridSettings, {Key? key}) : super(key: key);

  final ValueListenable<GridSettings> gridSettings;
  static const TextStyle sTextStyle = TextStyle(fontSize: 18);

  bool get isVisualizing => gridSettings.value.isVisualizing;
  AlgoType get algoType => gridSettings.value.algoType;
  PatternType get patternType => gridSettings.value.patternType;

  Function() get onVisualizePressed => gridSettings.value.onVisualizePressed;
  Function() get onResetPressed => gridSettings.value.onResetPressed;
  Function(BuildContext) get onHelpPressed => gridSettings.value.onHelpPressed;

  Function(double) get onAnimSpeedChanged =>
      gridSettings.value.onAnimSpeedChanged;

  void _onAlgoTypeChanged(AlgoType? newAlgoType) {
    gridSettings.value.onAlgoTypeChanged(newAlgoType ?? AlgoType.eDijkstra);
  }

  void _onPatternTypeChanged(PatternType? newPatternType) {
    gridSettings.value
        .onPatternTypeChanged(newPatternType ?? PatternType.eRandom);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      Container(
          constraints: const BoxConstraints(minWidth: 240, maxWidth: 240),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                flex: 2,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Algorithm   ",
                      style: sTextStyle,
                    )),
              ),
              Flexible(
                  flex: 2,
                  child: DropdownButton<AlgoType>(
                      dropdownColor: ConstantColors.blackColor,
                      value: algoType,
                      isExpanded: true,
                      onChanged: isVisualizing ? null : _onAlgoTypeChanged,
                      items: <AlgoType>[
                        AlgoType.eDijkstra,
                        AlgoType.eAStar,
                        AlgoType.eBFS,
                        AlgoType.eDFS,
                      ].map<DropdownMenuItem<AlgoType>>((AlgoType algo) {
                        return DropdownMenuItem<AlgoType>(
                            value: algo,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(gAlgoNames[algo] ?? "",
                                    style:
                                        const TextStyle(color: Colors.amber))));
                      }).toList()))
            ],
          )),
      Container(
          constraints: const BoxConstraints(minWidth: 240, maxWidth: 240),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Walls  ",
                      style: sTextStyle,
                    )),
              ),
              Flexible(
                  flex: 2,
                  child: DropdownButton<PatternType>(
                      dropdownColor: ConstantColors.blackColor,
                      value: patternType,
                      isExpanded: true,
                      onChanged: isVisualizing ? null : _onPatternTypeChanged,
                      items: <PatternType>[
                        PatternType.eRandom,
                        PatternType.eMazeV
                      ].map<DropdownMenuItem<PatternType>>(
                          (PatternType pattern) {
                        return DropdownMenuItem<PatternType>(
                            value: pattern,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(gPatternNames[pattern] ?? "",
                                    style:
                                        const TextStyle(color: Colors.amber))));
                      }).toList()))
            ],
          )),
      Container(
          constraints: const BoxConstraints(minWidth: 360, maxWidth: 360),
          child: Align(
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    constraints:
                        const BoxConstraints(minWidth: 60, maxWidth: 60),
                    child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: const Icon(Icons.play_arrow_rounded),
                            iconSize: 40,
                            color: Colors.amber,
                            tooltip: "Visualize Algorithm",
                            onPressed:
                                isVisualizing ? null : onVisualizePressed))),
                Container(
                    constraints:
                        const BoxConstraints(minWidth: 60, maxWidth: 60),
                    child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: const Icon(Icons.restore),
                            tooltip: "Reset Grid",
                            onPressed: isVisualizing ? null : onResetPressed))),
              ]))),
      Container(
          constraints: const BoxConstraints(minWidth: 500, maxWidth: 500),
          child: Row(children: [
            const Flexible(child: Text("Animation Speed: ", style: sTextStyle)),
            Flexible(
                flex: 2,
                child: Slider(
                  label:
                      "Animation Speed: ${gridSettings.value.animSpeed.toStringAsFixed(2)}x",
                  activeColor: Colors.amber,
                  min: 0.25,
                  max: 3.0,
                  divisions: 11,
                  value: gridSettings.value.animSpeed,
                  onChanged: (value) => onAnimSpeedChanged(value),
                ))
          ])),
    ]);
  }
}
