import 'tmp/elegant_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [const AnimatedEmoji(AnimatedEmojis.partyPopper, size: 100), elegantText("Bonheur a gagné")],
      ),
    );
  }
}
