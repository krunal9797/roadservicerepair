class VendorStatusInfo {
  final String vsId;
  final String service;
  final String serviceFor;
  final String name;
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
  final String reason;
  final String status;

  VendorStatusInfo({
    required this.vsId,
    required this.service,
    required this.serviceFor,
    required this.name,
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
    required this.reason,
    required this.status,
  });

  factory VendorStatusInfo.fromJson(Map<String, dynamic> json) {
    return VendorStatusInfo(
      vsId: json['vs_id'],
      service: json['service'],
      serviceFor: json['service_for'],
      name: json['name'],
      unitNumber: json['unit_number'],
      driverNumber: json['driver_number'],
      address: json['address'],
      remark: json['remark'],
      estTime: json['est_time'],
      estPrice: json['est_price'],
      vendorName: json['vendor_name'],
      vendorEmail: json['vendor_email'],
      vendorMobile: json['vendor_mobile'],
      vendorAddress: json['vendor_address'],
      reason: json['reason'],
      status: json['sta_tus'],
    );
  }
}
