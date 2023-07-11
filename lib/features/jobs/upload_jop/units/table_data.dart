import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/features/jobs/upload_jop/units/table_jop_title.dart';
import 'package:hoga_load/widgets/widgets/uploaded_table_row.dart';
import '../../../../core/router/router.dart';
import '../../cubit/getJop_cubit.dart';
import '../../cubit/getJop_states.dart';
import '../add_view.dart';

class MyJopTable extends StatelessWidget {
  const MyJopTable({super.key});

  @override
  Widget build(BuildContext context) {
    return uploadedTableJop(
      child: BlocConsumer<JopCubit, AddJopStates>(
          listener: (BuildContext context, Object? state) {

          },
          builder: (context, state) {
            return     RefreshIndicator(
            color: Colors.orange,
            backgroundColor: Colors.white,
            onRefresh: ()async{
            print('refresh');
            JopCubit.get(context).getJops(self: 1, isFilter: false, context: context);
            },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: JopCubit.get(context).myJopList.length+1,
                  itemBuilder: (context, index) {
    if (index == JopCubit.get(context).myJopList.length) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (JopCubit
                    .get(context)
                    .page >
                    1) {
                  JopCubit.get(context).resetPage();
                  JopCubit.get(context).getJops(
                    page:
                    JopCubit
                        .get(context)
                        .page,
                  );
                }
              },
              child: Icon(
                Icons.skip_previous_rounded,
                color:
                JopCubit
                    .get(context)
                    .page > 1
                    ? Colors.grey[600]
                    : Colors.grey[400],
              ),
            ),
            InkWell(
              onTap: () {
                if (JopCubit
                    .get(context)
                    .page >
                    1) {
                  JopCubit.get(context).changePage(
                      JopCubit
                          .get(context)
                          .page -
                          1);
                  JopCubit.get(context).getJops(
                    page:
                    JopCubit
                        .get(context)
                        .page,
                    self: 1
                  );
                }
              },
              child: Icon(
                Icons.chevron_left_outlined,
                color:
                JopCubit
                    .get(context)
                    .page > 1
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
                borderRadius:
                BorderRadius.circular(3),
              ),
              child: Text(
                JopCubit
                    .get(context)
                    .page
                    .toString(),
                style:
                TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                int page =
                    JopCubit
                        .get(context)
                        .page;

                if (JopCubit
                    .get(context)
                    .myJopList
                    .length
                    .remainder(10) ==
                    0) {
                  JopCubit.get(context)
                      .changePage(page + 1);

                  JopCubit.get(context).getJops(
                    page:
                    JopCubit
                        .get(context)
                        .page,
                  );
                }
              },
              child: Icon(
                Icons.chevron_right_outlined,
                color: JopCubit
                    .get(context)
                    .searchList
                    .length >=
                    10 &&
                    JopCubit
                        .get(context)
                        .searchList
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
      );} else{
      return Container(
        color: index.isEven ? Colors.grey[300] : Colors.white,
        child: UploadedTableDataRow(
          flex: 2,
          origin: "${JopCubit
              .get(context)
              .myJopList[index].title}",
          editFunc: () {
            MagicRouter.navigateTo(AddJopView(
                isEdit: true,
                jopModel: JopCubit
                    .get(context)
                    .myJopList[index],
                index: index));
          },
          deleteFunc: () {
            print(index);
            print(JopCubit
                .get(context)
                .myJopList[index].id);
            print('job id');
            JopCubit.get(context).deleteJopCubit(
                JopCubit
                    .get(context)
                    .myJopList[index].id);
          },
          flex2: 5,
          tableWeight:
          " (${JopCubit
              .get(context)
              .myJopList[index].state == null ? "other" : JopCubit
              .get(context)
              .myJopList[index].state!.title}, "
              " → "
              "${JopCubit
              .get(context)
              .myJopList[index].city == null ? "other" : JopCubit
              .get(context)
              .myJopList[index].city!.title})",
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


