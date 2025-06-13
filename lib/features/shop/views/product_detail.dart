import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/core/utils/constants.dart';
import 'package:shop3/theme.dart';

final Color aColor = Colors.grey[600]!;

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key, this.pid});

  final String? pid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.person_outline, color: AppTheme.textColor200),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.share, color: aColor),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Placeholder
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: aColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              24.verticalSpace,
              // Product Info
              Text(
                'Tech Backpack',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: aColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This backpack is designed for tech enthusiasts, featuring multiple compartments for laptops, tablets, and other gadgets. It\'s made from durable, water-resistant material to protect your devices.',
                style: TextStyle(fontSize: 14, color: aColor, height: 1.5),
              ),
              24.verticalSpace,
              // Specifications
              Text(
                'Specifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: aColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSpecItem('Material', 'Nylon'),
                  _buildSpecItem('Capacity', '25L'),
                  _buildSpecItem('Dimensions', '18x12x8 inches'),
                  _buildSpecItem('Weight', '1.5 lbs'),
                ],
              ),
              24.verticalSpace,
              // Reviews Section
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: aColor,
                ),
              ),
              const SizedBox(height: 16),
              _buildReviewSummary(),
              24.verticalSpace,
              // Individual Reviews
              _buildReviewCard('Liam Carter', '2 weeks ago', 5),
              _buildReviewCard('Sophia Bennett', '1 month ago', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: aColor)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: aColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSummary() {
    return Row(
      children: [
        // Average Rating
        Column(
          children: [
            Text(
              '4.5',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: aColor,
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < 4 ? Icons.star : Icons.star_half,
                  color: aColor,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text('120 reviews', style: TextStyle(color: aColor)),
          ],
        ),
        const SizedBox(width: 24),
        // Rating Bars
        Expanded(
          child: Column(
            children: [
              _buildRatingBar('5', 0.40),
              _buildRatingBar('4', 0.30),
              _buildRatingBar('3', 0.15),
              _buildRatingBar('2', 0.10),
              _buildRatingBar('1', 0.05),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String label, double value) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: aColor)),
        const SizedBox(width: 4),
        Icon(Icons.star, size: 12, color: aColor),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(aColor),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(String name, String time, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: aColor,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: aColor,
                    ),
                  ),
                  Text(time, style: TextStyle(fontSize: 12, color: aColor)),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: aColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This backpack is amazing! It fits all my tech gear perfectly and feels very comfortable even when fully loaded.',
            style: TextStyle(color: aColor),
          ),
        ],
      ),
    );
  }
}
