import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          section.name ?? " ",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      );
    }
  }
