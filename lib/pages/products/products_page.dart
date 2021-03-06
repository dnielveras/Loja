import 'package:flutter/material.dart';
import 'package:loja_virtual/common/drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/product_list_tile.dart';
import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 254, 255, 255)),
        backgroundColor: const Color.fromARGB(255, 147, 36, 50),
        title: Consumer<ProductManager>(
          builder: (_, productManager,__){
            if(productManager.search.isEmpty){
              const text = Text('Produtos', style: TextStyle(color: Colors.white),);
              return text;
            }else {
              return LayoutBuilder(
                builder: (_, constraints){
                  return GestureDetector(
                    onTap: () async {
                      final search =  await showDialog<String>(context: context, builder: (_) => SearchDialog(productManager.search));
                      if(search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  color: Color.fromARGB(255, 254, 255, 255),
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search =  await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if(search != null){
                      productManager.search = search;
                    }
                  },
                );
              }
              else {
                return IconButton(
                  color: Color.fromARGB(255, 254, 255, 255),
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              return IconButton(
                  color: Color.fromARGB(255, 254, 255, 255),
                  icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.of(context).pushNamed(
                    '/cart',
                  );
                }
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index){
              return ProductListTile(filteredProducts[index]);
            }
          );
        },
      ),
    );
  }
}