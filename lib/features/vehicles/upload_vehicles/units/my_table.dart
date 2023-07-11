part of '../view.dart';

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return UploadedTableTitle(
      child: BlocConsumer<VehiclesCubit, VehicleStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (context, state) {
            return RefreshIndicator(
              color: Colors.orange,
              backgroundColor: Colors.white,
              onRefresh: () async {
                print('refresh');
                await VehiclesCubit.get(context).resetPage();
                await VehiclesCubit.get(context).getVehicleCubit(context,
                    page: VehiclesCubit.get(context).page, self: 1);
              },
              child: state is VehicleLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          color: index.isEven ? Colors.grey[300] : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      enabled: true,
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                      child: Container(
                                          width: 0.2.sw,
                                          height: 12.sp,
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                        enabled: true,
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                        child: Container(
                                            width: 0.2.sw,
                                            height: 12.sp,
                                            color: Colors.grey[300])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                        enabled: true,
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                        child: Container(
                                            width: 0.2.sw,
                                            height: 12.sp,
                                            color: Colors.grey[300])),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          VehiclesCubit.get(context).myVehicleList.length + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            VehiclesCubit.get(context).myVehicleList.length) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (VehiclesCubit.get(context).page > 1) {
                                      VehiclesCubit.get(context).resetPage();
                                      VehiclesCubit.get(context)
                                          .getVehicleCubit(context,
                                              page: VehiclesCubit.get(context)
                                                  .page,
                                              self: 1);
                                    }
                                  },
                                  child: Icon(
                                    Icons.skip_previous_rounded,
                                    color: VehiclesCubit.get(context).page > 1
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (VehiclesCubit.get(context).page > 1) {
                                      VehiclesCubit.get(context).changePage(
                                          VehiclesCubit.get(context).page - 1);
                                      VehiclesCubit.get(context)
                                          .getVehicleCubit(context,
                                              page: VehiclesCubit.get(context)
                                                  .page,
                                              self: 1);
                                    }
                                  },
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    color: VehiclesCubit.get(context).page > 1
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 24,
                                  width: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    VehiclesCubit.get(context).page.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    int page = VehiclesCubit.get(context).page;

                                    if (VehiclesCubit.get(context)
                                            .myVehicleList
                                            .length
                                            .remainder(10) ==
                                        0) {
                                      VehiclesCubit.get(context)
                                          .changePage(page + 1);

                                      VehiclesCubit.get(context)
                                          .getVehicleCubit(context,
                                              page: VehiclesCubit.get(context)
                                                  .page,
                                              self: 1);
                                    }
                                  },
                                  child: Icon(
                                    Icons.chevron_right_outlined,
                                    color: VehiclesCubit.get(context)
                                                .myVehicleList
                                                .length
                                                .remainder(10) ==
                                            0
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                Icon(
                                  Icons.skip_next,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            color:
                                index.isEven ? Colors.grey[300] : Colors.white,
                            child: UploadedTableDataRow(
                              origin:
                                  "${VehiclesCubit.get(context).myVehicleList[index].originCity == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].originCity!.title}"
                                  " (${VehiclesCubit.get(context).myVehicleList[index].originState == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].originState!.title} , "
                                  "${VehiclesCubit.get(context).myVehicleList[index].originCountry == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].originCountry!.title}) "
                                  " → "
                                  "${VehiclesCubit.get(context).myVehicleList[index].destinationCity == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].destinationCity!.title}"
                                  " (${VehiclesCubit.get(context).myVehicleList[index].destinationState == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].destinationState!.title} , "
                                  "${VehiclesCubit.get(context).myVehicleList[index].destinationCountry == null ? "other" : VehiclesCubit.get(context).myVehicleList[index].destinationCountry!.title}) ",
                              editFunc: () {
                                MagicRouter.navigateTo(AddVehiclesView(
                                    isEdit: true,
                                    vehiclesModel: VehiclesCubit.get(context)
                                        .myVehicleList[index],
                                    index: index));
                                //VehiclesCubit.get(context).editVehicleCubit(context:context,vehicleId:VehiclesCubit.get(context).vehicleList[index].id);
                              },
                              deleteFunc: () {
                                VehiclesCubit.get(context).deleteVehicleCubit(
                                    VehiclesCubit.get(context)
                                        .myVehicleList[index]
                                        .id);
                              },
                              tableWeight:
                                  "${VehiclesCubit.get(context).myVehicleList[index].weight}",
                              tableNumber: "${index + 1}",
                            ),
                          );
                        }
                      }),
            );
          }),
    );
  }
}
