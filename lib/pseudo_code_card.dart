import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/constant_colors.dart';
import 'package:sorting_visualizer_flutter/global_provider.dart';

class PseudoCodeCard extends StatelessWidget {
  const PseudoCodeCard({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: LayoutBuilder(builder: (context, _) {
        return ColoredBox(
          color: ConstantColors.cardColor,
          child: SizedBox(
            width: width,
            child: Consumer(
              builder: (
                BuildContext context,
                WidgetRef ref,
                Widget? child,
              ) {
                List pseudoData =
                    ref.watch(barWidgetNotifierProvider).getPseudoData();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int idx = 0; idx < pseudoData.length; idx++)
                      ColoredBox(
                        color: ref
                                    .watch(barWidgetNotifierProvider)
                                    .pseudoCounter ==
                                idx
                            ? ConstantColors.pseudoCounterColor
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              pseudoData[idx],
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
