class VendorEditStatusInfo {
  final String id;
  final String service;
  final String serviceFor;
  final String name;
  final String cust_email;
  final String unitNumber;
  final String driverNumber;
  final String address;
  final String remark;
  final String estTime;
  final String estPrice;
  final String vendorName;
  final String vendorEmail;
  final String vendorMobile;
  final String vendorAddress;
  final String rid;
  final String rname;
  final String image;
  final String reason;
  final String status;

  VendorEditStatusInfo({
    required this.id,
    required this.service,
    required this.serviceFor,
    required this.name,
    required this.cust_email,
    required this.unitNumber,
    required this.driverNumber,
    required this.address,
    required this.remark,
    required this.estTime,
    required this.estPrice,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorMobile,
    required this.vendorAddress,
    required this.rid,
    required this.rname,
    required this.image,
    required this.reason,
    required this.status,
  });

  factory VendorEditStatusInfo.fromJson(Map<String, dynamic> json) {
    return VendorEditStatusInfo(
      id: json['id'] ?? '',
      service: json['service'] ?? '',
      serviceFor: json['service_for'] ?? '',
      name: json['name'] ?? '',
      cust_email: json['cust_email'] ?? '',
      unitNumber: json['unit_number'] ?? '',
      driverNumber: json['driver_number'] ?? '',
      address: json['address'] ?? '',
      remark: json['remark'] ?? '',
      estTime: json['est_time'] ?? '',
      estPrice: json['est_price'] ?? '',
      vendorName: json['vendor_name'] ?? '',
      vendorEmail: json['vendor_email'] ?? '',
      vendorMobile: json['vendor_mobile'] ?? '',
      vendorAddress: json['vendor_address'] ?? '',
      rid: json['rid'] ?? '',
      rname: json['rname'] ?? '',
      image: json['image'] ?? '',
      reason: json['reason']??'',
      status: json['sta_tus']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service': service,
      'service_for': serviceFor,
      'name': name,
      'cust_email':cust_email,
      'unit_number': unitNumber,
      'driver_number': driverNumber,
      'address': address,
      'remark': remark,
      'est_time': estTime,
      'est_price': estPrice,
      'vendor_name': vendorName,
      'vendor_email': vendorEmail,
      'vendor_mobile': vendorMobile,
      'vendor_address': vendorAddress,
      'rid': rid,
      'rname': rname,
      'image': image,
      'reason':reason,
      'sta_tus':status,
    };
  }
}
