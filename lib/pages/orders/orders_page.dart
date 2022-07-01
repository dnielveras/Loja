import 'package:flutter/material.dart';
import 'package:loja_virtual/common/drawer/custom_drawer.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/common/login_card.dart';
import 'package:loja_virtual/common/order/order_tile.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 255, 255),
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 254, 255, 255)),
        backgroundColor: Color.fromARGB(255, 147, 36, 50),
        title: const Text('Pedidos'),
        centerTitle: true,
      ),

      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user == null){
            return LoginCard();
          }if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhuma compra',
              iconData: Icons.border_clear,
            );
          }

          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(ordersManager.orders.reversed.toList()[index]);
              }

          );
        },
      ),
    );
  }
}