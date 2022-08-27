import 'package:flutter/material.dart';

import 'package:sqflite_demo/models/pruduct.dart';
import 'package:sqflite_demo/screens/productDetail.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/ProductDetail.dart';


import '../data/dbHelper.dart';

class productList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListState();
  }
}

class _ProductListState extends State {
  dbHelper DbHelper = new dbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ürün Listesi"),
        ),
        body: buildProductList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            gotoProductAdd();
          },
          child: Icon(Icons.add),
          tooltip: "Yeni Ürün Ekle",
        ));
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext contex, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: const Text("p"),
              ),
              title: Text(this.products![position].name),
              subtitle: Text(this.products![position].description),
              onTap: () {
                gotoDetail(this.products![position]);
              },
            ),
          );
        });
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result == true) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = DbHelper.getProducts();
    productsFuture.then((data) {

      setState(() {
         this.products = data;
      productCount = data.length;
        
      });
     
    });
  }

  void gotoDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
