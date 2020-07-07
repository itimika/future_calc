import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/output_model.dart';
import '../model/size_config.dart';

Widget block3() {
  return Stack(
    children: <Widget>[
      Positioned(
        top: SizeConfig.threeQuarterSize,
        left: SizeConfig.quarterSize,
        child: const _FragPoint(),
      ),
    ],
  );
}

class _FragPoint extends StatelessWidget {
  const _FragPoint();
  @override
  Widget build(BuildContext context) {
    return DragTarget<dynamic>(
      builder: (context, candidateData, rejectedData) =>
      const SizedBox(
        width: 160,
        height: 160,
      ),
      onWillAccept: (dynamic _) {
        Provider.of<OutputModel>(context, listen: false).raiseAFrag(3);
        return Provider.of<OutputModel>(context, listen: false).frag == 0;
      },
    );
  }
}