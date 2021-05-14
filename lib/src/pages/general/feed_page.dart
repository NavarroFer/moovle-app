import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class FeedPage extends StatelessWidget {
  static final String route = 'feed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(context: context, texto: 'Feed'),
      body: Container(),
    );
  }
}
