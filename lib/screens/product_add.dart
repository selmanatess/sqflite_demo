import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/pruduct.dart';

class ProductAdd<Widget> extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var Dbheleper = new dbHelper();
  var txtname = TextEditingController();
  var txtdescription = TextEditingController();
  var txtunitprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle "),
      ),
      body: Padding(
        padding: (EdgeInsets.all(30.0)),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
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

  buildSaveButton() {
    return RaisedButton(onPressed: (){addProduct();}) ;
    
  }

  void addProduct() async {
    var result = await Dbheleper.insert(Product(
        name: txtname.text,
        description: txtdescription.text,
        unitprice: double.parse(txtunitprice.text)));
    Navigator.pop(context, true);
  }
}
