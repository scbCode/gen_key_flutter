import 'package:flutter/material.dart';

import '../../../core/key_generator/models/model_elements_page.dart';

class ComponentView extends StatelessWidget {
  ItemELementModel itemELementModel;

  ComponentView(this.itemELementModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Tipo: "),
                Text("${itemELementModel.type.EnumTypeToLabel()}",
                  style: TextStyle(color: Colors.indigo),
                ),
              ],
            ),
            Row(
              children: [
                Text("Chave: "),
                Text(
                  "${itemELementModel.key}",
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
