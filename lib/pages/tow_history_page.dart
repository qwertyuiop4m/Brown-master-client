import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var data = [];

  @override
  void initState() {
    super.initState();
    this.fetchAccident();
  }

  Future fetchAccident() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      this.setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load Accident');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); //뒤로가기
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back)),
            title: Text('견인 기록 조회', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Scrollbar(
              thickness: 5.0, // 스크롤 너비
              radius: Radius.circular(8.0), // 스크롤 라운딩
              isAlwaysShown: true, // 항상 보이기 여부
              child: new ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text('userId: ${data[index]['userId'].toString()}'),
                            Text('id: ${data[index]['id'].toString()}'),
                            Text('title: ${data[index]['title']}'),
                            Text(
                                'completed: ${data[index]['completed'].toString()}'),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ));
                  }),
            ),
          )),
    );
  }
}
