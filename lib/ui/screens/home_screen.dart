import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:josequal/cubit/images_cubit.dart';
import 'package:josequal/ui/screens/wallpaper_details_screen.dart';
import 'package:josequal/ui/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ImagesCubit>().getImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "Pexels Images",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
              color: Colors.black),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pushNamed(context, "/searchScreen");
        }, icon: Icon(Icons.search,color: Colors.blue,size: 22.sp,),

        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, "/favoriteScreen");
          }, icon: Icon(Icons.favorite,color: Colors.red,size: 22.sp,),

          )
        ],
      ),
      body: BlocBuilder<ImagesCubit, ImagesState>(
        builder: (context, state) {
          // if (state is ImagesLoading) {
          //   return Center(
          //     child: LoadingWidget(),
          //   );
          // }
          if(state is ImagesFetched)
            {
              return GridView.builder(
                itemCount: state.images.length,
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
            child: LoadingWidget(),
          );
        },
      ),
    );
  }
}
