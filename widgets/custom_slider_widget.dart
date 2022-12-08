import 'dart:ui' as ui;

import 'package:be_universe/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key? key,
    required this.value,
    required this.callback,
    required this.text,
  }) : super(key: key);

  final double value;
  final void Function(double) callback;
  final String text;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double value;
  LinearGradient gradient = const LinearGradient(colors: <Color>[
    Color(0xFFD2876F),
    Color(0xFF523072),
  ]);

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        RedText(text: widget.text),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                // width: 270,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2340),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    // overlayShape: const CircleThumbShape(thumbRadius: 2),
                    overlayColor: Colors.pink[50],
                    // overlayColor: const Color(0xFF7390D6).withOpacity(0.7),
                    // thumbColor: Colors.black,
                    // thumbColor: Colors.green,
                    thumbShape: const CircleThumbShape(thumbRadius: 10),
                    inactiveTrackColor: Colors.white,
                    trackShape: GradientRectSliderTrackShape(
                      gradient: gradient,
                    ),
                    // disabledThumbColor: Colors.grey,
                    overlappingShapeStrokeColor: Colors.brown,
                  ),
                  child: Slider(
                    min: 1.0,
                    max: 10.0,
                    value: value,
                    onChanged: (d) {
                      value = d;
                      widget.callback(d);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${widget.value.toInt()}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 10.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final borderPaint = Paint();
    borderPaint.strokeWidth = 4;
// borderPaint.colorFilter= ColorFilter.mode(Colors.grey, BlendMode.lighten);
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.shader = ui.Gradient.radial(
      const Offset(1, 1),
      250,
      [
        const Color(0xFFD2876F),
        const Color(0xFF523072),
      ],
    );

    // final paint5 = Paint()
    //   ..shader = RadialGradient(
    //     colors: [
    //       Colors.blue.withOpacity(0.7),
    //       Colors.green.withOpacity(0.7),
    //       Colors.teal.withOpacity(0.7),
    //       Colors.red.withOpacity(0.2),
    //     ],
    //   ).createShader(
    //     Rect.fromCircle(
    //       center: const Offset(1, 1),
    // radius: 30, center: const Offset(-1, 1),
    // ),
    // )
    // ..strokeWidth = 10
    // ..style = PaintingStyle.stroke;
    //
    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
  });

  final LinearGradient gradient;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(sliderTheme.trackHeight != null && sliderTheme.trackHeight! > 0);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    // final ColorTween activeTrackColorTween = ColorTween(
    //     begin: sliderTheme.disabledActiveTrackColor,
    //     end: sliderTheme.activeTrackColor);

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect);

    final Paint inactivePaint = Paint();

    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
