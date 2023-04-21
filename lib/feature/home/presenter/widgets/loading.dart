
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  Loading();

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        child: CircularProgressIndicator(),
        height: 20.0,
        width: 20.0,
      );

  }
}