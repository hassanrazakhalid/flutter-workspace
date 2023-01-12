import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as p;

class OrderItem extends StatefulWidget {
  final p.OrderItem item;
  const OrderItem({Key? key, required this.item}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expaned = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.item.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                '${DateFormat('dd/MM/yyyy hh:mm').format(widget.item.dateTime)}'),
            trailing: IconButton(
              icon: Icon(_expaned ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() {
                  _expaned = !_expaned;
                });
              },
            ),
          ),
          if (_expaned)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: min(
                (widget.item.products.length * 20) + 100,
                180,
              ),
              child: ListView(
                children: [
                  ...widget.item.products
                      .map(
                        (e) => Row(
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${e.quantity}x  \$${e.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
