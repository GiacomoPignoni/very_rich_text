# very_rich_text
A Flutter widget to make RichText Widget more useful.  
Give to it some settings and a text with some markup and it will show a beautifull styled text as you want.

## Why VeryRichText
I needed a widget to show text with different color and format, RichText was the answer but it not work really good with dynamic data. So I make something to parse a simple markuped text and build a RichText Widget with settings from the markup.

## Getting Started
It's very simple, set the variable you need, wrap the text inside square brackets and specify the variable name at the start.  
You can also use only the color with hex code.  

<img width="193" alt="Screenshot" src="https://user-images.githubusercontent.com/34923063/109712044-d1836d80-7b9f-11eb-8dcb-defa096c4f4a.png">

```dart
VeryRichTextWidget(
  "[blue Hello] [greenBold World][#aa0000 !]\nText without style",
  baseStyle: TextStyle(
    fontSize: 22,
    color: Colors.black
  ),
  variables: [
    RichTextVar(name: "blue", style: TextStyle(color: Colors.blue)),
    RichTextVar(name: "greenBold", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
  ]
)
```
