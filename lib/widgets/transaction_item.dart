import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required Function removeItemFromTransactionHandler,
  })  : _removeItemFromTransactionHandler = removeItemFromTransactionHandler,
        super(key: key);

  final Transaction transaction;
  final Function _removeItemFromTransactionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

Color _bgColor;

class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transaction.date),
          style: Theme.of(context).textTheme.title,
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? Container(
                child: FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => widget
                    ._removeItemFromTransactionHandler(widget.transaction.id),
              ))
            : Container(
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget
                      ._removeItemFromTransactionHandler(widget.transaction.id),
                ),
              ),
      ),
    );
  }
}
