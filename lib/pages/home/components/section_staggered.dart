import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/pages/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'item_list.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            Consumer<Section>(
              builder: (_, section, __){
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: section.items.length,
                  itemBuilder: (_, index){
                      return ItemList(section.items[index]);
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 2),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.zero
                );
              },
            )
          ],
        ),
      ),
    );
  }
}