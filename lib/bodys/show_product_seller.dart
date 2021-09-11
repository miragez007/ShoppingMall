import 'package:flutter/material.dart';
import 'package:shoppingmall/ultility/my_constant.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}




class _ShowProductSellerState extends State<ShowProductSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Show Product'),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
            child: Text('Add'),
      ),
    );
  }
}
