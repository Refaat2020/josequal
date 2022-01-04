import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:josequal/cubit/images_cubit.dart';
import 'package:josequal/ui/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final imagesCubit = context.watch<ImagesCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "Favorite Images",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
              color: Colors.black),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,size: 22.sp,),

        ),
      ),
      body:imagesCubit.favoriteImages.length ==0 ?
      Center(
        child: Text("There are no favorite images yet",style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w700),),
      )
      :GridView.builder(
        itemCount: imagesCubit.favoriteImages.length,
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenUtil().screenWidth / 42,
          mainAxisSpacing: ScreenUtil().screenHeight / 75,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return Material(
            elevation: 4,
            child: CachedNetworkImage(
              imageUrl:
              imagesCubit.favoriteImages[index],
              fit: BoxFit.fitHeight,
              errorWidget: (context, url, error) {
                return Center(
                    child: Image.asset(
                      "assets/noIcon.png",
                      height:
                      ScreenUtil().screenHeight / 4.2.h,
                    ));
              },
              progressIndicatorBuilder:
                  (context, url, progress) =>
                  Center(
                    child: LoadingWidget(),
                  ),
            ),
          );
        },
      ),
    );
  }
}
