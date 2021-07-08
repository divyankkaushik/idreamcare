class AppUser {
  String? uid;
  String? phoneNumber;

  AppUser({
    this.uid,
    this.phoneNumber,
  });

  Map toMap(AppUser user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['phoneNumber'] = user.phoneNumber;
    return data;
  }

  AppUser.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.phoneNumber = mapData['phoneNumber'];
    
  }
}
