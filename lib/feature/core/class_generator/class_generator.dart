import 'dart:convert';

import 'package:key_generator/feature/core/key_generator/jsonGen.dart';

import '../key_generator/classGen.dart';

class ClassGenerator {
  createClass() async {
    String header = "import 'package:flutter_test/flutter_test.dart';\nimport '../../../elements/text_field_element.dart';\nimport '../../../finders.dart';\nimport '../../../elements/button.dart';\n";

    String constructor = "  \nCommonFinders commonFinders;"
    "   \nlate AfinzFindersTest afinzFindersTest;"
    "   \nWidgetTester widgetTester;"
    "   \nNAME_CLASS({required this.commonFinders, required this.widgetTester}) {\n"
        "   \nafinzFindersTest = AfinzFindersTest(find: this.commonFinders);\n"
    "}\n\n";


    JsonGen jsonGen = JsonGen();
    final content = await jsonGen.readJson();
    final jsonSaved = json.decode(content);
    final listJsonPage = jsonSaved["pages"] as List;
    listJsonPage.forEach((element) {
      String pageNameFormatted = element["page"].replaceAll("_", " ");
      pageNameFormatted = pageNameFormatted[0].toUpperCase() +
          pageNameFormatted.substring(1).toLowerCase();

      String className = '';
      String classNameFolder = '';
      List classBodyJson = jsonSaved["pages"].toList();
      String body = "";

      classBodyJson.forEach((element) {

        body = "$header\n";
        className = element["page"].toString().toClassName();
        classNameFolder = "elements_${element["page"]}";
        String classDeclaretion = "class Elements${element["page"].toString().toClassName()} {\n";
        List items = element["items"] as List;
        body +=classDeclaretion;
        body += constructor.replaceAll("NAME_CLASS", "Elements$className");
        items.forEach((element) {

          if (element["type"]== "BT"){
             String key = element["key"];
             List splitKey = key.split("_");
             String nameItem = splitKey[2].toString().toClassNameByKey();
              String itemFunc = "Future<ButtonElement> $nameItem() async {\n"
                  "   final finder = await afinzFindersTest.byKey(\"${key}\");\n"
                  "   return ButtonElement(widgetTester, finder);\n}\n";
             body += itemFunc;
          }
        });
        body+="}";
        ClassGen classGen = ClassGen();
        classGen.writeClass(classNameFolder,body);
      });
    });
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toClassName() => replaceAll(RegExp(' +'), ' ')
      .split('_')
      .map((str) => str.toCapitalized())
      .join(' ')
      .replaceAll(" ", "");

  String toClassNameByKey() {
   String name = replaceAll(RegExp(' -'), ' ')
        .split('-')
        .map((str) => str.toCapitalized())
        .join(' ')
        .replaceAll(" ", "");

   return name[0].toLowerCase()+name.substring(1);
  }
}
