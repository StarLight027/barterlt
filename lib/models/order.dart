class Order {
  String? _orderId;
  String? _buyerId;
  String? _sellerId;
  String? _orderStatus;
  
  Order(
      {String? orderId,
      String? buyerId,
      String? sellerId,
      String? orderStatus,
      }) {

    if (orderId != null) {
      _orderId = orderId;
    }
    if (buyerId != null) {
      _buyerId = buyerId;
    }
    if (sellerId != null) {
      _sellerId = sellerId;
    }
    if (orderStatus != null) {
      _orderStatus = orderStatus;
    }
  }

  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  String? get buyerId => _buyerId;
  set buyerId(String? buyerId) => _buyerId = buyerId;
  String? get sellerId => _sellerId;
  set sellerId(String? sellerId) => _sellerId = sellerId;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  
  Order.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _buyerId = json['buyer_id'];
    _sellerId = json['seller_id'];
    _orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = _orderId;
    data['buyer_id'] = _buyerId;
    data['seller_id'] = _sellerId;
    data['order_status'] = _orderStatus;
    return data;
  }
}