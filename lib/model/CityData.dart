class CityData {
  int? status;
  List<CityInfo>? info;

  CityData({this.status, this.info});

  CityData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['info'] != null) {
      info = <CityInfo>[];
      json['info'].forEach((v) {
        info!.add(new CityInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityInfo {
  String? id;
  String? name;
  String? stateId;

  CityInfo({this.id, this.name, this.stateId});

  CityInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    return data;
  }
}