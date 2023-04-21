import 'dart:convert';
import 'dart:io';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart';

import 'models/model_elements_page.dart';

class ClassGen {

  ClassGen();

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

  Future<File> writeClass(String className, String bodyClass) async   {

    final file = await _localFile(className);
    return file.writeAsString(bodyClass);
  }

  Future<File>  _localFile(String name) async {
    final path = await _localPath;
    String nameApp = await getNameApp();
    String versionApp = await getVersionApp();
    final file = File('$path/${versionApp}/$name/$name.dart');
    if(file.existsSync()) {
      return file;
    } else {
      return File('$path/${versionApp}/$name/$name.dart').create(recursive: true);
    }

  }

  String get _localPath  {
    return "/Users/tbs/Documents/afinz_base_app/app-pj-mobile-lite/integration_test/core/pages_elements/";
  }

  readJson() async {
    String versionApp = await getVersionApp();
    String nameApp = await getNameApp();

    final file = await File('$_localPath/$nameApp/$versionApp/${nameApp}_$versionApp.json');
    final contents = await file.readAsString();
    return contents;
  }
}