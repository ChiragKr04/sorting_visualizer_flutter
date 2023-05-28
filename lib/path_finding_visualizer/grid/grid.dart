import 'package:flutter/material.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/cellWidget.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/controller.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/gridSettingWidget.dart';
import "package:sorting_visualizer_flutter/path_finding_visualizer/models/cellData.dart";
import 'package:sorting_visualizer_flutter/path_finding_visualizer/notifiers/gridSettingsNotifier.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/constants/constant_colors.dart';

class GridWidget extends StatelessWidget {
  GridWidget({Key? key}) : super(key: key) {
    gridWidgetController.gridSettings.onVisualizePressed =
        gridWidgetController.onVisualizePressed;
    gridWidgetController.gridSettings.onResetPressed =
        gridWidgetController.resetGrid;
    gridWidgetController.gridSettings.onAnimSpeedChanged =
        gridWidgetController.onAnimSpeedChanged;
    gridWidgetController.gridSettings.onAlgoTypeChanged =
        gridWidgetController.onAlgorithmChanged;
    gridWidgetController.gridSettings.onPatternTypeChagned =
        gridWidgetController.onPatternTypeChanged;
    gridWidgetController.populateCellDataList();
    gridWidgetController.resetGrid();
  }

  @override
  Widget build(BuildContext context) {
    gridWidgetController.setGridDimensions(context);
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            backgroundColor: ConstantColors.blackColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text("Pathfinding Algorithm Visualizer"),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ValueListenableBuilder<GridSettings>(
                      valueListenable: gridWidgetController.gridSettings,
                      builder: (context, value, child) {
                        return ColoredBox(
                          color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity,
                            child: GridSettingsWidget(
                                gridWidgetController.gridSettings),
                          ),
                        );
                      }),
                  Expanded(
                      flex: 12,
                      child: Container(
                          constraints: BoxConstraints(
                              maxWidth: (48 * GridWidgetController.sColumns)
                                  .toDouble()),
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: GridWidgetController.sColumns,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              children: gridWidgetController.cellDataList
                                  .map((e) => ValueListenableBuilder<CellData>(
                                      valueListenable: e,
                                      builder: (context, value, child) {
                                        return Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 10, minWidth: 10),
                                            child:
                                                Center(child: CellWidget(e)));
                                      }))
                                  .toList()))),
                ])));
  }
}
