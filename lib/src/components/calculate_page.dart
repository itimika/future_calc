import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/back_image.dart';
import '../model/output_model.dart';
import '../model/size_config.dart';
import '../widgets/block1.dart';
import '../widgets/block2.dart';
import '../widgets/block3.dart';
import '../widgets/block4.dart';

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 120),
              child: OutputText(),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          ControlArea(),
        ],
      ),
    );
  }
}

class OutputText extends StatelessWidget {
  const OutputText();

  @override
  Widget build(BuildContext context) {
    return Consumer<OutputModel>(
      builder: (_, model, __) {
        return Text(
          model.output,
          style: const TextStyle(fontSize: 36),
        );
      },
    );
  }
}

@immutable
class ControlArea extends StatelessWidget {
  const ControlArea();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Consumer<OutputModel>(
          builder: (_, model, __) {
            return model.showHelp
                ? backImage
                : const SizedBox();
          },
        ),
        SizedBox(
          height: SizeConfig.width,
          width: SizeConfig.width,
          child: Stack(
            children: <Widget>[

              block1(),
              block2(),
              block3(),
              block4(),

              Positioned(
                top: SizeConfig.halfSize,
                left: SizeConfig.halfSize,
                child: const _ResetPoint(),
              ),

              Positioned(
                top: SizeConfig.halfSize,
                left: SizeConfig.halfSize,
                child: const _BuildDraggable(
                  child: _BuildPanel(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

@immutable
class _BuildDraggable extends StatelessWidget {
  const _BuildDraggable({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Draggable<dynamic>(
      child: child,
      feedback: child,
      childWhenDragging: const SizedBox(),
      onDragEnd: (detail) => inputCommand(context, detail)
    );
  }

  // ドラッグ先の座標による入力の判定
  void inputCommand(BuildContext context, DraggableDetails detail) {
    switch (Provider.of<OutputModel>(context, listen: false).frag) {
      case 1:
        if (SizeConfig.leftDxMin < detail.offset.dx
            && detail.offset.dx < SizeConfig.leftDxMax
            && SizeConfig.topDyMin < detail.offset.dy
            && detail.offset.dy < SizeConfig.topDyMax) {
          Provider.of<OutputModel>(context, listen: false).inputNo('5');  // 5
        } else if (detail.offset.dx + SizeConfig.param1 < detail.offset.dy) {
          - (detail.offset.dx + 40) + SizeConfig.param2 < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('8')  // 8
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('9'); // 9
        } else {
          - (detail.offset.dx + 40) + SizeConfig.param2 < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('7')  // 7
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('6'); // 6
        }
        break;
      case 2:
        if (SizeConfig.rightDxMin < detail.offset.dx
            && detail.offset.dx < SizeConfig.rightDxMax
            && SizeConfig.topDyMin < detail.offset.dy
            && detail.offset.dy < SizeConfig.topDyMax) {
          Provider.of<OutputModel>(context, listen: false).clear();  // C
        } else if (detail.offset.dx + SizeConfig.param3 < detail.offset.dy) {
          - (detail.offset.dx + 40) + SizeConfig.height < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('.')  // .
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe('('); // (
        } else {
          - (detail.offset.dx + 40) + SizeConfig.height < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe(')')   // )
              : Provider
                .of<OutputModel>(context, listen: false)
                .backDelete();  // back delete
        }
        break;
      case 3:
        if (SizeConfig.leftDxMin < detail.offset.dx
            && detail.offset.dx < SizeConfig.leftDxMax
            && SizeConfig.bottomDyMin < detail.offset.dy
            && detail.offset.dy < SizeConfig.bottomDyMax) {
          Provider.of<OutputModel>(context, listen: false).inputNo('0');  // 0
        } else if (detail.offset.dx + SizeConfig.param2 < detail.offset.dy) {
          - (detail.offset.dx + 40) + SizeConfig.height < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('3')  // 3
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('4'); // 4
        } else {
          - (detail.offset.dx + 40) + SizeConfig.height < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('2')  // 2
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputNo('1'); // 1
        }
        break;
      case 4:
        if (SizeConfig.rightDxMin < detail.offset.dx
            && detail.offset.dx < SizeConfig.rightDxMax
            && SizeConfig.bottomDyMin < detail.offset.dy
            && detail.offset.dy < SizeConfig.bottomDyMax) {
          Provider.of<OutputModel>(context, listen: false).outputAns();  // =
        } else if (detail.offset.dx + SizeConfig.param1 < detail.offset.dy) {
          - (detail.offset.dx + 40) + SizeConfig.param4 < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe('×')  // ×
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe('÷'); // ÷
        } else {
          - (detail.offset.dx + 40) + SizeConfig.param4 < detail.offset.dy + 40
              ? Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe('−')  // −
              : Provider
                .of<OutputModel>(context, listen: false)
                .inputOpe('+'); // +
        }
        break;
    }
    Provider.of<OutputModel>(context, listen: false).frag = 0;
  }
}

class _BuildPanel extends StatelessWidget {
  const _BuildPanel();
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 80,
      minWidth: 80,
      child: RaisedButton(
        onPressed: Provider.of<OutputModel>(context, listen: false).changeHelp,
        elevation: 10,
        color: Colors.white,
        shape: const CircleBorder(),
      ),
    );
  }
}

class _ResetPoint extends StatelessWidget {
  const _ResetPoint();
  @override
  Widget build(BuildContext context) {
    return DragTarget<dynamic>(
      builder: (context, candidateData, rejectedData) =>
          const SizedBox(width: 80, height: 80),
      onWillAccept: (dynamic _) {
        Provider.of<OutputModel>(context, listen: false).resetAFrag();
        return !(Provider.of<OutputModel>(context, listen: false).frag == 0);
      },
    );
  }
}