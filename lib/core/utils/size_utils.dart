// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:flutter/widgets.dart';

const num FIGMA_DESIGN_WIDTH = 375;
const num FIGMA_DESIGN_HEIGHT = 800;
const num FIGMA_DESIGN_STATUS_BAR = 0;

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
    
/// Builds the widget whenever the orientation changes.
final ResponsiveBuild builder;
  const Sizer({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints,orientation);
        return builder(context,orientation,SizeUtils.deviceType);
      },);
    },);
  }
}
class SizeUtils {
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late DeviceType deviceType;
  static late double height;
  static late double width;

  static void setScreenSize(BoxConstraints newBoxConstraints, Orientation newOrientation) {
    boxConstraints = newBoxConstraints;
    orientation = newOrientation;
    if(orientation == Orientation.portrait){
      width = boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else{
      width = boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }


  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

extension ResponsiveExtension on num {

  double get _height => SizeUtils.height;
  double get _width => SizeUtils.width;

  double get v => (this * _height)/(FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);
  double get h => (this * _width)/(FIGMA_DESIGN_WIDTH);

  double get fSize => adaptSize;

  /// This method is used to set text font size according to Viewport
  double get adaptSize{
    var height = v;
    var width = h;
    return height > width ? height.toDoubleValue() : width.toDoubleValue();
  }
  
}