class StateData {
  int? status;
  List<StateInfo>? info;

  StateData({this.status, this.info});

  StateData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['info'] != null) {
      info = <StateInfo>[];
      json['info'].forEach((v) {
        info!.add(new StateInfo.fromJson(v));
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

class StateInfo {
  String? id;
  String? name;
  String? countryId;

  StateInfo({this.id, this.name, this.countryId});

  StateInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}