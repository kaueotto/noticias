import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/link.dart';

import 'package:noticias/member.dart';
import 'package:url_launcher/url_launcher.dart';

class NotState extends State<NotWidget> {
  var _members = <Member>[];
  final _font = const TextStyle(fontSize: 20.0);

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    String url = "http://servicodados.ibge.gov.br/api/v3/noticias/?qtd=30";
    http.Response response = await http.get(Uri.parse(url));
    //print(json.decode(response.body));

    setState(() {
      final membersJSON = (json.decode(response.body)['items']);
      for (var member in membersJSON) {
        _members.add(Member(member["titulo"], member["introducao"],
            member["data_publicacao"], member["link"]));
      }
    });
  }

  Widget _buildRow(position) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "${_members[position].titulo}",
              style: _font,
            ),
            Text("${_members[position].introducao}",
                style: TextStyle(color: Colors.black, fontSize: 15.0)),
            IconButton(
              icon: Icon(Icons.link),
              onPressed: () async {
                if (await canLaunch(_members[position].link)) {
                  await launch(_members[position].link);
                } else {
                  throw 'Not Lauch ${_members[position].link}';
                }
                ;
              },
            ),
            Text(
              "${_members[position].data_publicacao}",
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
      itemCount: _members.length,
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
