import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ishowapp/InputCustom.dart';
import 'package:ishowapp/BotaoAnimado.dart';
//exibição da tela em camera lenta

import 'package:flutter/scheduler.dart' show timeDilation;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _animacaoBlur;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this
    );

    _animacaoBlur = Tween<double>(
      begin: 5,
      end: 0
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease
    ));

    _animacaoFade = Tween<double>(
        begin: 0,
        end: 1
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuint
    ));

    _animacaoSize = Tween<double>(
        begin: 0,
        end: 500
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate
    ));

    _animationController.forward();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }



  @override
  Widget build(BuildContext context) {


    timeDilation=2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animacaoBlur,
                builder: (context, widget){
                  return Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("imagens/fundo.png"),
                            fit: BoxFit.fill
                        )
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        //efeito na horizontal
                          sigmaX: _animacaoBlur.value,
                          sigmaY: _animacaoBlur.value
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            child: FadeTransition(
                              opacity: _animacaoFade,
                              child: Image.asset("imagens/detalhe1.png"),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            child: FadeTransition(
                              opacity: _animacaoFade,
                              child: Image.asset("imagens/detalhe2.png"),
                            )
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animacaoSize,
                      builder: (context,widget){
                        return Container(
                          width: _animacaoSize.value,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              InputCustom(
                                hint: "E-mail",
                                obscure: false,
                                icon: Icon(Icons.person),
                              ),
                              InputCustom(
                                hint: "Senha",
                                obscure: true,
                                icon: Icon(Icons.lock),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow:[
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 15,
                                    spreadRadius: 4
                                )
                              ]
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                    BotaoAnimado(
                      animationController: _animationController,
                    ),
                    SizedBox(height: 10,),
                    FadeTransition(
                      opacity: _animacaoFade,
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 100, 127, 1),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
