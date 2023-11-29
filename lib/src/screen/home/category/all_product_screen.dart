import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';
import 'package:saudi_adaminnovations/src/utils/custom_provider.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/all_product_model.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/app_theme_data.dart';
import '../../../servers/repository.dart';
import 'package:saudi_adaminnovations/src/utils/responsive.dart';
import '../../../widgets/product_card_widgets/category_product_card.dart';
import '../../../widgets/loader/shimmer_load_data.dart';
import '../../../widgets/loader/shimmer_products.dart';

class AllProductView extends StatefulWidget {
  const AllProductView({Key? key}) : super(key: key);

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  final homeScreenContentController = Get.put(HomeScreenController());

  int page = 0;

  PaginationViewType paginationViewType = PaginationViewType.gridView;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();

  Future<List<Data>> getData(int offset,) async {
    //page = (offset / 1).round();
    page++;

    return await Repository().getAllProduct(sortData:themeProvider.getSortKey(),page: page);
  }

  @override
  void initState() {
    themeProvider=Provider.of<ThemeProvider>(context, listen: false);
    super.initState();
  }
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: isMobile(context)? AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.allProduct.tr,
            style: AppThemeData.headerTextStyle_16,
          ),
        ): AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60.h,
          leadingWidth: 40.w,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25.r,
            ),

            onPressed: () {
              themeProvider.setSort(AppTags.latestontop);
              themeProvider.setSortKey("latest_on_top");
              Get.back();
            }, // null disables the button
          ),
          centerTitle: true,
          title: Text(
            AppTags.allProduct.tr,
            style: AppThemeData.headerTextStyle_14,
          ),
        ),
        body: ListView(physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(

                child: DropdownButton<String>(
                  isExpanded: false,

                  value: themeProvider.getSort(),


                  hint: Text("Sort"),
                  items: <String>[AppTags.latestontop,AppTags.oldestontop, AppTags.hightolow, AppTags.lowtohigh].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                      themeProvider.setSort(value!);
                      if(themeProvider.getSort()==AppTags.latestontop){
                        themeProvider.setSortKey("latest_on_top");
                      }
                      else if(themeProvider.getSort()==AppTags.oldestontop){
                        themeProvider.setSortKey("oldest_on_top");

                      }
                      else if(themeProvider.getSort()==AppTags.hightolow){
                        themeProvider.setSortKey("high_to_low");
                      }
                      else{
                        themeProvider.setSortKey("low_to_high");
                      }


                      Get.back();
                      Get.to(() => const AllProductView());


                  },
                ),
              ),
            ),
            Container(height: MediaQuery.of(context).size.height,
              child: PaginationView<Data>(
                key: key,
                physics: BouncingScrollPhysics(),
                paginationViewType: paginationViewType,
                pageFetch: getData,
                pullToRefresh: false,
                onError: (dynamic error) => Center(
                  child: Text(AppTags.someErrorOccurred.tr),
                ),
                onEmpty:  Center(
                  child: Text(AppTags.noProduct.tr),
                ),
                bottomLoader: const ShimmerLoadData(),
                initialLoader: const ShimmerProducts(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile(context)? 2:3,
                  childAspectRatio: 0.68,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, Data product, int index) {
                  return CategoryProductCard(
                    dataModel: product,
                    index: index,
                  );
                },
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                shrinkWrap: true,
              ),
            ),
          ],
        ));
  }
}
