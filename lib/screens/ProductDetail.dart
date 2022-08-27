import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/pruduct.dart';

class ProductDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState();
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);

  var Dbheleper = new dbHelper();
  var txtname = TextEditingController();
  var txtdescription = TextEditingController();
  var txtunitprice = TextEditingController();
  @override
  void initState() {
    txtname.text = product.name;
    txtdescription = product.description as TextEditingController;
    txtdescription = product.unitprice.toString() as TextEditingController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.name} Ürününüzün  detayı"),
        actions: [
          PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                    PopupMenuItem<Options>(
                        value: Options.delete, child: Text("Güncelle")),
                    PopupMenuItem<Options>(
                        value: Options.update, child: Text("Sil"))
                  ])
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: (EdgeInsets.all(30.0)),
      child: Column(
        children: [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: ("Ürün Açıklaması"),
      ),
      controller: txtdescription,
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: ("Ürün Birim Fiyatı"),
      ),
      controller: txtunitprice,
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: ("Ürün Adı"),
      ),
      controller: txtname,
    );
  }

  selectProcess(Options value) async {
    switch (value) {
      case Options.delete:
        await Dbheleper.delete(product.id);
        Navigator.pop(context, true);
        break;

      case Options.update:
        await Dbheleper.update(Product.withId(
            id: product.id,
            name: txtname.text,
            description: txtdescription.text,
            unitprice: double.parse(txtunitprice.text)));
        Navigator.pop(context, true);
        break;
    }
  }
}
