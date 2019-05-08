import 'package:flutter/material.dart';
import 'package:programacao_mobile/Heroes.dart';

class HeroesDetail extends StatelessWidget {
  final Results heroisM;

  HeroesDetail({this.heroisM});


  bodyWidget() => Stack(
    children: <Widget>[
      Container(
        child: Card(
          child:  Column(
            children: <Widget>[
              Text(heroisM.name),
              Text("Descrição: ${heroisM.description}"),
              Text("Data de modificação mais recente: ${heroisM.modified}"),
              Text("Historias em quadrinhos:" + heroisM.comics.items.length.toString()),
              Text("URLs: ${heroisM.urls}"),

            ],
          ),
        ),
      )
    ],
  );

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
    elevation: 0.0,
        title: Text(heroisM.name),
      ),
body: bodyWidget(),
    );
  }
}
