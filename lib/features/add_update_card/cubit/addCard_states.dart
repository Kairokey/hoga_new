import '../../../core/data/models/Card.dart';

abstract class AddCardStates {}

class AddingCardLoading extends AddCardStates {}

class AddingCardSuccess extends AddCardStates {}

class GetUserProfileLoading extends AddCardStates {}

class GetUserProfileSuccess extends AddCardStates {
  Card? profileList = Card();
  GetUserProfileSuccess({this.profileList});
}
class GetUserProfileSuccess2 extends AddCardStates {
 List<Card>  profileList = [];
 GetUserProfileSuccess2(this.profileList);
}

class GetUserProfileFailed extends AddCardStates {
  final String msg;
  GetUserProfileFailed(this.msg);
}

class AddingCardFailed extends AddCardStates {
  final String msg;
  AddingCardFailed(this.msg);
}
class CancelCardSuccess extends AddCardStates {}
class CancelCardLoading extends AddCardStates {}
class AddCardLoading extends AddCardStates {}
class NoPaymentMethod extends AddCardStates {}



class CancelCardFailed extends AddCardStates {
  final String msg;
  CancelCardFailed(this.msg);
}
class NetworkFailed extends AddCardStates {
  final String msg;
  NetworkFailed(this.msg);
}
