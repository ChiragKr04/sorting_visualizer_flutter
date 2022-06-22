import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:sorting_visualizer_flutter/constant_colors.dart';
import 'package:sorting_visualizer_flutter/global_provider.dart';

class TimeComplexityCard extends StatelessWidget {
  const TimeComplexityCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ConstantColors.cardColor,
      child: Consumer(
        builder: (
          BuildContext context,
          WidgetRef ref,
          Widget? child,
        ) {
          TextStyle subtitleStyle = TextStyle(fontWeight: FontWeight.bold);
          Map algoData =
              ref.watch(barWidgetNotifierProvider).getCurrentAlgoName();
          return SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    left: 5,
                  ),
                  child: Text(
                    "Time Complexity",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Best case"),
                  subtitle: Text(
                    algoData["complexity"]["best"],
                    style: subtitleStyle,
                  ),
                ),
                ListTile(
                  title: Text("Average case"),
                  subtitle: Text(
                    algoData["complexity"]["average"],
                    style: subtitleStyle,
                  ),
                ),
                ListTile(
                  title: Text("Worst case"),
                  subtitle: Text(
                    algoData["complexity"]["worst"],
                    style: subtitleStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    left: 5,
                  ),
                  child: Text(
                    "Space Complexity",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Text(
                    algoData["complexity"]["space"],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
