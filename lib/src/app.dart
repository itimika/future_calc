import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/calculate_page.dart';
import 'components/home_page.dart';
import 'model/output_model.dart';

class App extends StatelessWidget {
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