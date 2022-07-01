import 'package:flutter/material.dart';
import 'package:loja_virtual/common/drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home_model.dart';
import 'package:provider/provider.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color.fromARGB(255, 254, 255, 255),
                snap: true,
                floating: true,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                      'Loja',
                      style: TextStyle(color: Colors.black)
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  final List<Widget> children = homeManager.sections.map<Widget>(
                          (section) {
                        switch(section.type){
                          case 'List':
                            return SectionList(section);
                          case 'Staggered':
                            return SectionStaggered(section);
                          default:
                            return Container();
                        }
                      }
                  ).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}