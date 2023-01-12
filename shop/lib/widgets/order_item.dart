import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as p;

class OrderItem extends StatelessWidget {
  final p.OrderItem item;
  const OrderItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${item.amount}'),
            subtitle:
                Text('${DateFormat('dd MM yyyy hh:mm').format(item.dateTime)}'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.expand_more),
            ),
          )
        ],
      ),
    );
  }
}
