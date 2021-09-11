import 'package:flutter/material.dart';
import 'package:shoppingmall/widgets/show_signout.dart';

class SelerService extends StatefulWidget {
  const SelerService({ Key? key }) : super(key: key);

  @override
  _SelerServiceState createState() => _SelerServiceState();
}

class _SelerServiceState extends State<SelerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Seler'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
      
    );
  }
}
