import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:loja_virtual/models/users_manager.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_model.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/pages/address/address_page.dart';
import 'package:loja_virtual/pages/base/base_page.dart';
import 'package:loja_virtual/pages/cart/cart_page.dart';
import 'package:loja_virtual/pages/checkout/checkout_page.dart';
import 'package:loja_virtual/pages/confirmation/confirmation_page.dart';
import 'package:loja_virtual/pages/edit_product/edit_product_page.dart';
import 'package:loja_virtual/pages/login/login_page.dart';
import 'package:loja_virtual/pages/product/product_page.dart';
import 'package:loja_virtual/pages/select_product/select_product_page.dart';
import 'package:loja_virtual/pages/signup/signup_page.dart';

import 'package:provider/provider.dart';

import 'models/order.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
            create: (_) => AdminOrdersManager(),
            lazy: false,
            update: (_, userManager, adminOrdersManager) =>
            adminOrdersManager..updateAdmin(
                adminEnabled: userManager.adminEnabled
            )
        )
      ],
      child: MaterialApp(
        title: 'Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //accentColor: const Color.fromARGB(255, 254, 255, 255),
          accentColor: const Color.fromARGB(255, 147, 36, 50),


          primaryColor: const Color.fromARGB(255, 147, 36, 50),
          //scaffoldBackgroundColor: const Color.fromARGB(255, 254, 255, 255),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            //textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/product':
              return MaterialPageRoute(builder: (_) => ProductScreen(settings.arguments as Product));
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen(),settings: settings);
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/edit_product':
              return MaterialPageRoute(builder: (_) => EditProductScreen(settings.arguments as Product));
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                      settings.arguments as Order
                  )
              );
            case '/':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen(),
                  settings: settings
              );
          }
        },
      ),
    );
  }
}