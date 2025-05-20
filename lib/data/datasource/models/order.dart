import 'package:xml/xml.dart' as xml;

class OrderModel {
  final int id;
  final int idAddressDelivery;
  final int idAddressInvoice;
  final int idCart;
  final int idCurrency;
  final int idLang;
  final int idCustomer;
  final int idCarrier;
  final int currentState;
  final String module;
  final String payment;
  final String dateAdd;
  final String reference;
  final double? totalPaid;
  final double? totalPaidTaxIncl;
  final double? totalPaidTaxExcl;
  final String? customerName;
  final List<OrderRow> orderRows;

  OrderModel({
    required this.id,
    required this.idAddressDelivery,
    required this.idAddressInvoice,
    required this.idCart,
    required this.idCurrency,
    required this.idLang,
    required this.idCustomer,
    required this.idCarrier,
    required this.currentState,
    required this.module,
    required this.payment,
    required this.dateAdd,
    required this.reference,
    required this.orderRows,
    this.totalPaid,
    this.totalPaidTaxIncl,
    this.totalPaidTaxExcl,
    this.customerName,
  });

  factory OrderModel.fromXml(xml.XmlElement element) {
    // Helper to parse int from element text
    int parseInt(String? text) => text == null ? 0 : int.tryParse(text) ?? 0;

    // Helper to parse double from element text
    double parseDouble(String? text) =>
        text == null ? 0.0 : double.tryParse(text) ?? 0.0;

    // Parse order rows
    List<OrderRow> parseOrderRows(xml.XmlElement orderElement) {
      final rows = <OrderRow>[];
      final orderRowsElement = orderElement
          .getElement('associations')
          ?.getElement('order_rows');
      if (orderRowsElement != null) {
        for (var rowElement in orderRowsElement.findElements('order_row')) {
          rows.add(OrderRow.fromXml(rowElement));
        }
      }
      return rows;
    }

    return OrderModel(
      id: parseInt(element.getElement('id')?.text),
      idAddressDelivery: parseInt(
        element.getElement('id_address_delivery')?.text,
      ),
      idAddressInvoice: parseInt(
        element.getElement('id_address_invoice')?.text,
      ),
      idCart: parseInt(element.getElement('id_cart')?.text),
      idCurrency: parseInt(element.getElement('id_currency')?.text),
      idLang: parseInt(element.getElement('id_lang')?.text),
      idCustomer: parseInt(element.getElement('id_customer')?.text),
      idCarrier: parseInt(element.getElement('id_carrier')?.text),
      currentState: parseInt(element.getElement('current_state')?.text),
      module: element.getElement('module')?.text ?? '',
      payment: element.getElement('payment')?.text ?? '',
      dateAdd: element.getElement('date_add')?.text ?? '',
      reference: element.getElement('reference')?.text ?? '',
      totalPaid: parseDouble(element.getElement('total_paid')?.text),
      totalPaidTaxIncl: parseDouble(
        element.getElement('total_paid_tax_incl')?.text,
      ),
      totalPaidTaxExcl: parseDouble(
        element.getElement('total_paid_tax_excl')?.text,
      ),
      customerName: null, // Will be populated later
      orderRows: parseOrderRows(element),
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderRow> parseOrderRows(List<dynamic>? rowsJson) {
      if (rowsJson == null) return [];
      return rowsJson.map((rowJson) => OrderRow.fromJson(rowJson)).toList();
    }

    return OrderModel(
      id: json['id'] ?? 0,
      idAddressDelivery: json['id_address_delivery'] ?? 0,
      idAddressInvoice: json['id_address_invoice'] ?? 0,
      idCart: json['id_cart'] ?? 0,
      idCurrency: json['id_currency'] ?? 0,
      idLang: json['id_lang'] ?? 0,
      idCustomer: json['id_customer'] ?? 0,
      idCarrier: json['id_carrier'] ?? 0,
      currentState: json['current_state'] ?? 0,
      module: json['module'] ?? '',
      payment: json['payment'] ?? '',
      dateAdd: json['date_add'] ?? '',
      reference: json['reference'] ?? '',
      totalPaid: (json['total_paid'] as num?)?.toDouble(),
      totalPaidTaxIncl: (json['total_paid_tax_incl'] as num?)?.toDouble(),
      totalPaidTaxExcl: (json['total_paid_tax_excl'] as num?)?.toDouble(),
      customerName: json['customerName'],
      orderRows: parseOrderRows(json['associations']?['order_rows']),
    );
  }
}

class OrderRow {
  final int id;
  final int productId;
  final int productAttributeId;
  final int productQuantity;
  final String productName;
  final String productReference;
  final double productPrice;

  OrderRow({
    required this.id,
    required this.productId,
    required this.productAttributeId,
    required this.productQuantity,
    required this.productName,
    required this.productReference,
    required this.productPrice,
  });

  factory OrderRow.fromXml(xml.XmlElement element) {
    int parseInt(String? text) => text == null ? 0 : int.tryParse(text) ?? 0;
    double parseDouble(String? text) =>
        text == null ? 0.0 : double.tryParse(text) ?? 0.0;

    return OrderRow(
      id: parseInt(element.getElement('id')?.text),
      productId: parseInt(element.getElement('product_id')?.text),
      productAttributeId: parseInt(
        element.getElement('product_attribute_id')?.text,
      ),
      productQuantity: parseInt(element.getElement('product_quantity')?.text),
      productName: element.getElement('product_name')?.text ?? '',
      productReference: element.getElement('product_reference')?.text ?? '',
      productPrice: parseDouble(element.getElement('product_price')?.text),
    );
  }

  factory OrderRow.fromJson(Map<String, dynamic> json) {
    return OrderRow(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productAttributeId: json['product_attribute_id'] ?? 0,
      productQuantity: json['product_quantity'] ?? 0,
      productName: json['product_name'] ?? '',
      productReference: json['product_reference'] ?? '',
      productPrice: (json['product_price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
