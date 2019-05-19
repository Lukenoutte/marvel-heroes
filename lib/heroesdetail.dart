import 'package:flutter/material.dart';
import 'package:programacao_mobile/Heroes.dart';

class HeroesDetail extends StatelessWidget {

  final Results heroisM;

  HeroesDetail({this.heroisM});

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
          Positioned (
            width: MediaQuery.of(context).size.width -20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:  Container(
              padding: new EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height:100.0,
                  ),
                  Text(heroisM.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height:10.0,
                  ),
                  Text("Descrição: ${heroisM.description}",textAlign: TextAlign.center),
                  SizedBox(
                    height:10.0,
                  ),
                  Text("Quadrinhos: " + heroisM.comics.items.length.toString(),textAlign: TextAlign.center),
                  Text("Séries de TV: " + heroisM.series.items.length.toString(),textAlign: TextAlign.center),
                  Text("Aparece em: " + heroisM.stories.items.length.toString() + " histórias de outros personagens",textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: heroisM.thumbnail, child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(heroisM.thumbnail.path + "." + heroisM.thumbnail.extension)),
          ),
        )),
      ),
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
      body: bodyWidget(context),
    );
  }
}
