import 'package:flutter/material.dart';

import 'get_response.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body: Container(
        // alignment: Alignment.topCenter,
        // height: MediaQuery.of(context).size.height*0.4,
        // width: MediaQuery.of(context).size.width*0.6,
        decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: TextButton(
          child: Text(
            'click to see Contacts',
            style: TextStyle(fontSize: 28),
          ),
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (_) => GetResponse()));
          },
        ),
      ),
    );
  }
}
