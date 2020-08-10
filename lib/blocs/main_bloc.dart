import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial(null)) {
    _buildBody();
  }
  Widget listItems;
  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is DataCome) print('listItems: $listItems');
    yield MainInitial(listItems);
  }

  Future _buildBody() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("news").getDocuments();
    List<DocumentSnapshot> list = List();
    for (var i in querySnapshot.documents) {
      list.add(i);
    }
    listItems = _buildList(list);
    add(DataCome());
  }

  Widget _buildList(List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(data)).toList(),
    );
  }

  Widget _buildListItem(DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.title),
          trailing: Text(record.description),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Record {
  final String title;
  final String description;
  /*  String title, String description, ,  , ,*/
  final String image;
  final String author;
  final String date;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['description'] != null),
        assert(map['image'] != null),
        title = map['title'],
        description = map['description'],
        image =map['image'],
        author =map['author'],
        date =map['date']
  ;

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$description>";
}
