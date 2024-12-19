import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// An effect that adjust the size of target between the specified [begin] and [end]
/// offset values. unlike [ScaleEffect], this effect does affect the real size
/// of the widget.
/// Defaults to `begin=0.0, end=1.0`.
@immutable
class SizeEffect extends Effect<double> {
  static const double neutralValue = 1.0;
  static const double defaultValue = 0.0;
  static const double defaultAxisAlignment = 0.0;

  const SizeEffect({
    super.delay,
    super.duration,
    super.curve,
    double? begin,
    double? end,
    this.fixedWidthFactor,
    this.fixedHeightFactor,
    this.alignment,
  }) : super(
          begin: begin ?? (end == null ? defaultValue : neutralValue),
          end: end ?? neutralValue,
        );

  final AlignmentGeometry? alignment;
  final double? fixedWidthFactor;
  final double? fixedHeightFactor;

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
    EffectEntry entry,
  ) {
    final animation = buildAnimation(controller, entry);
    return getOptimizedBuilder<double>(
      animation: animation,
      builder: (_, __) {
        return ClipRect(
          child: Align(
            alignment: alignment ?? Alignment.center,
            widthFactor: fixedWidthFactor ?? math.max(animation.value, 0.0),
            heightFactor: fixedHeightFactor ?? math.max(animation.value, 0.0),
            child: child,
          ),
        );
      },
    );
  }
}

/// Adds [SizeEffect] related extensions to [AnimateManager].
extension SizeEffectExtensions<T extends AnimateManager<T>> on T {
  /// Adds a [SizeEffect] that adjust the size of target between
  /// the specified [begin] and [end] offset values.
  ///
  T size({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    double? begin,
    double? end,
    double? fixedWidthFactor,
    double? fixedHeightFactor,
    AlignmentGeometry? alignment,
  }) =>
      addEffect(SizeEffect(
        delay: delay,
        duration: duration,
        curve: curve,
        begin: begin,
        end: end,
        alignment: alignment,
        fixedWidthFactor: fixedWidthFactor,
        fixedHeightFactor: fixedHeightFactor,
      ));

  /// Adds a [SizeEffect] that adjust the size of target horizontally between
  /// the specified [begin] and [end] values.
  ///
  /// [axisAlignment] describes how to align the child along the horizontal axis
  /// that [sizeFactor] is modifying.
  T sizeX({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    double? begin,
    double? end,
    double? axisAlignment,
  }) =>
      addEffect(SizeEffect(
          delay: delay,
          duration: duration,
          curve: curve,
          begin: begin,
          end: end,
          fixedHeightFactor: 1.0,
          alignment: AlignmentDirectional(
              axisAlignment ?? SizeEffect.defaultAxisAlignment, -1.0)));

  /// Adds a [SizeEffect] that adjust the size of target vertically between
  /// the specified [begin] and [end] values.
  ///
  /// [axisAlignment] describes how to align the child along the vertical axis
  /// that [sizeFactor] is modifying.
  T sizeY({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    double? begin,
    double? end,
    double? axisAlignment,
  }) =>
      addEffect(SizeEffect(
          delay: delay,
          duration: duration,
          curve: curve,
          begin: begin,
          end: end,
          fixedWidthFactor: 1.0,
          alignment: AlignmentDirectional(
            -1.0,
            axisAlignment ?? SizeEffect.defaultAxisAlignment,
          )));
}
