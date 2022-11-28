// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shop_app/providers/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrdersItem extends StatefulWidget {
  final OrderItem orders;
  const OrdersItem({required this.orders});

  @override
  State<OrdersItem> createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("₹${widget.orders.amount}"),
              subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                  .format(widget.orders.dateTime)),
              trailing: IconButton(
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  expanded = !expanded;
                },
              ),
            ),
            if (expanded)
              Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orders.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.orders.products
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${prod.quantity}x ₹${prod.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                    )
                    .toList(),
              ),
            )
          ],
        ));
  }
}
