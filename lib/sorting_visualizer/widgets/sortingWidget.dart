import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/constants/constant_colors.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/providers/global_provider.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/my_drawer.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/pseudo_code_card.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/slider_counter.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/speed_slider.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/time_complexity_card.dart';

class SortingWidget extends StatelessWidget {
  const SortingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer(
        builder: (context, ref, child) {
          final barWidgetProvider = ref.watch(barWidgetNotifierProvider);
          return Scaffold(
            backgroundColor: ConstantColors.blackColor,
            bottomNavigationBar: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Text(
                    "Data Length : ${ref.watch(barWidgetNotifierProvider).totalData}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SliderCounter(),
                  Text(
                    "Speed : ${ref.watch(barWidgetNotifierProvider).calcSpeed} milliseconds",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SpeedSlider(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                ref.read(barWidgetNotifierProvider.notifier).algoRunner();
              },
              label: const Text(
                'Run Algorithm',
              ),
              icon: const Icon(
                Icons.play_arrow_rounded,
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                ref
                    .watch(barWidgetNotifierProvider)
                    .getCurrentAlgoName()["name"],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ref.read(barWidgetNotifierProvider.notifier).updateBarData(
                          MediaQuery.of(context).size.width * 0.60,
                        );
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.home,
                  ),
                ),
              ],
            ),
            drawer: const MyDrawer(),
            body: Column(
              children: [
                Stack(
                  children: [
                    RotatedBox(
                      quarterTurns: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < barWidgetProvider.myWidgets.length;
                              i++)
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: ColoredBox(
                                color: barWidgetProvider.myWidgets[i]["color"],
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: barWidgetProvider.myWidgets[i]
                                      ["widget"] as Widget,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    TimeComplexityCard(
                      width: constraints.maxWidth * 0.20,
                    ),
                    PseudoCodeCard(
                      width: constraints.maxWidth * 0.20,
                      height: constraints.maxHeight * 0.5,
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.radio_button_unchecked_rounded,
                      color: ref.watch(barWidgetNotifierProvider).isAlgoRunning
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
