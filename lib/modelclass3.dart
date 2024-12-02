class Pproduct {
  int? id;
  String? name;
  String? address;
  String? zip;
  String? country;
  int? employeeCount;
  String? industry;
  int? marketCap;
  String? domain;
  String? logo;
  String? ceoName;

  Pproduct(
      {this.id,
      this.name,
      this.address,
      this.zip,
      this.country,
      this.employeeCount,
      this.industry,
      this.marketCap,
      this.domain,
      this.logo,
      this.ceoName});

  Pproduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    zip = json['zip'];
    country = json['country'];
    employeeCount = json['employeeCount'];
    industry = json['industry'];
    marketCap = json['marketCap'];
    domain = json['domain'];
    logo = json['logo'];
    ceoName = json['ceoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['employeeCount'] = this.employeeCount;
    data['industry'] = this.industry;
    data['marketCap'] = this.marketCap;
    data['domain'] = this.domain;
    data['logo'] = this.logo;
    data['ceoName'] = this.ceoName;
    return data;
  }
}
