import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/path_finding_visualizer/grid/grid.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/constants/constant_colors.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/widgets/sortingWidget.dart';

// Web build command
// flutter build web --web-renderer html

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: ((notification) {
        build(context);
        return true;
      }),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainBuilder(),
      ),
    );
  }
}

class MainBuilder extends StatefulWidget {
  const MainBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBuilder> createState() => _MainBuilderState();
}

class _MainBuilderState extends State<MainBuilder> {
  bool isNavigatingS = false;
  bool isNavigatingP = false;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: ConstantColors.blackColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/sorting_icon.png",
                height: size.height * 0.2,
                width: size.height * 0.2,
              ),
              const Text(
                "Algorithm Visualizer",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isNavigatingS = true;
                          });
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SortingVisualizer(),
                            ),
                          );
                          setState(() {
                            isNavigatingS = false;
                          });
                        },
                        child: isNavigatingS
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Sorting Visualizer",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isNavigatingP = true;
                          });
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PathFindingVisualizer(),
                            ),
                          );
                          setState(() {
                            isNavigatingP = false;
                          });
                        },
                        child: isNavigatingP
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Path Finding Visualizer",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PathFindingVisualizer extends StatelessWidget {
  const PathFindingVisualizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridWidget();
  }
}

class SortingVisualizer extends StatelessWidget {
  const SortingVisualizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SortingWidget();
  }
}
