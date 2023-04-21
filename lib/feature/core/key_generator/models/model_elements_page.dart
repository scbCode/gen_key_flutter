class ElementsPageModel {
  String page;
  List<ItemELementModel> items;
  ElementsPageModel({required this.page, required this.items});

  Map<String, dynamic> toMap(List<ItemELementModel> listElements) {
    Map<String, dynamic> mapElements = {};
    List<Map<String, dynamic>> m = [];
    listElements.forEach((element) {
      m.add(element.toMap());
    });
    return {'\"page\"': "\"$page\"", '\"items\"': "${m}"};
  }
}

class ItemELementModel {
  String key;
  TypeElement type;

  ItemELementModel({required this.key, required this.type});

  Map<String, dynamic> toMap() {

    return {'\"key\"': "\"$key\"", '\"type\"': "\"${type.name}\""};
  }
}


enum TypeElement {
  BT,
  TEXT_FIELD,
  CHECK_BOX,
  LIST,
  ITEM_LIST,
  NONE;

 static TypeElement EnumStringtoType(String typeElement) {
   switch (typeElement) {
     case "bt":
       return TypeElement.BT;
     case "text_field":
       return TypeElement.TEXT_FIELD;
     case "check_box":
       return TypeElement.CHECK_BOX;
     case "list":
       return TypeElement.LIST;
     case "item_list":
       return TypeElement.ITEM_LIST;
     default:
       return TypeElement.NONE;
   }
 }
  String  EnumTypeToLabel() {
      switch (this) {
        case TypeElement.BT :
          return "Botão";
        case TypeElement.TEXT_FIELD :
          return "Campo de Texto";
        case TypeElement.CHECK_BOX :
          return "Check Box";
        case TypeElement.LIST :
          return "Lista";
        case TypeElement.ITEM_LIST :
          return "Item de lista";
        default:
          return "NONE";
      }
  }
}
