import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Theme.of(context).primaryColor,
      size:  25.0.sp,
    );
  }
}
