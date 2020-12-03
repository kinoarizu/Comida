import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comida/model/model.dart';
import 'package:comida/network/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUser) {
      final auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        User user = User(
          id: null,
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          addresses: null,
        );

        yield UserLoaded(user);
      } 
      else {
        User user = await UserRepository.getUser();
        yield UserLoaded(user);
      }
    }
    else if (event is SignOut) {
      yield UserInitial();
    }
  }
}
