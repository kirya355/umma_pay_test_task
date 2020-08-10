import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapplication/blocs/main_bloc.dart';
import 'package:testapplication/constants.dart';
import 'package:testapplication/data.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo_hor.png',
            fit: BoxFit.contain,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          print('state.listItems: ${state.listItems}');

          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _card(newsData[0], context),
              _card(newsData[1], context),
              _card(newsData[2], context),
              _card(newsData[3], context),
              state.listItems != null
                  ? Expanded(child: state.listItems)
                  : Container()
            ],
          );
        }));
  }

  Widget _card(Map<String, dynamic> map, BuildContext context) {
    /*  String title, String description, String image, String author , String date,*/
    final record = Record.fromMap(map);

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        child: Center(
          child: Row(
            children: [
              Container(
                height: 130,
                width: 130,
                child: Image.asset(record.image),
              ),
              Column(
                children: [
                  //хочу переносить этот текст
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          record.title,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
