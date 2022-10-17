import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:json_annotation/json_annotation.dart';

import 'package:noticias/member.dart';
import 'package:url_launcher/url_launcher.dart';

class NotState extends State<NotWidget> {
  var _Produtos = <Produto>[];
  final _font = const TextStyle(fontSize: 20.0);

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    String url =
        "http://localhost:8001/CONSULTAPRECO?produto=Smirnoff 998&Timeout=2";
    http.Response response = await http.get(Uri.parse(url));

    setState(() {
      print(response.body);
      final responseReplaced = response.body.replaceAll("'", '"');
      final membersJSON = json.decode(responseReplaced);
      for (var prod in membersJSON) {
        _Produtos.add(Produto(prod["a"], prod["b"], prod["c"], prod["d"]));
      }
    });
  }

  Widget _buildRow(position) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  _Produtos[position].Link.replaceAll('////', '//')),
            ),
            Text(
              "${_Produtos[position].Site}",
              style: _font,
            ),
            Text("${_Produtos[position].Descricao}",
                style: TextStyle(color: Colors.black, fontSize: 15.0)),
            Text(
              "${_Produtos[position].Preco}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              textAlign: TextAlign.right,
            ),
            Divider(
              color: Colors.black,
              indent: 10,
              endIndent: 10,
              height: 10,
              thickness: 0.5,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _Produtos.length,
      itemBuilder: (BuildContext context, int position) {
        return _buildRow(position);
      },
    );
  }
}

class NotWidget extends StatefulWidget {
  @override
  createState() => NotState();
}
