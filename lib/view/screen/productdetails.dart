import 'package:endyear_2025_gr01_mobileapp/controller/productdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  bool isBase64(String str) {
    try {
      String base64Str = str;
      if (str.startsWith('data:image')) {
        base64Str = str.substring(str.indexOf(',') + 1);
      }
      final decoded = base64Decode(base64Str);
      return decoded.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Helper method to format price
  String formatPrice(dynamic price) {
    if (price == null || price.toString().isEmpty) return 'Non disponible';
    try {
      final numPrice = double.parse(price.toString());
      return '${numPrice.toStringAsFixed(2)} €';
    } catch (e) {
      return price.toString();
    }
  }

  // Helper method to format date
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Non disponible';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMMM yyyy', 'fr_FR').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  // Helper method to get availability status
  String getAvailabilityStatus(dynamic count) {
    if (count == null) return 'Non disponible';
    final stockCount = int.tryParse(count.toString()) ?? 0;
    if (stockCount > 10) return 'En stock';
    if (stockCount > 0) return 'Stock limité';
    return 'Rupture de stock';
  }

  Color getAvailabilityColor(dynamic count) {
    if (count == null) return Colors.grey;
    final stockCount = int.tryParse(count.toString()) ?? 0;
    if (stockCount > 10) return Colors.green;
    if (stockCount > 0) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp controller = Get.put(
      ProductDetailsControllerImp(),
    );

    return Scaffold(
      body: GetBuilder<ProductDetailsControllerImp>(
        builder:
            (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: CustomScrollView(
                slivers: [
                  // Modern SliverAppBar with product image
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        controller.productModel.productName ?? 'Produit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Product image or gradient background
                          if (controller.productModel.productImage != null &&
                              controller.productModel.productImage!.isNotEmpty)
                            isBase64(controller.productModel.productImage!)
                                ? Image.memory(
                                  base64Decode(
                                    controller.productModel.productImage!
                                            .startsWith('data:image')
                                        ? controller.productModel.productImage!
                                            .substring(
                                              controller
                                                      .productModel
                                                      .productImage!
                                                      .indexOf(',') +
                                                  1,
                                            )
                                        : controller.productModel.productImage!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                                : Image.network(
                                  controller.productModel.productImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColor.primaryColor,
                                              AppColor.primaryColor.withOpacity(
                                                0.7,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                )
                          else
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColor.primaryColor,
                                    AppColor.primaryColor.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          // Product icon
                          Positioned(
                            bottom: 60,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status and summary bar
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatusItem(
                                  icon:
                                      controller.productModel.productActive ==
                                              true
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                  label: 'Statut',
                                  value:
                                      controller.productModel.productActive ==
                                              true
                                          ? 'Actif'
                                          : 'Inactif',
                                  color:
                                      controller.productModel.productActive ==
                                              true
                                          ? Colors.green
                                          : Colors.red,
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                _buildStatusItem(
                                  icon: Icons.inventory,
                                  label: 'Stock',
                                  value: getAvailabilityStatus(
                                    controller.productModel.productCount,
                                  ),
                                  color: getAvailabilityColor(
                                    controller.productModel.productCount,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                _buildStatusItem(
                                  icon: Icons.euro,
                                  label: 'Prix',
                                  value: formatPrice(
                                    controller.productModel.productPrice,
                                  ),
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // Product Description
                          if (controller.productModel.productDesc != null &&
                              controller.productModel.productDesc!.isNotEmpty)
                            _buildSectionCard(
                              title: 'Description',
                              icon: Icons.description,
                              child: Html(
                                data: controller.productModel.productDesc!,
                                style: {
                                  "body": Style(
                                    margin: Margins.zero,
                                    padding: HtmlPaddings.zero,
                                  ),
                                },
                              ),
                            ),

                          SizedBox(height: 16),

                          // Product Information
                          _buildSectionTitle('Informations produit'),
                          _buildInfoCard([
                            _buildDetailItem(
                              Icons.tag,
                              'Référence',
                              controller.productModel.reference ??
                                  'Non disponible',
                              isAvailable:
                                  controller.productModel.reference != null,
                            ),
                            _buildDetailItem(
                              Icons.euro,
                              'Prix de vente',
                              formatPrice(controller.productModel.productPrice),
                              isAvailable:
                                  controller.productModel.productPrice != null,
                            ),
                            _buildDetailItem(
                              Icons.euro_symbol,
                              'Prix de gros',
                              formatPrice(
                                controller.productModel.wholesalePrice,
                              ),
                              isAvailable:
                                  controller.productModel.wholesalePrice !=
                                  null,
                            ),
                            _buildDetailItem(
                              Icons.scale,
                              'Poids',
                              controller.productModel.weight != null
                                  ? '${controller.productModel.weight} kg'
                                  : 'Non disponible',
                              isAvailable:
                                  controller.productModel.weight != null,
                            ),
                          ]),

                          SizedBox(height: 16),

                          // Stock Information
                          _buildSectionTitle('Informations stock'),
                          _buildInfoCard([
                            _buildDetailItem(
                              Icons.inventory_2,
                              'Quantité en stock',
                              controller.productModel.productCount
                                      ?.toString() ??
                                  'Non disponible',
                              isAvailable:
                                  controller.productModel.productCount != null,
                            ),
                            _buildDetailItem(
                              Icons.info_outline,
                              'État',
                              controller.productModel.condition ??
                                  'Non disponible',
                              isAvailable:
                                  controller.productModel.condition != null,
                            ),
                          ]),

                          SizedBox(height: 16),

                          // Category Information
                          _buildSectionTitle('Catégorie'),
                          _buildInfoCard([
                            _buildDetailItem(
                              Icons.category,
                              'Nom de la catégorie',
                              controller.productModel.categoriesName ??
                                  'Non disponible',
                              isAvailable:
                                  controller.productModel.categoriesName !=
                                  null,
                            ),
                            _buildDetailItem(
                              Icons.date_range,
                              'Date de création',
                              formatDate(controller.productModel.productDate),
                              isAvailable:
                                  controller.productModel.productDate != null,
                            ),
                          ]),

                          // Category Image
                          if (controller.productModel.categoriesImage != null &&
                              controller
                                  .productModel
                                  .categoriesImage!
                                  .isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: AppColor.primaryColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Image de la catégorie',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      controller.productModel.categoriesImage!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(height: 16),

                          // Additional Information
                          _buildSectionTitle('Informations supplémentaires'),
                          _buildInfoCard([
                            _buildDetailItem(
                              Icons.business,
                              'Fabricant',
                              controller.productModel.manufacturer ??
                                  'Non disponible',
                              isAvailable:
                                  controller.productModel.manufacturer != null,
                            ),
                            _buildDetailItem(
                              Icons.local_shipping,
                              'Frais de port supplémentaires',
                              formatPrice(
                                controller.productModel.additionalShippingCost,
                              ),
                              isAvailable:
                                  controller
                                      .productModel
                                      .additionalShippingCost !=
                                  null,
                            ),
                            if (controller.productModel.unity != null &&
                                controller.productModel.unity!.isNotEmpty)
                              _buildDetailItem(
                                Icons.straighten,
                                'Unité',
                                controller.productModel.unity!,
                                isAvailable: true,
                              ),
                          ]),

                          // Short Description
                          if (controller.productModel.descriptionShort !=
                                  null &&
                              controller
                                  .productModel
                                  .descriptionShort!
                                  .isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: _buildSectionCard(
                                title: 'Description courte',
                                icon: Icons.short_text,
                                child: Html(
                                  data:
                                      controller.productModel.descriptionShort!,
                                  style: {
                                    "body": Style(
                                      margin: Margins.zero,
                                      padding: HtmlPaddings.zero,
                                    ),
                                  },
                                ),
                              ),
                            ),

                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  // Helper methods for UI components
  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primaryColor),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value, {
    bool isAvailable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isAvailable
                      ? AppColor.primaryColor.withOpacity(0.1)
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isAvailable ? AppColor.primaryColor : Colors.grey,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isAvailable ? FontWeight.w500 : FontWeight.normal,
                    color: isAvailable ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
