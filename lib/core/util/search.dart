import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  String selectedResult;
  final List<String> listExample;
  String default_image = "https://longsshotokan.com/wp-content/uploads/2017/04/default-image-620x600.jpg";

  Search(this.listExample);

  List<String> recentList = ["Text4", "Text3"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("Result");
    return body(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty ? suggestionList = recentList : suggestionList.addAll(
        listExample.where((element) => element.contains(query)));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
              suggestionList[index],
            ),
            onTap: () {
              query = suggestionList[index];
              showResults(context);
            }
        );
      },
    );
  }

  Widget body(String query) {

    print("Quary_"+query);

    return StreamBuilder<QuerySnapshot>(
        stream: (query != "" && query != null)
            ? Firestore.instance
            .collection('products')
            .where("searchKeywords", arrayContains: query)
            .snapshots()
            : Firestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {

          print('Snapshot---'+snapshot.toString());
          print("data-----"+snapshot.data.toString());
          print("lenth-----"+snapshot.data.size.toString());
          print('Inside before return snapshot');
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.documents[index];

              print("Snapshot----"+data.toString());
              print("Data---"+data.data().toString() );

              return Card(
                child: Row(
                  children: <Widget>[
                    Image.network(
                      data.data()['image'] == null ? default_image :data.data()['image'],
                      width: 150,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      data.data()['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

}