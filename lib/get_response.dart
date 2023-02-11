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
var DB;
var _headers = {"Accept-Encoding":"gzip, deflate, br","content-type":"application/json","Accept": "application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6InNhaSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3VwbiI6IkhBUFBTQUxFU0RFViIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcHJpbWFyeXNpZCI6IjE2MTEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ByaW1hcnlncm91cHNpZCI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI2MmM4OTIxYi1lOWQyLTU0OTMtYjhjZC0xNjhlMWVjZTczZGUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2dyb3Vwc2lkIjoiMTU3YTJjY2EtMTk1NC00ZTg5LTlkMzUtYTAzYmJkNzEzNjNkIiwianRpIjoiYTBiNDZkNWMtMDFlMy00OGU4LTlmZTQtNDI4OTEyZWMzZTQ1IiwiZXhwIjoxNzA3MTAzNjkxLCJpc3MiOiJoYXBwc2FsZXMuY29tIiwiYXVkIjoiaGFwcHNhbGVzLmNvbSJ9.d4L4bEIz1lvpFW_4BmwL5Rwh78bKV6OfDXyoD-6QPOo"};
var _body = jsonEncode({ "UserData" : "1611", "SearchText": "" });

class _GetResponseState extends State<GetResponse> {

  Future apicall()async{
    http.Response _response;
    var client = http.Client();
    _response = await http.post(Uri.parse('http://13.68.210.77:8080/api/v1/ManagerRequest/GetContactPaged'),headers: _headers,body: _body);
    if (_response.statusCode == 200) {
      setState(() {
        listResponse = json.decode(_response.body);
        print('hello');
        print(listResponse!.length);
        // listResponse = mapResponse!['data'];
      });
    }
    print(_response.body);
    print(_response.statusCode);
    printFunc();
    // print(_response.toString());

  }
  
  void printFunc() async{
    // var queryy = await SQLManage.sqlInstance.readDB();
    // print('Reading DB');
    // print(queryy);
    // print('reading DB');
    for (var i =0;i<listResponse!.length;i++){
    await DB.sqlInstance.inserted({DB.colName:listResponse![i]["ContactName"], DB.colId:listResponse![i]["ContactID"],DB.colName2:listResponse![i]["AccountName"]});
      print(listResponse![i]["ContactName"]);
    }
  }

  @override
  void initState() {
    apicall();
    DB= SQLManage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sample'),
      ),
      body: Container(
        color: Colors.red.shade200,
        child:listResponse ==null ?Text('data is loading'):Text(listResponse![1]['AccountName'].toString()),
      ),
    );
  }
}