
import '../../../core/data/models/plans/plans_model.dart';

abstract class PlansStates{}

class PlansLoading extends PlansStates{}

class NotFreeTrial extends PlansStates{}
class SubscribeSuccess extends PlansStates{}
class SubscribeFailed extends PlansStates{}
class SubscribeLoading extends PlansStates{}



class GetPlansSuccess extends PlansStates{

  final List<PlansModel>plansList;
  GetPlansSuccess(this.plansList);
}

class GetPlansFailed extends PlansStates{

  final String msg;
  GetPlansFailed(this.msg);
}


class NetworkFailed extends PlansStates{

  final String msg;
  NetworkFailed(this.msg);
}