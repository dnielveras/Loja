import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/validators.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 147, 36, 50),
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
            'Entrar',
            style: TextStyle(color: Color.fromARGB(255, 254, 255, 255))
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text(
                'CRIAR CONTA',
                style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 254, 255, 255)) ,
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          color: const Color.fromARGB(255, 254, 255, 255),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email){
                        if(!emailValid(email))
                          return 'E-mail inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                    child,
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: const Color.fromARGB(255, 147, 36, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: userManager.loading ? null : (){
                          if(formKey.currentState.validate()){
                            userManager.signIn(
                              user: User(
                                  email: emailController.text,
                                  password: passController.text
                              ),
                              onFail: (e){
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              },
                              onSuccsess: (){
                                Navigator.of(context).pop();
                              }
                            );
                          }
                        },
                        disabledColor: Theme.of(context).primaryColor
                            .withAlpha(100),
                        textColor: const Color.fromARGB(255, 254, 255, 255),
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(const Color.fromARGB(255, 254, 255, 255),
                          ),
                        ) :
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}