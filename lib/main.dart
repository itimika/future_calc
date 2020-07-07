import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/calculatePage/calculate_page.dart';
import 'components/home/home.dart';
import 'model/output_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OutputModel> (
      create: (_) => OutputModel(),
      child: MaterialApp(
        title: 'Future Calc',
        home: HomePage(),
        routes: <String, WidgetBuilder> {
          '/calcPage': (BuildContext context) => CalculatePage(),
        },
      ),
    );
  }
}
