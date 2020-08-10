part of 'main_bloc.dart';

@immutable
abstract class MainState extends Equatable {
  final Widget listItems;
  MainState(this.listItems);

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
  MainInitial(Widget listItems) : super(listItems);
}

class NewsViewState extends MainState {
  NewsViewState() : super(null);
}
