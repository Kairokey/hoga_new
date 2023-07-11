part of '../view.dart';

class FormInfo extends StatefulWidget {
  FormInfo(
      {Key? key,
      this.isFilter = false,
      this.vehiclesModel,
      this.isEdit = false,
      this.isLoadEdit = false,
        this.isLoad=false,
      this.index})
      : super(key: key);
  bool isFilter;
  Vehicles? vehiclesModel;
  bool isEdit;
  bool isLoadEdit;
  bool isLoad;

  int? index;
  @override
  State<FormInfo> createState() => _FormInfoState();
}

class _FormInfoState extends State<FormInfo> {
  String countryOrigin = '';
  String stateOrigin = '';
  String cityOrigin = '';
  String countryDestination = '';
  String stateDestination = '';
  String cityDestination = '';
  String day = '';
  String month = '';
  String year = '';
  String date = '';

  @override
  void initState() {
    super.initState();
    VehiclesCubit.get(context).vehicleClearData(context);
    print('clearr done');
    print(VehiclesCubit.get(context).vehcleSize);
    print(VehiclesCubit.get(context).attributes);


    if (widget.isEdit || widget.isLoadEdit) {
      print(widget.vehiclesModel!.equipmentTypes!.last.id);

      print('widget.vehiclesModel!.equipmentTypes!.first.id');
      widget.vehiclesModel!.equipmentTypes?.forEach((element) {
        print(element.id);
        VehiclesCubit.get(context).equipmentType.add(element.id);
      });
      widget.vehiclesModel!.attributes?.forEach((element) {
        print(element.id);
        VehiclesCubit.get(context).attributes.add(element.id);
      });
      widget.vehiclesModel!.vehicleSizes?.forEach((element) {
        print('vehcle size');

        print(element.id);
        VehiclesCubit.get(context).vehcleSize.add(element.id);
      });
      widget.vehiclesModel!.vehicleTypes?.forEach((element) {
        print(element.id);
        VehiclesCubit.get(context).vehcleType.add(element.id);
      });

      date = widget.vehiclesModel!.availabilityDate!;
      cityDestination = widget.vehiclesModel!.destinationCity != null
          ? widget.vehiclesModel!.destinationCity!.title!
          : 'other';
      cityOrigin = widget.vehiclesModel!.originCity != null
          ? widget.vehiclesModel!.originCity!.title!
          : 'other';
      countryDestination = widget.vehiclesModel!.destinationCountry!.title!;
      countryOrigin = widget.vehiclesModel!.originCountry!.title!;stateOrigin = widget.vehiclesModel!.originState!.title!;
      stateDestination = widget.vehiclesModel!.destinationState!.title!;


      DataFormCubit.get(context).cityDestinationID =
          widget.vehiclesModel!.destinationCity != null
              ? widget.vehiclesModel!.destinationCity!.id!.toString()
              : 'other';
      DataFormCubit.get(context).cityOriginID =
          widget.vehiclesModel!.originCity != null
              ? widget.vehiclesModel!.originCity!.id!.toString()
              : 'other';
      DataFormCubit.get(context).countryOriginID =
          widget.vehiclesModel!.originCountry!.id!.toString();
      DataFormCubit.get(context).countryDestinationID =
          widget.vehiclesModel!.destinationCountry!.id!.toString();

      DataFormCubit.get(context).stateDestinationID =
          widget.vehiclesModel!.destinationState!.id!.toString();
      DataFormCubit.get(context).stateOriginID =
          widget.vehiclesModel!.originState!.id!.toString();
      DataFormCubit.get(context).dateTime =
          widget.vehiclesModel!.availabilityDate!;

      VehiclesCubit.get(context).weightController.text =
          widget.vehiclesModel!.weight!;
      VehiclesCubit.get(context).instructionsController.text =
          widget.vehiclesModel!.instructions == null
              ? ""
              : VehiclesCubit.get(context).instructionsController.text =
                  widget.vehiclesModel!.instructions.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      widget: BlocConsumer<DataFormCubit, AddDataFormStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 17.h, horizontal: 14.w),
                  child: widget.isFilter
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_sharp),
                            ),
                            Expanded(
                              child: CustomText(
                                text: widget.isLoadEdit
                                    ? 'Edit Load'
                                    : widget.isFilter
                                        ? 'Filter'
                                        : 'Add',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        )
                      :  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_sharp),
                      ),
                      Expanded(
                        child: CustomText(
                          text: widget.isLoadEdit
                              ? 'Edit Load'
                              :widget.isLoad?'ADD LOAD':widget.isFilter?'EDIT': 'ADD VEHICLE',

                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  )),
              widget.isFilter
                  ? const SizedBox()
                  : SizedBox(
                      width: 1.sw,
                      child: const Divider(
                        thickness: 1,
                      ),
                    ),
              widget.isFilter
                  ? const SizedBox()
                  : CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Availability Date',
                      hintText: date == '' ? 'dd-mm-yy' : date,
                      suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1000),
                                lastDate: DateTime(3000),
                                initialDate: DateTime.now());
                            if (newDate == null) return;
                            day = newDate.day.toString();
                            month = newDate.month.toString();
                            year = newDate.year.toString();

                            date = '$year-$month-$day';
                            setState(() {
                              DataFormCubit.get(context).dateTime = date;
                            });
                          },
                          child: const Icon(Icons.date_range_outlined)),
                    ),
              CustomTextField(
                  height: 64.h,
                  readOnly: true,
                  name: 'Original Country',
                  hintText:
                      countryOrigin == '' ? 'Select a Country' : countryOrigin,
                  suffixIcon: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                              itemCount:
                                  DataFormCubit.get(context).countryList.length,
                              itemBuilder: (context, index) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            countryOrigin =
                                                DataFormCubit.get(context)
                                                    .countryList[index]
                                                    .title!;
                                            Navigator.of(context).pop();
                                            DataFormCubit.get(context)
                                                    .countryOriginID =
                                                DataFormCubit.get(context)
                                                    .countryList[index]
                                                    .id!
                                                    .toString();
                                            cityOrigin = '';
                                            stateOrigin = '';

                                            DataFormCubit.get(context)
                                                .cityOriginID = '';
                                            DataFormCubit.get(context)
                                                .stateOriginID = '';
                                          });
                                          DataFormCubit.get(context).getState(
                                              DataFormCubit.get(context)
                                                  .countryList[index]
                                                  .id!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            DataFormCubit.get(context)
                                                .countryList[index]
                                                .title!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                      );
                    },
                    child: Icon(
                      Icons.expand_more,
                      size: 30.sp,
                      color: ColorManager.blackColor,
                    ),
                  )),
              state is GetStateLoading
                  ? CustomText(
                      text: 'Loading....',
                    )
                  : CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Original State',
                      hintText:
                          stateOrigin == '' ? 'Select a state' : stateOrigin,
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                  itemCount: DataFormCubit.get(context)
                                      .stateList
                                      .length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                stateOrigin =
                                                    DataFormCubit.get(context)
                                                        .stateList[index]
                                                        .title!;
                                                Navigator.of(context).pop();
                                                DataFormCubit.get(context)
                                                        .stateOriginID =
                                                    DataFormCubit.get(context)
                                                        .stateList[index]
                                                        .id!
                                                        .toString();
                                                cityOrigin = '';
                                                DataFormCubit.get(context)
                                                    .cityOriginID = '';
                                              });
                                              DataFormCubit.get(context)
                                                  .getCity(
                                                      DataFormCubit.get(context)
                                                          .stateList[index]
                                                          .title!);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                DataFormCubit.get(context)
                                                    .stateList[index]
                                                    .title!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
              state is GetCityLoading
                  ? CustomText(
                      text: 'Loading....',
                    )
                  : CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Original City',
                      hintText: cityOrigin == '' ? 'Select a city' : cityOrigin,
                      suffixIcon: InkWell(
                        onTap: () {
                          print(
                              'city list length is ${DataFormCubit.get(context).cityList.length}');
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return DataFormCubit.get(context).cityList.isEmpty
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          cityOrigin = 'other';
                                          Navigator.of(context).pop();
                                          DataFormCubit.get(context)
                                              .cityOriginID = 'other';
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 0.5.sh,
                                            right: 8,
                                            left: 8),
                                        child: Center(
                                          child: Text(
                                            'other',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: DataFormCubit.get(context)
                                          .cityList
                                          .length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              cityOrigin =
                                                  DataFormCubit.get(context)
                                                      .cityList[index]
                                                      .title!;
                                              Navigator.of(context).pop();
                                              DataFormCubit.get(context)
                                                      .cityOriginID =
                                                  DataFormCubit.get(context)
                                                      .cityList[index]
                                                      .id!
                                                      .toString();
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                DataFormCubit.get(context)
                                                    .cityList[index]
                                                    .title!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
              CustomTextField(
                  height: 64.h,
                  readOnly: true,
                  name: 'Destination Country',
                  hintText: countryDestination == ''
                      ? 'Select a country'
                      : countryDestination,
                  suffixIcon: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                              itemCount:
                                  DataFormCubit.get(context).countryList.length,
                              itemBuilder: (context, index) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            countryDestination =
                                                DataFormCubit.get(context)
                                                    .countryList[index]
                                                    .title!;
                                            Navigator.of(context).pop();
                                            DataFormCubit.get(context)
                                                    .countryDestinationID =
                                                DataFormCubit.get(context)
                                                    .countryList[index]
                                                    .id!
                                                    .toString();
                                            cityDestination = '';
                                            stateDestination = '';
                                            DataFormCubit.get(context)
                                                .cityDestinationID = '';
                                            DataFormCubit.get(context)
                                                .stateDestinationID = '';
                                          });
                                          DataFormCubit.get(context)
                                              .getDestintionState(
                                                  DataFormCubit.get(context)
                                                      .countryList[index]
                                                      .id!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DataFormCubit.get(context)
                                                      .countryList[index]
                                                      .title ==
                                                  null
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.green,
                                                  ),
                                                )
                                              : Text(
                                                  DataFormCubit.get(context)
                                                      .countryList[index]
                                                      .title!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.sp),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                      );
                    },
                    child: Icon(
                      Icons.expand_more,
                      size: 30.sp,
                      color: ColorManager.blackColor,
                    ),
                  )),
              state is GetDestintionStateLoading
                  ? CustomText(
                      text: 'Loading....',
                    )
                  : CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Destination State',
                      hintText: stateDestination == ''
                          ? 'Select a state'
                          : stateDestination,
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                  itemCount: DataFormCubit.get(context)
                                      .stateList
                                      .length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                stateDestination =
                                                    DataFormCubit.get(context)
                                                        .stateList[index]
                                                        .title!;
                                                Navigator.of(context).pop();
                                                DataFormCubit.get(context)
                                                        .stateDestinationID =
                                                    DataFormCubit.get(context)
                                                        .stateList[index]
                                                        .id!
                                                        .toString();
                                                cityDestination = '';
                                                DataFormCubit.get(context)
                                                    .cityDestinationID = '';
                                              });
                                              DataFormCubit.get(context)
                                                  .getDestintionCity(
                                                      DataFormCubit.get(context)
                                                          .stateList[index]
                                                          .title!);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DataFormCubit.get(context)
                                                          .stateList[index]
                                                          .title ==
                                                      null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  : Text(
                                                      DataFormCubit.get(context)
                                                          .stateList[index]
                                                          .title!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
              state is GetDestintionCityLoading
                  ? CustomText(
                      text: 'Loading....',
                    )
                  : CustomTextField(
                      height: 64.h,
                      name: 'Destination City',
                      hintText: cityDestination == ''
                          ? 'Select a city'
                          : cityDestination,
                      readOnly: true,
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return DataFormCubit.get(context).cityList.isEmpty
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          cityDestination = 'other';
                                          Navigator.of(context).pop();
                                          DataFormCubit.get(context)
                                              .cityDestinationID = 'other';
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 0.5.sh,
                                            right: 8,
                                            left: 8),
                                        child: Center(
                                          child: Text(
                                            'other',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: DataFormCubit.get(context)
                                          .cityList
                                          .length,
                                      itemBuilder: (context, index) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cityDestination =
                                                        DataFormCubit.get(
                                                                context)
                                                            .cityList[index]
                                                            .title!;
                                                    Navigator.of(context).pop();
                                                    DataFormCubit.get(context)
                                                            .cityDestinationID =
                                                        DataFormCubit.get(
                                                                context)
                                                            .cityList[index]
                                                            .id!
                                                            .toString();
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    DataFormCubit.get(context)
                                                        .cityList[index]
                                                        .title!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.sp),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
              SizedBox(
                width: 1.sw,
                child: const Divider(
                  thickness: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
