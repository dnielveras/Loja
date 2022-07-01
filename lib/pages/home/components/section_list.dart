import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/pages/home/components/section_header.dart';
import 'package:provider/provider.dart';

import 'item_list.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            Container(
              height: 150,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index){
                        return ItemList(section.items[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: section.items.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}