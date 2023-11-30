import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../models/product_by_category_model.dart';
import '../../../utils/app_theme_data.dart';
import 'package:saudi_adaminnovations/src/utils/responsive.dart';
import '../../../utils/custom_provider.dart';
import '../../../widgets/product_card_widgets/category_product_card.dart';
import '../../../servers/repository.dart';
import '../../../utils/app_tags.dart';
import '../../../widgets/loader/shimmer_load_data.dart';
import '../../../widgets/loader/shimmer_products.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);
  final int? id;
  final String? title;

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  final homeController = Get.put(HomeScreenController());

  int page = 0;
  GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();
  late List<CategoryProductData> data = [];

  Future<List<CategoryProductData>> getData(int offset) async {
    page++;
    return await Repository()
        .getProductByCategoryItem(id: widget.id, page: page,sort: themeProvider.getSortKey());
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
            themeProvider.setSort(AppTags.latestontop);
            themeProvider.setSortKey("latest_on_top");
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.title.toString(),
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
        widget.title.toString(),
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
                  Get.to(() =>  ProductByCategory(id:widget.id,title: widget.title,));


                },
              ),
            ),
          ),
          Container(height: MediaQuery.of(context).size.height,
            child: PaginationView<CategoryProductData>(
              key: key,
              physics: BouncingScrollPhysics(),
              paginationViewType: PaginationViewType.gridView,
              pageFetch: getData,
              pullToRefresh: false,
              onError: (dynamic error) => Center(
                child: Text(AppTags.somethingWentWrong.tr),
              ),
              onEmpty: Center(
                child: Text(AppTags.noProduct.tr),
              ),
              bottomLoader: const ShimmerLoadData(),
              initialLoader: const ShimmerProducts(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 2:3,
                childAspectRatio: 0.68,
                mainAxisSpacing: isMobile(context)? 15:20,
                crossAxisSpacing:  isMobile(context)? 15:20,
              ),
              itemBuilder:
                  (BuildContext context, CategoryProductData product, int index) {
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
      ),
    );
  }
}
