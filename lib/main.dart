import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/global_provider.dart';
import 'package:sorting_visualizer_flutter/my_drawer.dart';
import 'package:sorting_visualizer_flutter/slider_counter.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer(
        builder: (context, ref, child) {
          final barWidgetProvider = ref.watch(barWidgetNotifierProvider);
          log("REFRESHED");
          return Scaffold(
            bottomNavigationBar: const SizedBox(
              height: 100,
              child: SliderCounter(),
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
              actions: [
                IconButton(
                  onPressed: () {
                    ref
                        .read(barWidgetNotifierProvider.notifier)
                        .updateBarData(constraints.maxWidth);
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                )
              ],
            ),
            drawer: const MyDrawer(),
            body: Column(
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
                        ColoredBox(
                          color: barWidgetProvider.myWidgets[i]["color"],
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: barWidgetProvider.myWidgets[i]["widget"]
                                as Widget,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.radio_button_unchecked_rounded,
                      color: ref.watch(barWidgetNotifierProvider).isAlgoRunning
                          ? Colors.red
                          : Colors.green,
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
