import 'package:encode2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  List<dynamic> history = travelHistory['data'];
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(0,20,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var item in history)
          Container(
            padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              children: [
                Icon(
                  Icons.playlist_add_check,
                  color: Colors.blue[800],
                  size: 30
                ),
                SizedBox(width:18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["paymentID"],
                      style: TextStyle(
                        fontSize: 19
                      )
                    ),
                    SizedBox(height:3),
                    Text(
                        item["busNumber"],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )
                    )
                  ],
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}
