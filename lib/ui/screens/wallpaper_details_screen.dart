import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:josequal/cubit/images_cubit.dart';
import 'package:josequal/ui/widgets/big_button.dart';
import 'package:josequal/ui/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WallpaperDetailsScreen extends StatelessWidget {
final String imageUrl;

WallpaperDetailsScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "Wallpaper Details",
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
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 30.h),
            child: Column(
              children: [
              SizedBox(

                child: CachedNetworkImage(
                imageUrl:
                imageUrl,
                fit: BoxFit.contain,
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
                height: ScreenUtil().screenHeight/2,
                width:ScreenUtil().screenWidth ,
              ),
                SizedBox(height: 40.h,),
                Padding(
                  padding:  EdgeInsets.only(right: 10.w,left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigButton(height: 44.h, width: ScreenUtil().screenWidth/2.5, name: "Download Image", onTap: ()async{
                        context.read<ImagesCubit>().downloadImage(context, imageUrl);
                      }, textColor: Colors.white, containerColor: Colors.black, borderColor:  Colors.black),
                      BigButton(height: 44.h, width: ScreenUtil().screenWidth/2.5, name: "Add to favorite", onTap: (){
                        context.read<ImagesCubit>().addToFavorite(imageUrl);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to your favorit images",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 14.sp),),elevation: 4,backgroundColor: Colors.black,));
                      }, textColor: Colors.white, containerColor: Colors.red, borderColor:  Colors.red),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }
}
