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
  List<DocumentSnapshot> listItems;
  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is DataCome) yield MainInitial(listItems);
  }

  Future _buildBody() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("news").getDocuments();
    List<DocumentSnapshot> list = List();
    for (var i in querySnapshot.documents) {
      list.add(i);
    }
    listItems = list;
    add(DataCome());
  }
}

class Record {
  final String title;
  final String description;
  final String image;
  final String author;
  final String date;
  final DocumentReference reference;
  final bool isSnapshot;
  Record.fromMap(Map<String, dynamic> map, bool isSnapshot, {this.reference})
      : assert(map['title'] != null),
        assert(map['description'] != null),
        assert(map['image'] != null),
        title = map['title'],
        description = map['description'],
        image = map['image'],
        author = map['author'],
        date = map['date'],
        isSnapshot = isSnapshot;

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, true, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$description>";
}
