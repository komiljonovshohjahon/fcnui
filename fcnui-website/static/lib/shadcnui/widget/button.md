```dart
class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  Button({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```