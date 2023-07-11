part of '../view.dart';

class OnDrawer extends StatelessWidget {
  OnDrawer({Key? key, this.inHome = false}) : super(key: key);
  bool inHome = false;
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Do You want to log out?'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35.sp,
                    ),
                    Expanded(
                        child: CustomButton(
                            function: () => Navigator.pop(context, false),
                            text: 'No',
                            height: 37.sp,
                            font: 15)),
                    SizedBox(
                      width: 35.sp,
                    ),
                    Expanded(
                        child: CustomButton(
                      function: () => MagicRouter.navigateTo(Login()),
                      text: 'Yes',
                      height: 37.sp,
                      font: 15,
                    )),
                    SizedBox(
                      width: 35.sp,
                    ),
                  ],
                ),
              ),
            ],
          ));
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomRowDrawer(
              text: 'Home',
              isHome: true,
              icon: Icons.home,
              inHome: inHome,
              navigatename: const Home(),
            ),
            CustomRowDrawer(
              text: 'Upload Load',
              icon: Icons.railway_alert_outlined,
              navigatename: const UploadedLoadsView(),
            ),
            CustomRowDrawer(
              text: 'Upload Product',
              icon: Icons.add_business_outlined,
              navigatename: const UploadProductsView(),
            ),
            CustomRowDrawer(
              text: 'Upload Job',
              icon: Icons.work_outline,
              navigatename: const UploadJobsView(),
            ),
            CustomRowDrawer(
              text: 'Upload Vehicle',
              icon: Icons.local_shipping_outlined,
              navigatename: const UploadVehiclesView(),
            ),
            CustomRowDrawer(
              text: 'Upload Advertisement',
              icon: Icons.featured_video_outlined,
              navigatename: const UploadAdvertismentsView(),
            ),
            CustomRowDrawer(
              text: 'Blogs',
              navigatename: const BlogsView(),
            ),
            CustomRowDrawer(
              text: 'Packages',
              icon: Icons.all_inbox_rounded,
              navigatename: PackagesView(),
            ),
            CustomRowDrawer(
              text: 'Subscription Details',
              icon: Icons.details_outlined,
              navigatename: const SubscriptionDetailsView(),
            ),
            CustomRowDrawer(
              text: 'Change Pass',
              icon: Icons.change_circle,
              navigatename: ChangePassView(),
            ),
            CustomRowDrawer(
              text: 'ContactUs',
              icon: Icons.contact_support_outlined,
              navigatename: ContactUsView(),
            ),
            CustomRowDrawer(
              text: 'Add / Update Card Details',
              icon: Icons.credit_card,
              navigatename: AddUpdateCardView(),
            ),
            CustomRowDrawer(
              text: 'AboutUs',
              icon: Icons.info_outline,
              navigatename: AboutUsView(),
            ),
            CustomRowDrawer(
              text: 'Logout',
              icon: Icons.logout_outlined,
              ontap: true,
              beforeNavigate: () {
                CacheHelper.putString(SharedKeys.token, '');
                CacheHelper.putBool(SharedKeys.isLogin, false);
                print('hellooooooo');
              },
            ),
          ],
        ),
      ),
    );
  }
}
