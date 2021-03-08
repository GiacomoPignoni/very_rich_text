import 'package:flutter/material.dart';
import 'data_wrapper.dart';
import 'hex_color.dart';
import 'rich_var.dart';

const mainRegex = r"\[(.+?[^\]\[]+)\]|([^\]\[]+)";
const hexCodeRegex = r"#([a-fA-F0-9]{6}|[a-fA-F0-9]{3})";

class VeryRichTextWidget extends StatelessWidget {

  late final String text;
  final TextStyle? baseStyle;
  final List<RichTextVar> variables;
  late final RegExp variablesRegex;

  VeryRichTextWidget(this.text, { this.baseStyle, this.variables = const[] }) {
    String str = r"";
    this.variables.forEach((v) {
      str += "^${v.name}|";
    });
    this.variablesRegex = RegExp(str);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: this.baseStyle ?? Theme.of(context).primaryTextTheme.bodyText1,
        children: _getTextSpans()
      )
    );
  }

  List<TextSpan> _getTextSpans() {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(mainRegex);
    final matches = exp.allMatches(this.text);
    matches.forEach((m) {
      if(m.group(2) != null) {
        spans.add(TextSpan(
          text: m.group(2)
        ));
      } else {
        var str = DataWrapper(m.group(1));
        final style = _findStyle(str);
        spans.add(TextSpan(
          text: str.value,
          style: style
        ));
      }
    });
    return spans;
  }

  TextStyle? _findStyle(DataWrapper str) {
    // Search for variables
    var match = this.variablesRegex.firstMatch(str.value);
    if(match != null) {
      String varStr = match.group(0) ?? "";
      if(varStr.isNotEmpty) {
        final v = this.variables.firstWhere((x) => x.name == match?.group(0));
        str.value = str.value.substring(match.end + 1);
        return v.style;
      }
    }

    // Check for hex code
    match = RegExp(hexCodeRegex).firstMatch(str.value);
    if(match != null) {
      String hexCodeStr = match.group(0) ?? "";
      if(hexCodeStr.isNotEmpty) {
        str.value = str.value.substring(match.end);
        return TextStyle(color: HexColor.fromHex(hexCodeStr));
      }
    }

    return null;
  }
}