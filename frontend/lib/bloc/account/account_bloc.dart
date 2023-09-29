import 'dart:async';
import 'package:bloc/bloc.dart';
import 'account_events.dart';
import 'account_state.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(
    AccountState(
      token: ''
    )
  );

  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is LoginEvent) {
      yield state.copyWith(
        token: event.token
      );
    } else if (event is LogoutEvent) {
      yield state.copyWith(
        token: ''
      );
    }
  }
}
