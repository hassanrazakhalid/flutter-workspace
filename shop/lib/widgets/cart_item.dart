import 'package:flutter/material.dart';
import '../providers/cart.dart' as st;

class CartItem extends StatelessWidget {
  final st.CartItem item;
  final Function() itemDeleted;

  const CartItem({Key? key, required this.item, required this.itemDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        itemDeleted();
      },
      confirmDismiss: (direction) {
        // return Future(() => null)
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure ?'),
                  content: Text('Do you want to remove'),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ));
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\$${item.price}',
                  ),
                ),
              ),
            ),
            title: Text(item.title),
            subtitle: Text('Total \$${item.price * item.quantity}'),
            trailing: Text('\$${item.quantity}'),
          ),
        ),
      ),
    );
  }
}
