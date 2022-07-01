import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_cart_widget.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/checkout_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
      checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 147, 36, 50)),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      'Processando seu pagamento...',
                      style: TextStyle(
                          color: Color.fromARGB(255, 147, 36, 50),
                          fontWeight: FontWeight.w800,
                          fontSize: 16
                      ),
                    )
                  ],
                ),
              );
            }

            return ListView(
              children: <Widget>[
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: (){
                    checkoutManager.checkout(
                        onStockFail: (e){
                          Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/cart');
                        },
                        onSuccess: (order){
                          Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/');
                          Navigator.of(context).pushNamed(
                              '/confirmation',
                              arguments: order
                          );
                        }
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}