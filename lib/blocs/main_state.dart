part of 'main_bloc.dart';

@immutable
abstract class MainState extends Equatable {
  final List<DocumentSnapshot> listItems;
  MainState(this.listItems);

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
  MainInitial(List<DocumentSnapshot> listItems) : super(listItems);
}

class NewsViewState extends MainState {
  NewsViewState() : super(null);
}
