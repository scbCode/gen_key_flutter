import 'package:flutter/material.dart';
import 'package:key_generator/feature/core/key_generator/jsonGen.dart';

import '../../../core/class_generator/class_generator.dart';
import '../../../core/key_generator/key_generator.dart';
import '../../../core/key_generator/models/model_elements_page.dart';
import '../state/states.dart';

typedef V<T> = ValueNotifier<T>;

class ControllerHome {
  GenKey genKey = GenKey();

  final visibleDetailList = V<bool>(false);
  final listKeys = V<List>([]);
  final progress = V<String>("");
  final state = V<GenKeyState>(GenKeyInitialState());
  final listElement = V<List<ElementsPageModel>>([]);
  final indexPageSelected =  V<int>(0);

  getlist(list) {}

  process() async {
    state.value=GenKeyLoadingState();
    listElement.value.clear();
    List<String> list = await genKey.genKey(progress);
    genKey.genElements(list);
    listElement.value.addAll(genKey.genPagesElements(list));
    state.value=GenKeyPasteFinishState();
    listElement.notifyListeners();
  }

  save() async {
    JsonGen jsonGen = JsonGen();
    jsonGen.writeJson(listElement.value);

  }

  genClass(){
    ClassGenerator classGenerator = ClassGenerator();
    classGenerator.createClass();
  }

}
