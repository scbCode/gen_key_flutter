import 'dart:convert';
import 'dart:io';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart';

import 'models/model_elements_page.dart';

class JsonGen {

  JsonGen();

  getVersionApp() async {
    final pubspec = await File('/Users/tbs/Documents/afinz_base_app/app-pj-mobile-lite/pubspec.yaml');
    String yamlText = await pubspec.readAsString();
    Map yaml = loadYaml(yamlText);
    return yaml["version"];
  }
  getNameApp() async {
    final pubspec = await File('/Users/tbs/Documents/afinz_base_app/app-pj-mobile-lite/pubspec.yaml').readAsStringSync();
    final parsed = await Pubspec.parse(pubspec);
    return parsed.name;
  }

  Future<File> writeJson(List<ElementsPageModel> listElement) async   {

    String versionApp = await getVersionApp();
    String nameApp = await getNameApp();
    String jsonString= "{ \"versionApp\": \"$nameApp\", \"versionApp\": \"$versionApp\", "
        "\"pages\":[ ";
    listElement.forEach((element) {
      print(element.toMap(element.items));
      jsonString += "${element.toMap(element.items)}";
      if (listElement.last != element) {
        jsonString += ", ";
      }
    });

    jsonString += "]}";

    Map<String, dynamic> valueMap = json.decode(jsonString);
    var encoder = const JsonEncoder.withIndent("  ");
    String jsonIndented = encoder.convert(valueMap);
    final file = await _localFile("${nameApp}_$versionApp", nameApp,versionApp);
    return file.writeAsString(jsonIndented);
  }

  Future<File>  _localFile(String name, String nameApp, String versionApp) async {
    final path = await _localPath;
    final file = File('$path/$nameApp/$versionApp/$name.json');
    if(file.existsSync()) {
      return file;
    } else {
      return File('$path/$nameApp/$versionApp/$name.json').create(recursive: true);
    }

  }

  String get _localPath  {
    return "lib/feature/core/generated/saves";
  }

  readJson() async {
    String versionApp = await getVersionApp();
    String nameApp = await getNameApp();

    final file = await File('$_localPath/$nameApp/$versionApp/${nameApp}_$versionApp.json');
    final contents = await file.readAsString();
    return contents;
  }
}