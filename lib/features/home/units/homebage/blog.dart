import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/widgets/custom_container_blog.dart';
import '../../../../widgets/widgets/custom_text.dart';
import '../../../blogs/bloc/blog_cubit.dart';
import '../../../blogs/bloc/blog_states.dart';

class blog extends StatelessWidget {
  const blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogsCubit, BlogsState>(
        listener: (BuildContext context, state) {
      print(BlogsCubit.get(context).blogList.length);
    }, builder: (BuildContext context, Object? state) {

        return ListView.builder(
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: BlogsCubit.get(context).blogList.length,
            itemBuilder: (context, index) {
              return CustomContainerBlog(
                  BlogsCubit.get(context).blogList[index]);
            });

    });
  }
}
