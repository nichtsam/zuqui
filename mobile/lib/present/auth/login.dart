import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:zuqui/present/auth/utils/send_otp.dart';
import 'package:zuqui/present/auth/verify_otp.dart';

import '../../service/auth/main.dart' show AuthSerice;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    final email = _emailController.text;

    final authService = GetIt.instance.get<AuthSerice>();
    final result = await sendOTP(authService, email);
    result.match(
      onOk: (_) {
        context.push("/auth/otp/verify", extra: VerifyOtpArgs(email: email));
      },
      onError: (_) {},
    );

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hi! Welcome to Zuqui!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      decoration: InputDecoration(
                        label: const Text("Email"),
                        suffixIcon: IconButton(
                          onPressed: _emailController.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loading ? null : _submit,
                      child:
                          _loading
                              ? CircularProgressIndicator.adaptive()
                              : const Text("Send a Login Code"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
