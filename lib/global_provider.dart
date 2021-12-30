import 'package:sorting_visualizer_flutter/bar_widget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final barWidgetNotifierProvider = ChangeNotifierProvider<BarWidgetProvider>((ref) {
  return BarWidgetProvider();
});
