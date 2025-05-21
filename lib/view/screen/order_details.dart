import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrdersDetailsController controller = Get.find<OrdersDetailsController>();

  OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Obx(() {
        OrderModel? order = controller.order.value;
        print('OrderDetailsScreen: order.deliveryAddress = ${order?.deliveryAddress}');
        print('OrderDetailsScreen: order.invoiceAddress = ${order?.invoiceAddress}');
        if (order == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reference: ${order.reference}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Customer Name: ${order.customerName}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Status: ${order.currentStateName}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Payment: ${order.payment}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Total Paid (Tax Incl.): ${order.totalPaidTaxIncl.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Order Date: ${order.dateAdd}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Delivery Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('${order.deliveryAddress.address1}', style: TextStyle(fontSize: 16)),
              Text('${order.deliveryAddress.address2}', style: TextStyle(fontSize: 16)),
              Text('${order.deliveryAddress.city}, ${order.deliveryAddress.postcode}', style: TextStyle(fontSize: 16)),
              Text('${order.deliveryAddress.country}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Invoice Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('${order.invoiceAddress.address1}', style: TextStyle(fontSize: 16)),
              Text('${order.invoiceAddress.address2}', style: TextStyle(fontSize: 16)),
              Text('${order.invoiceAddress.city}, ${order.invoiceAddress.postcode}', style: TextStyle(fontSize: 16)),
              Text('${order.invoiceAddress.country}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              if (order.gift)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gift Message:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(order.giftMessage, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
