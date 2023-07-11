part of '../view.dart';

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return UploadedTableTitle(
      child: BlocConsumer<LoadsCubit, AddLoadStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (context, state) {
            return RefreshIndicator(
              color: Colors.orange,
              backgroundColor: Colors.white,
              onRefresh: () async {
                print('refresh');
                LoadsCubit.get(context).resetPage();
                LoadsCubit.get(context)
                    .getLoad(self: 1, isFilter: false, context: context);
              },
              child: state is AddLoadLoading
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
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: LoadsCubit.get(context).myloadList.length + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            LoadsCubit.get(context).myloadList.length) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (LoadsCubit.get(context).page > 1) {
                                      LoadsCubit.get(context).resetPage();
                                      LoadsCubit.get(context).getLoad(
                                        self: 1,
                                        pag: LoadsCubit.get(context).page,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.skip_previous_rounded,
                                    color: LoadsCubit.get(context).page > 1
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (LoadsCubit.get(context).page > 1) {
                                      LoadsCubit.get(context).changePage(
                                          LoadsCubit.get(context).page - 1);
                                      LoadsCubit.get(context).getLoad(
                                          pag: LoadsCubit.get(context).page,
                                          self: 1);
                                    }
                                  },
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    color: LoadsCubit.get(context).page > 1
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  height: 24,
                                  width: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    LoadsCubit.get(context).page.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    int page = LoadsCubit.get(context).page;

                                    if (LoadsCubit.get(context)
                                            .myloadList
                                            .length
                                            .remainder(10) ==
                                        0) {
                                      LoadsCubit.get(context)
                                          .changePage(page + 1);

                                      LoadsCubit.get(context).getLoad(
                                          pag: LoadsCubit.get(context).page,
                                          self: 1);
                                    }
                                  },
                                  child: Icon(
                                    Icons.chevron_right_outlined,
                                    color: LoadsCubit.get(context)
                                                .loadList
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
                                  "${LoadsCubit.get(context).myloadList[index].originCity == null ? "other" : LoadsCubit.get(context).myloadList[index].originCity!.title}"
                                  " (${LoadsCubit.get(context).myloadList[index].originState == null ? "other" : LoadsCubit.get(context).myloadList[index].originState!.title} , "
                                  "${LoadsCubit.get(context).myloadList[index].originCountry == null ? "other" : LoadsCubit.get(context).myloadList[index].originCountry!.title}) "
                                  " → "
                                  "${LoadsCubit.get(context).myloadList[index].destinationCity == null ? "other" : LoadsCubit.get(context).myloadList[index].destinationCity!.title}"
                                  " (${LoadsCubit.get(context).myloadList[index].destinationState == null ? "other" : LoadsCubit.get(context).myloadList[index].destinationState!.title} , "
                                  "${LoadsCubit.get(context).myloadList[index].destinationCountry == null ? "other" : LoadsCubit.get(context).myloadList[index].destinationCountry!.title}) ",
                              editFunc: () {
                                MagicRouter.navigateTo(AddVehiclesView(
                                    isLoadEdit: true,
                                    vehiclesModel: LoadsCubit.get(context)
                                        .myloadList[index],
                                    index: index));
                              },
                              deleteFunc: () {
                                print('delete load');
                                print(LoadsCubit.get(context)
                                    .myloadList[index]
                                    .id);
                                LoadsCubit.get(context).deleteLoadsCubit(
                                    LoadsCubit.get(context)
                                        .myloadList[index]
                                        .id);
                              },
                              tableWeight:
                                  "${LoadsCubit.get(context).myloadList[index].weight}",
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
