import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  const TransactionList({Key key, this.transaction, this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      radius: 30,
                      child: Text('\$${transaction[index].amount}'),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Delete Item',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  content: Text(
                                    'Are you sure to delete this transaction?',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context,
                                          deleteTx(transaction[index].id)),
                                      child: Text('Yes'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        )
                      : IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Delete Item',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  content: Text(
                                    'Are you sure to delete this transaction?',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context,
                                          deleteTx(transaction[index].id)),
                                      child: Text('Yes'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          )),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
