import 'package:chat_app_re/constants.dart';
import 'package:chat_app_re/helper/show_snack_bar.dart';
import 'package:chat_app_re/pages/login_cubit/login_cubit.dart';
import 'package:chat_app_re/pages/resgister_page.dart';
import 'package:chat_app_re/widgets/custom_button.dart';
import 'package:chat_app_re/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget
{
  LoginPage({super.key});

  bool isLoading = false;
  static String id = 'login page';
  static String? uEmail, uPassword;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context)
  {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state)
      {
        if (state is LoginLoadingState)
        {
          isLoading = true;
        }
        else if (state is LoginSuccessState)
        {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        }
        else if (state is LoginFailureState)
        {
          showSnackBar(context, state.errorMessage!);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(key: formKey,
            child: ListView(
                children: [
                  const SizedBox(height: 75,),
                  Image.asset('assets/images/scholar.png', height: 100,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Scholar Chat', style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 75,),
                  const Row(
                    children:
                    [
                      Text('LOGIN', style: TextStyle( fontSize: 24, color: Colors.white,),),
                    ],
                  ),
                  const SizedBox( height: 20, ),
                  CustomFormTextField(
                    onChanged: (data) {
                      uEmail = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox( height: 10,),
                  CustomFormTextField(
                    obscureText: true,
                    onChanged: (data) {
                      uPassword = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 20,),
                  CustomButon(
                    onTap: () async {
                      if (formKey.currentState!.validate())
                      {
                        BlocProvider.of<LoginCubit>(context).login(email: uEmail!, password: uPassword!);
                      }
                      else
                      {
                        
                      }
                    },
                    text: 'LOGIN',
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('dont\'t have an account?', style: TextStyle(color: Colors.white,),
                      ),
                      GestureDetector(
                        onTap: () {Navigator.pushNamed(context, RegisterPage.id);},
                        child: const Text('Register', style: TextStyle(color: Color(0xffC7EDE6),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
