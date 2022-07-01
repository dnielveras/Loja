import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 80,
        color: const Color.fromARGB(255, 147, 36, 50),

        child: Consumer<UserManager>(
          builder: (_, userManager, __){

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Text(
                  '${userManager.user?.name ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 254, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    if(userManager.isLoggedIn){
                      context.read<PageManager>().setPage(0);
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed('/login');
                      context.read<PageManager>().setPage(0);
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se',
                    style:  TextStyle(
                      color: const Color.fromARGB(255, 254, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            );
          },
        )
    );
  }
}