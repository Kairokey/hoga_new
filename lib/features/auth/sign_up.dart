import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    as v;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/auth/login.dart';
import 'package:hoga_load/features/auth/units/custom_have_account.dart';
import 'package:hoga_load/features/auth/units/customer_text_field.dart';
import 'package:hoga_load/features/auth/units/profile_image.dart';
import 'package:hoga_load/features/home/view.dart';

import '../../core/data/models/vehicle/user.dart';
import '../../core/dialoges/toast.dart';
import '../../core/validator/validator.dart';
import '../../core/widgets/custom_card.dart';
import '../../widgets/widgets/custom_appbar.dart';
import '../../widgets/widgets/custom_button.dart';
import '../../widgets/widgets/custom_privacy.dart';
import '../vehicles/get_vehicles/cubit/vehicle_cubit.dart';
import 'domain/auth_cubit.dart';
import 'domain/auth_states.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? firstNameController = TextEditingController();

  TextEditingController? lastNameController = TextEditingController();

  TextEditingController? phoneController = TextEditingController();

  TextEditingController? addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var image;

  @override
  void initState() {
    super.initState();
    image = AuthCubit.get(context).image;
  }

  @override
  Widget build(BuildContext context) {
    return v.KeyboardVisibilityBuilder(
      builder: (context, visible) => Padding(
        padding: EdgeInsets.only(bottom: visible ? .31.sh : 0),
        child: Scaffold(
            body: BlocConsumer<AuthCubit, AuthStates>(
                listener: (BuildContext context, state) {
          if (state is SignUpSuccess) {
            MagicRouter.navigateAndReplacement(Login());
            image = null;
            AuthCubit.get(context).image = null;
          }
        }, builder: (BuildContext context, state) {
          if (state is ImageCamera || state is ImageGallery) {
            image = AuthCubit.get(context).image;
          }
          return Column(
            children: [
              CustomAppbar(
                title: 'Sign Up',
                hideIcons: true,
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CustomCard(
                    widget: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          ProfileImage(image),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextFormField(
                                hintText: 'First Name',
                                controller: firstNameController,
                                validate: Validator.validateName,
                              )),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                  child: CustomTextFormField(
                                hintText: 'Last Name',
                                controller: lastNameController,
                                validate: Validator.validateName,
                              )),
                            ],
                          ),
                          CustomTextFormField(
                            hintText: 'Enter E-mail',
                            controller: emailController,
                            validate: Validator.validateEmail,
                          ),
                          CustomTextFormField(
                            hintText: 'Enter Phone Number',
                            controller: phoneController,
                            validate: Validator.validateEmpty,
                          ),
                          CustomTextFormField(
                              hintText: 'Enter Address',
                              controller: addressController,
                              validate: Validator.validateEmpty),
                          CustomTextFormField(
                              hintText: 'Enter Password',
                              controller: passwordController,
                              validate: Validator.validatePassword),
                          const SizedBox(
                            height: 15,
                          ),
                          Privacy(VehiclesCubit.get(context).value),
                          const SizedBox(
                            height: 5,
                          ),
                          if (state is SignUpLoading)
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            )
                          else
                            CustomButton(
                              function: () {
                                if (VehiclesCubit.get(context).value == false) {
                                  showToast(
                                      msg:
                                          'You need to agree with the terms and conditions and policies.',
                                      state: ToastedStates.ERROR);
                                }
                                if (formKey.currentState!.validate() &&
                                    VehiclesCubit.get(context).value == true) {
                                  AuthCubit.get(context).signUp(User(
                                      firstName:
                                          firstNameController!.text.trim(),
                                      lastName: lastNameController!.text.trim(),
                                      email: emailController!.text.trim(),
                                      contactNumber:
                                          phoneController!.text.trim(),
                                      profilePicture: image.toString(),
                                      password: passwordController!.text.trim(),
                                      address: addressController!.text.trim()));
                                }
                              },
                              text: 'Sign Up',
                              color: ColorManager.yellow,
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          HaveAccount()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        })),
      ),
    );
  }
}
