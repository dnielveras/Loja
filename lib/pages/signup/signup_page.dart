import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 147, 36, 50),
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(color: Color.fromARGB(255, 254, 255, 255))
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: const Color.fromARGB(255, 254, 255, 255),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_,userManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty)
                          return 'Campo Obrigatório';
                        else if(name.trim().split(' ').length <= 1)
                          return 'Preencha seu Nome Completo';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email){
                        if(email.isEmpty)
                          return 'Campo Obrigatório';
                        else if(!emailValid(email))
                          return 'E-mail inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: const Color.fromARGB(255, 147, 36, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textColor: const Color.fromARGB(255, 254, 255, 255),
                        onPressed: userManager.loading ? null : (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            if(user.password != user.confirmPassword){
                              scaffoldKey.currentState.showSnackBar(
                                  const SnackBar(
                                    content: Text('Senhas não coincidem!'),
                                    backgroundColor: Colors.red,
                                  )
                              );
                              return;
                            }
                            userManager.signUp(
                              user: user,
                              onSuccess: (){
                                Navigator.of(context).pop();
                              },
                              onFail: (e){
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao cadastrar: $e'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              }
                            );
                          }
                        },
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                        )
                            : const Text(
                          'Criar Conta',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}