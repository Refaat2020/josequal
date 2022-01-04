import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:josequal/cubit/images_cubit.dart';
import 'package:josequal/ui/screens/wallpaper_details_screen.dart';
import 'package:josequal/ui/widgets/big_button.dart';
import 'package:josequal/ui/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SearchScreen extends StatelessWidget {
TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Search",
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
          TextField(
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.text,
            controller: _controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 10.w,
              ),
              hintText: "Your keyword",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.1)),
              border: const OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1.1)),
            ),

          ),
          SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 20.h),
              child: BigButton(height: 40.h, width: ScreenUtil().screenWidth/3, name: "Search", onTap: (){
                if (_controller.text != "") {
                  print(_controller.text);
                  context.read<ImagesCubit>().searchForImage(_controller.text.toString());
                }
              }, textColor: Colors.white, containerColor: Colors.black, borderColor: Colors.black)),
          BlocBuilder<ImagesCubit, ImagesState>(
            builder: (context, state) {
              if(state is ImagesSearchFetched)
              {
                return GridView.builder(
                  itemCount: state.images.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenUtil().screenWidth / 42,
                    mainAxisSpacing: ScreenUtil().screenHeight / 75,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperDetailsScreen( state.images[index].src.original),)),
                      child: Material(
                        elevation: 4,
                        child: CachedNetworkImage(
                          imageUrl:
                          state.images[index].src.original,
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
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text("Please search for any image",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.w700),),
              );
            },
          )
        ],
      ),
    );
  }
}
