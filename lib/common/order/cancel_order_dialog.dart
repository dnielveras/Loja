import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';

class CancelOrderDialog extends StatelessWidget {

  const CancelOrderDialog(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Tem certeza que deseja cancelar?'),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            order.cancel();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Cancelar Pedido'),
        ),
      ],
    );
  }
}