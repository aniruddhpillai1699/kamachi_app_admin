import 'package:firebase_database/firebase_database.dart';

class Report {
  String key;
  String dateof;
  String complainttype;
  String priority;
  String complainttitle;
  String submittedby;
  String contact;
  String division;
  String department;
  String assignedto;
  String actiontaken;
  String status;
  String statusdate;
  String remarks;
  String changes;
  String userId;
  String token;

  Report(
      this.dateof,
      this.complainttype,
      this.priority,
      this.complainttitle,
      this.submittedby,
      this.contact,
      this.division,
      this.department,
      this.assignedto,
      this.actiontaken,
      this.status,
      this.statusdate,
      this.remarks,
      this.changes,
      this.userId,
      this.token);

  Report.map(dynamic obj) {
    this.dateof = obj["date"];
    this.complainttype = obj["complaint type"];
    this.priority = obj["priority"];
    this.complainttitle = obj["complaint title"];
    this.submittedby = obj["submitted by"];
    this.contact = obj["contact"];
    this.division = obj["division"];
    this.department = obj["department"];
    this.assignedto = obj["assigned to"];
    this.actiontaken = obj["action taken"];
    this.status = obj["status"];
    this.statusdate = obj["status date"];
    this.remarks = obj["remarks"];
    this.changes = obj["changes if any"];
    this.userId = obj["userId"];
    this.token = obj["token"];
  }

  // get _key => key;
  //get _date => date;
  //get _complaint => complaint;
  // String get _department => department;
  //get _username => username;
  //String get _natureofcomplaints => natureofcomplaints;
  //get _attendedby => attendedby;
  //get _duration => duration;
  //get _actiontaken => actiontaken;
  //String get _status => status;
  // get _statusdate => statusdate;
  //get _remarks => remarks;
  //get _changes => changes;

  Report.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    dateof = snapshot.value["date"];
    complainttype = snapshot.value["complaint type"];
    priority = snapshot.value["priority"];
    complainttitle = snapshot.value["complaint title"];
    submittedby = snapshot.value["submitted by"];
    contact = snapshot.value["contact"];
    division = snapshot.value["division"];
    department = snapshot.value["department"];
    assignedto = snapshot.value["assigned to"];
    actiontaken = snapshot.value["action taken"];
    status = snapshot.value["status"];
    statusdate = snapshot.value["status date"];
    remarks = snapshot.value["remarks"];
    changes = snapshot.value["changes if any"];
    userId = snapshot.value["userId"];
    token = snapshot.value["token"];
  }

  toJson() {
    return {
      "date": dateof,
      "complaint type": complainttype,
      "priority": priority,
      "complaint title": complainttitle,
      "submitted by": submittedby,
      "contact": contact,
      "division": division,
      "department": department,
      "assigned to": assignedto,
      "action taken": actiontaken,
      "status": status,
      "status date": statusdate,
      "remarks": remarks,
      "changes if any": changes,
      "userId": userId,
      "token": token
    };
  }
}
