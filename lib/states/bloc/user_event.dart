part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
