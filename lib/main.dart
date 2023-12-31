import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/data/local/cacheHelper.dart';
import 'package:hoga_load/core/keys/keys.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/add_update_card/cubit/addCard_cubit.dart';
import 'package:hoga_load/features/auth/domain/auth_cubit.dart';
import 'package:hoga_load/features/home/controller.dart';
import 'package:hoga_load/features/jobs/cubit/getJop_cubit.dart';
import 'package:hoga_load/features/loads/cubit/getLoad_cubit.dart';
import 'package:hoga_load/features/plans/cubit/plans_cubit.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct_cubit.dart';
import 'package:hoga_load/features/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/bloc_observer.dart';
import 'core/master_cubit/getDataForm_cubit.dart';
import 'features/blogs/bloc/blog_cubit.dart';
import 'features/change_password/cubit/changePass_cubit.dart';
import 'features/dashboard/cubit/updateProfile_cubit.dart';
import 'features/packages/cubit/package_cubit.dart';
import 'features/vehicles/get_vehicles/cubit/vehicle_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  BlocOverrides.runZoned(() {
    runApp(DevicePreview(
        enabled: false,
        builder: (context) {
          return const MyApp();
        }));
  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..isSubscription()),
        BlocProvider(create: (_) => PlansCubit()..getPlansCubit()
            //  ..checkPlansCubit()
            ),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
            create: (_) => VehiclesCubit()
              ..getAttributesCubit()
              ..getEquipmentsCubit()
              ..getVehicleSizesCubit()
              ..getVehicleTypesCubit()),
        BlocProvider(
            create: (_) => DataFormCubit()
              ..getCountry()
              ..cityList
              ..countryList
              ..stateList
              ..getProduct()
              ..getJopCategory()
              ..getJopType()),
        BlocProvider(create: (_) => LoadsCubit()),
        BlocProvider(create: (_) => ProductsCubit()),
        BlocProvider(create: (_) => JopCubit()),
        BlocProvider(
            create: (_) => PackageCubit()
              ..getPackageCubit()
              ..advertisementCubit()),
        BlocProvider(
            create: (_) => AddCardCubit()
              ..getCard()
              ..profileData),
        BlocProvider(create: (_) => ChangePassCubit()),
        BlocProvider(
            create: (_) => UpdateProfileCubit()
//            ..getSubscriptionData()
//              ..getUserProfileData()
//              ..profileData
        ),
        BlocProvider(
            create: (_) => BlogsCubit()
              ..getBlogsCubit(CacheHelper.getString(SharedKeys.token))
              ..blogList),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, _) => MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(fontFamily: 'Montserrat'),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          onGenerateRoute: onGenerateRoute,
          home: const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark),
              child: SplashScreen()),
        ),
      ),
    );
  }
}
