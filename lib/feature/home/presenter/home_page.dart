import 'package:flutter/material.dart';
import 'package:key_generator/feature/home/presenter/widgets/component_view.dart';

import 'controller/controller.dart';
import 'state/states.dart';
import 'widgets/loading.dart';

class MyHomePage extends StatelessWidget {
  ControllerHome controllerHome = ControllerHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(width:200,padding: EdgeInsets.all(12),decoration: BoxDecoration(color: Colors.black12),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

            SizedBox(
                child: ElevatedButton(
                    onPressed: () async {
                      await controllerHome.process();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Buscar keys"),
                          Icon(Icons.manage_search)
                        ],
                      ),
                    ))),

            SizedBox(height: 18,),
            SizedBox(
                child: ElevatedButton(
                    onPressed: () async {
                      await controllerHome.save();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Salvar"),
                          Icon(Icons.manage_search)
                        ],
                      ),
                    ))),
                SizedBox(height: 18,),
                SizedBox(
                    child: ElevatedButton(
                        onPressed: () async {
                          await controllerHome.genClass();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text("Gerar Classes"),
                              Icon(Icons.manage_search)
                            ],
                          ),
                        ))),
          ])),

          Expanded(
              child:
              Padding(padding: EdgeInsets.only(left: 18),child:
              Column(
            children: <Widget>[
              ValueListenableBuilder(
                  valueListenable: controllerHome.state,
                  builder: (context, value, child) {
                    return Visibility(
                        child:
                            controllerHome.state.value is GenKeyLoadingState ||
                                    controllerHome.state.value
                                        is GenKeyInitialState
                                ? Container()
                                : SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                        const SizedBox(
                                          height: 38,
                                        ),
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Itens encontrados")),
                                        const SizedBox(
                                          height: 28,
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable:
                                                controllerHome.listElement,
                                            builder: (context, value, child) {
                                              return SizedBox(
                                                  height: 70,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: controllerHome
                                                          .listElement
                                                          .value
                                                          .length,
                                                      itemBuilder:
                                                          (itemBuilder, index) {
                                                        return GestureDetector(
                                                            onTap: () {
                                                              controllerHome
                                                                  .visibleDetailList
                                                                  .value = true;
                                                              controllerHome
                                                                  .indexPageSelected
                                                                  .value = index;
                                                            },
                                                            child: Container(
                                                                height: 50,
                                                                child: Card(
                                                                    elevation:
                                                                        1,
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(18),
                                                                            child: Column(
                                                                              children: [
                                                                                Text(controllerHome.listElement.value[index].page),
                                                                              ],
                                                                            ))))));
                                                      }));
                                            }),
                                        Divider(),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Itens encontrados")),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: controllerHome
                                                .indexPageSelected,
                                            builder: (context, value, child) {
                                              return !controllerHome.listElement
                                                      .value.isNotEmpty
                                                  ? Container()
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controllerHome
                                                          .listElement
                                                          .value[controllerHome
                                                              .indexPageSelected
                                                              .value]
                                                          .items
                                                          .length,
                                                      itemBuilder:
                                                          (itemBuilder, i) {
                                                        return ComponentView(
                                                            (controllerHome
                                                                .listElement
                                                                .value[controllerHome
                                                                    .indexPageSelected
                                                                    .value]
                                                                .items[i]));
                                                      });
                                            }),
                                      ])));
                  }),
              Expanded(
                  child: Container(
                      height: 75,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ValueListenableBuilder(
                              valueListenable: controllerHome.progress,
                              builder: (context, value, child) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        border: Border.all(
                                            color: Colors.blueGrey, width: 3)),
                                    height: 70,
                                    alignment: Alignment.topLeft,
                                    child: SingleChildScrollView(
                                        reverse: true,
                                        child: Text(
                                          controllerHome.progress.value,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.greenAccent),
                                        )));
                              })))),
            ],
          )))

        ],
      ),
    ));
  }
}
