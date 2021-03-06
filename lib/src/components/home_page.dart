import 'package:flutter/material.dart';

import '../model/size_config.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('/calcPage'),
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.height / 3),
                child: const Text.rich(
                  TextSpan(
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(text: 'The simplest\n'),
                        TextSpan(text: 'calculator\n'),
                        TextSpan(text: 'in the world.'),
                      ]
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.height / 6,
                bottom: SizeConfig.height / 6,
              ),
              child: const Text(
                'Tap anywhere',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}