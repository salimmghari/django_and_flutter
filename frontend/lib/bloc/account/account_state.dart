class AccountState {
  final String token;
  
  AccountState({required this.token});

  AccountState copyWith({required String token}) {
    return AccountState(
      token: token 
    );
  }
}
