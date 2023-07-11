part of '../view.dart';

class FormView extends StatefulWidget {
  FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstnameController = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
        builder: (context, state) {
          print(firstnameController.text);
          print("firstnameController");

          firstnameController.text =
              UpdateProfileCubit.get(context).profileData.firstName ?? '';

          lastnameController.text =
              UpdateProfileCubit.get(context).profileData.lastName ?? '';
          emailController.text =
              UpdateProfileCubit.get(context).profileData.email ?? '';
          phoneController.text =
              UpdateProfileCubit.get(context).profileData.contactNumber ?? '';
          usernameController.text =
              UpdateProfileCubit.get(context).profileData.username ?? '';
          addressController.text =
              UpdateProfileCubit.get(context).profileData.address ?? '';
          return UpdateProfileCubit.get(context).loading
              ? const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  )),
                )
              : UpdateProfileCubit.get(context).notLogged
                  ? const CustomNotLoggedIn()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: CustomCard(
                          widget: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.sp, vertical: 15.sp),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: firstnameController,
                                    validate: Validator.validateName,
                                  ),
                                  CustomTextField(
                                    controller: lastnameController,
                                    validate: Validator.validateName,
                                  ),
                                  CustomTextField(
                                    controller: emailController,
                                    validate: Validator.validateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  CustomTextField(
                                    controller: phoneController,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Phone';
                                      }
                                    },
                                    keyboardType: TextInputType.phone,
                                  ),
                                  CustomTextField(
                                    controller: usernameController,
                                  ),
                                  CustomTextField(
                                    height: 180.h,
                                    lines: 6,
                                    validate: Validator.validateAddress,
                                    controller: addressController,
                                    keyboardType: TextInputType.streetAddress,
                                  ),
                                  if (state is UpdateLoading)
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 17, bottom: 27),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.orange),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 17, bottom: 20),
                                      child: CustomButton(
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            UpdateProfileCubit.get(context)
                                                .updateProfile(
                                              UpdateProfile(
                                                firstName: firstnameController
                                                    .text
                                                    .trim(),
                                                lastName: lastnameController
                                                    .text
                                                    .trim(),
                                                username: usernameController
                                                    .text
                                                    .trim(),
                                                phone:
                                                    phoneController.text.trim(),
                                                email:
                                                    emailController.text.trim(),
                                                address: addressController.text
                                                    .trim(),
                                              ),
                                            );
                                            print(CacheHelper.getString(
                                                SharedKeys.token));
                                          }
                                        },
                                        text: 'Update Profile',
                                        color: ColorManager.yellow,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 27),
                                    child: CustomButton(
                                      function: () {
                                        CacheHelper.putString(
                                            SharedKeys.token, '');
                                        CacheHelper.putBool(
                                            SharedKeys.isLogin, false);
                                        MagicRouter.navigateTo(Login());
                                      },
                                      text: 'Log out',
                                      color: ColorManager.yellow,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
        },
        listener: (context, state) {});
  }
}
