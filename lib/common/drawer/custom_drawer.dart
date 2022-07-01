import 'package:flutter/material.dart';
import 'package:loja_virtual/common/drawer/custom_drawer_header.dart';
import 'package:loja_virtual/common/drawer/drawer_tile.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              DrawerTile(title: 'Início', page: 0,),
              DrawerTile(title: 'Produtos', page: 1,),
              DrawerTile(title: 'Meus Pedidos', page: 2,),

              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        DrawerTile(title: 'Usuários', page: 3),
                        DrawerTile(title: 'Pedidos', page: 4)
                      ]
                    );
                  } else {
                    return Container();
                  }
                }
              )
            ]
          )
        ]
      )
    );
  }
}