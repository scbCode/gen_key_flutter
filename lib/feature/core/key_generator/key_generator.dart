import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import '../../home/presenter/controller/controller.dart';
import 'models/model_elements_page.dart';

class GenKey {
  GenKey();

  List<String> pages = [];

  Future<List<String>> genKey(V listenerProgress) async {
    bool pageContainKey = false;

    Directory dir = Directory(
        '/Users/tbs/Documents/afinz_base_app/app-pj-mobile-lite/lib/src/features');
    Stream<File> scanFiles = scanningFilesRecursive(dir);
    debugPrint("#genKey: INIT PROCESS...");
    listenerProgress.value = "    #genKey: INIT PROCESS... \n";

    List<String> keys = [];
    await scanFiles.asBroadcastStream().forEach((file) async {
      var fileContent = await file.readAsLines();

      debugPrint("#genKey: scanFiles => ${file.path.split("/").last}");

      listenerProgress.value += "   #genKey: scanFiles =>  "+file.path.split("/").last+"\n";

      for (var line in fileContent) {
        if (line.replaceAll(" ", "").contains("#KEY-")) {
          final key = line
              .replaceAll("(", "")
              .replaceAll(")", "")
              .replaceAll("\"", "")
              .replaceAll("Key", "")
              .replaceAll("key: ", "")
              .replaceAll("key:", "")
              .replaceAll("\$index", "0");
          keys.add(key.replaceAll(",", "").trim());
          pageContainKey = true;
        }
      }

      if (pageContainKey) {
        if (!pages.contains(file.path.split("/").last.replaceAll(".dart", ""))) {
          pages.add(file.path.split("/").last.replaceAll(".dart", ""));
        }
      }
    });
    return keys;
  }

  List<ItemELementModel> genElements(List<String> list) {
    List<ItemELementModel> listEl = [];
    list.forEach((element) {
      final splitKey = element.split("-");
      String type = splitKey[2].trim();
      listEl.add(ItemELementModel(key: element, type: TypeElement.EnumStringtoType(type)));
    });
    return listEl;
  }

  List<ElementsPageModel> genPagesElements(List<String> list) {
    List<ElementsPageModel> listEl = [];
    list.forEach((element) {
      final splitKey = element.split("-");
      String page = splitKey[1].trim();
      List<String> l = list.where((element) => element.contains(page)).toList();

      if (listEl.where((element) => element.page == page).toList().isEmpty) {
        listEl.add(ElementsPageModel(page: page, items: genElements(l)));
      }
    });
    return listEl;
  }

  List getPagesName() {
    return pages;
  }

  Stream<File> scanningFilesRecursive(Directory dir) async* {
    var dirList = dir.list();
    await for (final FileSystemEntity entity in dirList) {
      if (entity is File) {
        final extension = entity.path.split(".").last;
        if (extension == "dart") yield entity;
      } else if (entity is Directory) {
        yield* scanningFilesRecursive(Directory(entity.path));
      }
    }
  }
}
