import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? onValidate;
  final void Function()? onSuffixTap;
  final String? hintText;
  final Widget? prefix;
  final bool isValid;
  final bool circularBorder;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool autofocus;
  final bool enabled;
  final bool showSuffix;
  final String formatAdvice;
  final bool isPassword;
  final bool obscureText;
  final bool readOnly;
  final String obscuringCharacter;
  final bool noBorder;
  final bool errorBorder;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final double opacity;
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.keyboardType,
      this.onValidate,
      this.inputFormatters,
      this.opacity = 1,
      this.isValid = true,
      this.circularBorder = false,
      this.readOnly = false,
      this.obscuringCharacter = '•',
      this.noBorder = false,
      this.errorBorder = false,
      this.autofocus = false,
      this.controller,
      this.hintText,
      this.enabled = true,
      this.showSuffix = true,
      this.prefix,
      this.obscureText = false,
      this.onSuffixTap,
      this.formatAdvice = '',
      this.initialValue,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        height: circularBorder ? 48 : null,
        decoration: BoxDecoration(
          borderRadius: circularBorder
              ? BorderRadius.circular(24.0)
              : BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            enabled: enabled,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            autofocus: autofocus,
            obscureText: obscureText,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: onValidate,
            readOnly: readOnly,
            obscuringCharacter: obscuringCharacter,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              prefix: prefix,
              suffixIcon: showSuffix
                  ? isPassword
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: onSuffixTap,
                            child: SvgPicture.asset(
                              obscureText ? Assets.eyeClosed : Assets.eye,
                              height: 10,
                            ),
                          ),
                        )
                      : Visibility(
                          visible: isValid,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.check, color: Colors.green),
                          ),
                        )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: circularBorder
                    ? BorderRadius.circular(24.0)
                    : BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: circularBorder
                    ? BorderRadius.circular(24.0)
                    : BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color:
                      errorBorder ? Colors.red : Colors.grey.withOpacity(0.5),
                ),
              ),
              border: noBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: circularBorder
                          ? BorderRadius.circular(24.0)
                          : BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
            )),
      ),
    );
  }
}
