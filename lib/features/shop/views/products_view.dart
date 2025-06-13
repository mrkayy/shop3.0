import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/features/shop/models/product_category_model.dart';
import 'package:shop3/features/shop/models/products_model.dart';
import 'package:shop3/features/shop/notifiers/get_category_provider.dart';
import 'package:shop3/features/shop/notifiers/get_products_provider.dart';
import 'package:shop3/features/shop/notifiers/product_home_notifier.dart';
import 'package:shop3/routes/app_router.dart';
import 'package:shop3/theme.dart';

final Color aColor = Colors.grey[600]!;

class ProductsHomeView extends ConsumerStatefulWidget {
  const ProductsHomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsHomeViewState();
}

class _ProductsHomeViewState extends ConsumerState<ProductsHomeView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // ref.watch(fetchCategoriesProvider);
      // ref.watch(fetchProductsFromCategoriesProvider(1));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateRef = ref.watch(productsHomeViewModelNotifierProvider);
    final readRef = ref.read(productsHomeViewModelNotifierProvider.notifier);
    final categoryRef = ref.watch(fetchCategoriesProvider);
    final productsRef = ref.watch(
      fetchProductsFromCategoriesProvider(stateRef.category?.id ?? 1),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.location_on_outlined, color: aColor),
        title: Text(
          'Shop3.0',
          style: TextStyle(color: aColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_outlined, color: aColor),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  enabled: false,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ),
              24.verticalSpace,
              // Banner
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: aColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              24.verticalSpace,
              // Categories
              _buildSectionHeader('Category'),
              switch (categoryRef) {
                AsyncData(:final value) => SizedBox(
                  height: 85,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.length,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    itemBuilder:
                        (context, index) => _buildCategoryItem(
                          value[index].image,
                          value[index].name,
                          value[index],
                        ),
                  ),
                ),
                AsyncError() => const Text(
                  'Oops, something unexpected happened',
                ),
                _ => Center(
                  child: Transform.scale(
                    scale: 0.85,
                    child: CupertinoActivityIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              },
              24.verticalSpace,
              // Flash Sale
              _buildSectionHeader('Flash Sale'),
              Row(
                children: [
                  _buildTimerBox('02', 'Hours'),
                  const Text(' : ', style: TextStyle(fontSize: 24)),
                  _buildTimerBox('12', 'Minutes'),
                  const Text(' : ', style: TextStyle(fontSize: 24)),
                  _buildTimerBox('56', 'Seconds'),
                ],
              ),
              24.verticalSpace,
              _buildSectionHeader(stateRef.category?.name ?? 'Products'),
              // Product Grid
              switch (productsRef) {
                AsyncData(:final value) => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder:
                      (context, index) => _buildProductCard(value, index),
                ),
                AsyncError() => const Text(
                  'Oops, something unexpected happened',
                ),
                _ => Center(
                  child: Transform.scale(
                    scale: 0.85,
                    child: CupertinoActivityIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textColor100,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String url, String label, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        ref
            .read(productsHomeViewModelNotifierProvider.notifier)
            .selectCategory(category);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(url),
              backgroundColor: AppTheme.secondaryColor2,
            ),
            8.verticalSpace,
            Text(
              label,
              style: TextStyle(color: AppTheme.textColor100, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerBox(String time, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 20,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppTheme.textColor100),
        ),
      ],
    );
  }

  Widget _buildProductCard(List<ProductModel> products, int index) {
    return GestureDetector(
      onTap: () {
        context.push(
          Uri(
            path: productsDetailsView,
            queryParameters: {'id': '${products[index].id}'},
          ).toString(),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor2,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(products[index].images.first),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            products[index].title,
            style: TextStyle(fontWeight: FontWeight.bold, color: aColor),
          ),
          Text(
            '\$${products[index].price}',
            style: TextStyle(color: AppTheme.secondaryColor),
          ),
        ],
      ),
    );
  }
}
