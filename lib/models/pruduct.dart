class Product {
  late int id;
  late String name;
  late String description;
  late double unitprice;
  Product(
      {required this.name, required this.description, required this.unitprice});
  Product.withId(
      {required this.id,
      required this.name,
      required this.description,
      required this.unitprice});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    {
      map["name"] = name;
      map["description"] = description;
      map["unitPrice"] = unitprice;
      if (id != null) {
        map["id"] = id;
      }
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    this.id = int.parse(o["id"]);
    this.name = o["name"];
    this.description = o["description"];
    this.unitprice = double.parse(["unitPrice"].toString());
  }
}
