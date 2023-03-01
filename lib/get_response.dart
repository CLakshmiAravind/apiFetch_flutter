import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sample/sqlite.dart';

class GetResponse extends StatefulWidget {
  const GetResponse({super.key});

  @override
  State<GetResponse> createState() => _GetResponseState();
}

String? stringResponse;
Map? mapResponse;
List? listResponse;
var _headers = {
  "Accept-Encoding": "gzip, deflate, br",
  "content-type": "application/json",
  "Accept": "application/json",
  "Authorization":
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6InNhaSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3VwbiI6IkhBUFBTQUxFU0RFViIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcHJpbWFyeXNpZCI6IjE2MTEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ByaW1hcnlncm91cHNpZCI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI2MmM4OTIxYi1lOWQyLTU0OTMtYjhjZC0xNjhlMWVjZTczZGUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2dyb3Vwc2lkIjoiMTU3YTJjY2EtMTk1NC00ZTg5LTlkMzUtYTAzYmJkNzEzNjNkIiwianRpIjoiYTBiNDZkNWMtMDFlMy00OGU4LTlmZTQtNDI4OTEyZWMzZTQ1IiwiZXhwIjoxNzA3MTAzNjkxLCJpc3MiOiJoYXBwc2FsZXMuY29tIiwiYXVkIjoiaGFwcHNhbGVzLmNvbSJ9.d4L4bEIz1lvpFW_4BmwL5Rwh78bKV6OfDXyoD-6QPOo"
};
var _body = jsonEncode({"UserData": "1611", "SearchText": ""});
// late final data;

class _GetResponseState extends State<GetResponse> {
  List<Map<String, dynamic>> data = [];

  void _refreshJournals() async {
    data = await DBManager.getItems();
    print("total length of a list is : ${data.length}");

    // print(data);
    // setState(() {
    //   _journals = data;
    // });
  }

  Future apicall() async {
    http.Response _response;
    var client = http.Client();
    _response = await http.post(
        Uri.parse(
            'http://13.68.210.77:8080/api/v1/ManagerRequest/GetContactPaged'),
        headers: _headers,
        body: _body);
    if (_response.statusCode == 200) {
      setState(() {
        listResponse = json.decode(_response.body);
      });
    }
    // print(_response.body);
    print(_response.statusCode);
    await printFunc();
    setState(() {
    _refreshJournals();
    });
  }
 @override
  void initState() {
    apicall();
    // TODO: implement initState
    // printFunc();
    _refreshJournals();
    super.initState();
  }

  Future<void> printFunc() async {
    for (var i = 0; i < listResponse!.length; i++) {
      await DBManager.createItem(listResponse![i]['ContactID'],
          listResponse![i]['ContactName'], listResponse![i]['AccountName']);
      // print(listResponse![i]["ContactName"]);
      // print(listResponse![i]['ContactID']);
      // print(listResponse![i]['AccountName']);
    }
      // print("total length of a list is : ${data.length}");
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: listResponse == null
          ? Center(
            child: Text(
                'data is loading... ',
                style: TextStyle(fontSize: 30),
              ),
          )
          : ListView.builder(
              itemBuilder: ((context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        // color: Colors.green.shade200,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images${index}.jpg'),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index]['ContactName'],style: TextStyle(fontSize: 20),),
                                Text(data[index]['AccountName'])
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              itemCount: data.length),
    );
  }
}
