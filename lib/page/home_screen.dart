import 'package:bloc_login/bloc/auth_bloc.dart';
import 'package:bloc_login/page/login_screen.dart';
import 'package:bloc_login/widgets/gradient_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Center(
                child: Text((state as AuthSuccess).uid),
              ),
              GradientButton(onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              })
            ],
          );
        },
      ),
    );
  }
}
