import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zuqui/present/auth/utils/send_otp.dart';
import 'package:zuqui/service/auth/main.dart';
import 'package:zuqui/utils/misc.dart';
import 'package:zuqui/utils/snackbar.dart';

class VerifyOtpArgs {
  final String email;

  const VerifyOtpArgs({required this.email});
}

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool _verifying = false;

  int _resendCooldown = 0;
  void Function()? _cancelCooldown;

  VerifyOtpArgs get args {
    return GoRouterState.of(context).extra! as VerifyOtpArgs;
  }

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    _cancelCooldown?.call();
    _cancelCooldown = countdown(60, (v) => setState(() => _resendCooldown = v));
  }

  void _verify() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _verifying = true;
    });

    final otp = _otpController.text;

    final authService = GetIt.instance.get<AuthSerice>();
    final result = await authService.loginOTP(args.email, otp);
    result.match(
      onOk: (_) {
        context.go("/home");
      },
      onError: (error) {
        if (error is DioException && error.response?.statusCode == 401) {
          snackBar("Invalid Code");
        } else {
          snackBar(error.toString());
        }

        setState(() {
          _verifying = false;
        });
      },
    );
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _resend() async {
    final authService = GetIt.instance.get<AuthSerice>();
    await sendOTP(authService, args.email);
    _startCooldown();
  }

  @override
  void dispose() {
    _cancelCooldown?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resendCooling = _resendCooldown > 0;
    final resendText =
        resendCooling ? "Resend (${_resendCooldown}s)" : "Resend";

    final verify = _verifying ? null : _verify;
    final resend = _verifying || resendCooling ? null : _resend;
    final cancel = _verifying ? null : _cancel;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Column(
                children: [
                  Center(child: Text(args.email)),
                  SizedBox(
                    width: 120,
                    child: TextButton(
                      onPressed: resend,
                      child: Text(resendText),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 320,
                      child: PinCodeTextField(
                        appContext: context,
                        controller: _otpController,
                        length: 6,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.visiblePassword,
                        textCapitalization: TextCapitalization.characters,
                        autovalidateMode: AutovalidateMode.disabled,
                        onCompleted: (_) => _verify(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.uppercase(),
                          FormBuilderValidators.equalLength(6),
                        ]),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9A-Z]'),
                          ),
                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          fieldHeight: 50,
                          fieldWidth: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(onPressed: verify, child: Text("Verify")),
                      TextButton(onPressed: cancel, child: Text("Cancel")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
