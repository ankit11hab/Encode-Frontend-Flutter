import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final String currSearch;
  const SearchResults({Key? key, required this.currSearch}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Current Bookings",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500
                )
            ),
            Container(
              margin:EdgeInsets.fromLTRB(0,20,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        children: [
                          Icon(
                              Icons.list,
                              color: Colors.blue[800],
                              size: 30
                          ),
                          SizedBox(width:18),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "paymentID",
                                  style: TextStyle(
                                      fontSize: 19
                                  )
                              ),
                              SizedBox(height:3),
                              Text(
                                  "busNumber",
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
            )
          ],
        )
    );
  }
}
