import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/constants/enums.dart';

class GridSettings {
  GridSettings(
      this.isVisualizing,
      this.algoType,
      this.patternType,
      this.animSpeed,
      this.onVisualizePressed,
      this.onResetPressed,
      this.onHelpPressed,
      this.onAnimSpeedChanged,
      this.onAlgoTypeChanged,
      this.onPatternTypeChanged);

  bool isVisualizing;
  AlgoType algoType;
  PatternType patternType;
  double animSpeed;

  Function() onVisualizePressed;
  Function() onResetPressed;
  Function(BuildContext) onHelpPressed;
  Function(double) onAnimSpeedChanged;
  Function(AlgoType) onAlgoTypeChanged;
  Function(PatternType) onPatternTypeChanged;
}

class GridSettingsNotifier extends ValueNotifier<GridSettings> {
  GridSettingsNotifier(GridSettings value) : super(value);

  bool get isVisualizing => value.isVisualizing;

  set onVisualizePressed(void Function() onVisualizePressed) {
    value.onVisualizePressed = onVisualizePressed;
  }

  set onResetPressed(void Function() onResetPressed) {
    value.onResetPressed = onResetPressed;
  }

  set onHelpPressed(void Function(BuildContext) onHelpPressed) {
    value.onHelpPressed = onHelpPressed;
  }

  set onAnimSpeedChanged(void Function(double) onAnimSpeedChanged) {
    value.onAnimSpeedChanged = onAnimSpeedChanged;
  }

  set onAlgoTypeChanged(void Function(AlgoType) onAlgoTypeChanged) {
    value.onAlgoTypeChanged = onAlgoTypeChanged;
  }

  set onPatternTypeChagned(void Function(PatternType) onPatternTypeChanged) {
    value.onPatternTypeChanged = onPatternTypeChanged;
  }

  set isVisualizing(bool _isVisualizing) {
    value.isVisualizing = _isVisualizing;
    notifyListeners();
  }

  AlgoType get algoType => value.algoType;
  set algoType(AlgoType _algoType) {
    value.algoType = _algoType;
    notifyListeners();
  }

  PatternType get patternType => value.patternType;
  set patternType(PatternType _patternType) {
    value.patternType = _patternType;
    notifyListeners();
  }

  double get animSpeed => value.animSpeed;
  set animSpeed(double animSpeed) {
    value.animSpeed = animSpeed;
    notifyListeners();
  }
}
