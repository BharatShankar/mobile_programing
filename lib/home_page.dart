import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<itemModel> itemsList = [
    itemModel(
      false,
      "Swipe to right to complete",
    ),
    itemModel(
      false,
      "Swipe left to delete",
    ),
    itemModel(
      false,
      "Tap and hold to pick me up",
    ),
  ];

  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: generateItemsList());
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  ListView generateItemsList() {
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // to delete
              setState(() {
                itemsList.removeAt(index);
              });
            } else if (direction == DismissDirection.startToEnd) {
              // to add strike

            }
          },
          key: Key(itemsList[index].itemTxt),
          child: InkWell(
              onTap: () {
                print("${itemsList[index]} clicked");
              },
              child: ListTile(
                  title: Text(
                '${itemsList[index].itemTxt}',
                style: TextStyle(
                    decoration: !itemsList[index].itemStatus
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ))),
          background: slideRightBackground(),
          secondaryBackground: slideLeftBackground(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              setState(() {
                itemsList[index].itemStatus = true;
                itemsList[index];
                itemsList.add(itemsList[index]);
                itemsList.removeAt(index);
              });
              return false;
            } else {
              return true;
            }
          },
        );
      },
    );
  }
}

class itemModel {
  String itemTxt;
  bool itemStatus;
  itemModel(this.itemStatus, this.itemTxt);
}
