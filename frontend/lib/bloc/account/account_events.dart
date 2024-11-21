class AccountEvent {}


class LoginEvent extends AccountEvent {
  final String token;

  LoginEvent(this.token);
}

class LogoutEvent extends AccountEvent {}
