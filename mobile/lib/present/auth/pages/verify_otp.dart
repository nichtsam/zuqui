import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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

  Timer? _resendTimer;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    setState(() {
      _resendCooldown = 60;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCooldown > 0) {
          _resendCooldown--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  void _verify() async {
    if (!mounted) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _verifying = true;
    });
    final otp = _otpController.text;
    debugPrint(otp);
    await Future.delayed(Duration(seconds: 1)); // verify process
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    }

    setState(() {
      _verifying = false;
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _resend() {
    _startCooldown();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as VerifyOtpArgs;
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
                  TextButton(onPressed: resend, child: Text(resendText)),
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
