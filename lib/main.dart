import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:programacao_mobile/heroesdetail.dart';
import 'package:programacao_mobile/Heroes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Heroes',
      theme: ThemeData(
      primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Marvel Heroes'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var publicKey ="22ec9cca057f5d000d1d4e535b743e61";
  var privateKey = "979814d8b2e2dbd1a91415ff2f7223686af95b3e";

  var url = "https://gateway.marvel.com:443/v1/public/characters?ts=1&orderBy=name&apikey=22ec9cca057f5d000d1d4e535b743e61&hash=7ba7945cb850a0673bbb1e5633fd0ca7";
  Heroes herois;
  String _textT="";
  String _aux ="";

@override
 void initState(){
   super.initState();
   fetchData();
 }

// Recebendo JSON
fetchData() async{
  var res = await http.get(url);
  var  decodeJson = jsonDecode(res.body);
  herois = Heroes.fromJson(decodeJson);
  setState(() {});
}

// Visual
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed:(){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: Drawer(),
        body: herois == null?Center(child: CircularProgressIndicator(),)
        : GridView.count(crossAxisCount: 2, children: herois.data.results.map((hero) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HeroesDetail(
                heroisM: hero,
              )));
            },
    child:Hero(
      tag: hero.thumbnail,
          child:Card(
            elevation: 3.0,
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(hero.thumbnail.path + "." + hero.thumbnail.extension)),
                    ),
                  ),
                  Text(hero.name, textAlign: TextAlign.center, style:  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                ],
              )
          ),),), )).toList(),)
// This trailing comma makes auto-formatting nicer for build methods AQUI
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  final heroes = [
    "Hulk",
    "Homem de Ferro",
    "Viuva Negra"
  ];
  final recentHeroes = [
    "Hulk"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Botão limpar quandoe stá pesquisando
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      })];
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Botão voltar quando está pesquisando
    return IconButton(
        icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
        ),
      onPressed: (){
          close(context, null);
      });

  }

  @override
  Widget buildResults(BuildContext context) {

    return Center(
      child: Container(
      height: 100.0,
      width: 100.0,
      child: Card(
      color: Colors.red,
        child: Center(
        child: Text(query),
      ),
      ),
    )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Realizar pesquisa e mostrar itens recentes
    final suggestionList = query.isEmpty?recentHeroes:heroes.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemBuilder: (context,index)=> ListTile(
        // Quando clicar no nome do heroi fazer algo
        onTap: (){
          showResults(context);
        },
    leading: Icon(Icons.face),
        // Quando esta pesquisando as letras ficam em negrito
      title: RichText(text: TextSpan(
        text:suggestionList[index].substring(0, query.length),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color:  Colors.grey))
        ]),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }

}