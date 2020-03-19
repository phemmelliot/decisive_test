import 'package:decisive_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String labelTextString;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled, isNumberOnlyInput;
  final TextEditingController controller;
  final Widget suffixIcon;
  final String prefixText;
  final String Function(String value) validator;
  final bool isPasswordField;
  final String errorText;
  final int maxLines;
  final Function onTap;

  const CustomTextField({
    Key key,
    this.labelTextString,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.controller,
    this.suffixIcon,
    this.isNumberOnlyInput = false,
    this.validator,
    this.isPasswordField = false,
    this.errorText,
    this.prefixText,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focusNode = FocusNode();
  Color labelTextColor = Colors.grey;
  TextEditingController _controller = TextEditingController();
  bool obscureText = false;

  changeFieldVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller;
    }

    if(widget.isPasswordField){
      obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      constraints: BoxConstraints(
//        maxWidth: Helper.getResponsiveWidth(82, context),
//      ),
      child: TextFormField(
        focusNode: _focusNode,
        // autofocus: false,
        inputFormatters: widget.isNumberOnlyInput
            ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            : [],
        obscureText: obscureText,
        maxLines: widget.maxLines,
        cursorColor: Helper.primaryColor,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        controller: _controller,
        onTap: widget.onTap,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Helper.primaryColor)),
            errorText: widget.errorText,
            labelText: widget.labelTextString,
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            labelStyle: TextStyle(
              color: labelTextColor,
              fontSize: 16,
              letterSpacing: 0.2,
            ),
            suffixIcon: widget.isPasswordField
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => changeFieldVisibility(),
            )
                : widget.suffixIcon,
            prefixText: widget.prefixText
        ),
        validator: widget.validator,
      ),
    );
  }
}
