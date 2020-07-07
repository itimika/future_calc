import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:future_calc/model/output_model.dart';
import 'package:future_calc/model/size_config.dart';

Widget block2() {
  return Stack(
    children: <Widget>[
      Positioned(
        top: SizeConfig.quarterSize,
        left: SizeConfig.threeQuarterSize,
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
        Provider.of<OutputModel>(context, listen: false).raiseAFrag(2);
        return Provider.of<OutputModel>(context, listen: false).frag == 0;
      },
    );
  }
}