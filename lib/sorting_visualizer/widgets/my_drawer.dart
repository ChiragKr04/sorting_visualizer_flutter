import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/providers/global_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> algoNames = [
      "Bubble Sort",
      "Insertion Sort",
      "Selection Sort",
      "Merge Sort",
      "Quick Sort",
    ];

    return Consumer(builder: (context, ref, child) {
      final barwidgetProvider = ref.watch(barWidgetNotifierProvider);
      return Drawer(
        child: ListView.builder(
          itemCount: algoNames.length,
          itemBuilder: (context, idx) {
            return Padding(
              padding: EdgeInsets.only(
                top: idx == 0 ? 8 : 0,
                bottom: 8,
                left: 8,
                right: 8,
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                child: SizedBox(
                  height: 70,
                  child: Card(
                    color: idx == barwidgetProvider.selectedAlgo
                        ? Colors.blue
                        : Colors.white,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                      onTap: () {
                        ref
                            .read(barWidgetNotifierProvider.notifier)
                            .updateAlgoName(idx);
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Center(
                        child: Text(
                          algoNames[idx],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
