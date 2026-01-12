import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldHelper extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? hint, obscuringCharacter;
  final bool enabled;
  final int? maxLines, minLines, maxLength;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon, prefix;
  final IconData? icon;
  final TextInputAction? action;
  final FocusNode? focusNode;

  final BorderRadius? borderRadius;
  final bool? isMobile;
  final TextStyle? hintStyle;
  const TextFormFieldHelper({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hint,
    this.enabled = true,
    this.obscuringCharacter,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
    this.isMobile,
    this.hintStyle,
  });

  @override
  State<TextFormFieldHelper> createState() => _TextFormFieldHelperState();
}

class _TextFormFieldHelperState extends State<TextFormFieldHelper> {
  late bool obscureText;
  TextDirection _textDirection = TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() => obscureText = !obscureText);
  }

  void _updateTextDirection(String text) {
    if (text.isEmpty) return;
    final isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(text);
    setState(() {
      _textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.onValidate,
      onChanged: (text) {
        widget.onChanged?.call(text);
        _updateTextDirection(text);
      },
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: obscureText,
      obscuringCharacter: widget.obscuringCharacter ?? '*',

      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w500,
      ),

      textAlign: widget.isMobile != null ? TextAlign.left : TextAlign.start,

      textDirection: widget.isMobile != null
          ? TextDirection.ltr
          : _textDirection,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle:
            widget.hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
        errorMaxLines: 4,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12.sp,
        ),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 27.r,
                ),
              )
            : widget.suffixWidget,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        border: outlineInputBorder(color: const Color(0xffBABABA), width: 1),
        enabledBorder: outlineInputBorder(color: Colors.grey, width: 1),
        focusedBorder: outlineInputBorder(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),
        errorBorder: outlineInputBorder(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
        focusedErrorBorder: outlineInputBorder(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(40.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
