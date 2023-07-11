import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/features/home/states.dart';
import 'package:hoga_load/features/home/units/homescreen.dart';
import 'package:hoga_load/features/jobs/view.dart';
import 'package:hoga_load/features/loads/cubit/getLoad_cubit.dart';
import '../../core/data/api/api.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../loads/get_loads/view.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct_cubit.dart';
import 'package:hoga_load/features/search_product/view.dart';
import '../vehicles/get_vehicles/cubit/vehicle_cubit.dart';
import '../vehicles/get_vehicles/view.dart';

import '../jobs/cubit/getJop_cubit.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeLayoutLoading());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const SearchView(),
    const LoadsView(),
    const VehiclesView(),
     JobsView()
  ];

  void changeBottom(int index, context) {
    currentIndex = index;
    if (currentIndex == 3) VehiclesCubit.get(context).getVehicleCubit(context,self: 0);
    if (currentIndex == 2)
      LoadsCubit.get(context).getLoad(self: 0, isFilter: false);
    if (currentIndex == 1) ProductsCubit.get(context).getProduct();
    if (currentIndex == 4) JopCubit.get(context).getJops(isFilter: false,self: 0);

    emit(ChangeBottomNavState());
  }

  isSubscription()async{
    print('isSubscription');
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api().getHttp(url: "profile/current-subscription", authToken: token)
        .then((value) => {
    if(value['record']['subscription_details']['stripe_id']==null){
      CacheHelper.putBool(SharedKeys.isSubscribe, false),
    }else{
      CacheHelper.putBool(SharedKeys.isSubscribe, true),

    },
    print('isSubscription'),
        print(CacheHelper.getBool(SharedKeys.isSubscribe)
    ),

    emit(Subscription()),

    });
  }
}
