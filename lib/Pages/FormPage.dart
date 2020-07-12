import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:kamachi_app_admin/Services/authentication.dart';
import 'package:kamachi_app_admin/model/report.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.auth, this.userId, this.logoutCallback, this.report})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final Report report;
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController dateofcompcontroller;
  TextEditingController comptitilecontroller;
  TextEditingController submitcontroller;
  TextEditingController contactcontroller;
  TextEditingController actioncontroller;
  TextEditingController stdatecontroller;
  TextEditingController remarkcontroller;
  TextEditingController changecontroller;
  DateTime date;
  DateTime _date;
  final dbRef = FirebaseDatabase.instance;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    _date = DateTime.now();

    dateofcompcontroller = TextEditingController(text: widget.report.dateof);
    comptitilecontroller =
        TextEditingController(text: widget.report.complainttitle);
    submitcontroller = TextEditingController(text: widget.report.submittedby);
    contactcontroller = TextEditingController(text: widget.report.contact);
    actioncontroller = TextEditingController(text: widget.report.actiontaken);
    stdatecontroller = TextEditingController(text: widget.report.statusdate);
    remarkcontroller = TextEditingController(text: widget.report.remarks);
    changecontroller = TextEditingController(text: widget.report.changes);
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) async {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) async {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registered');
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNEL NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, "Report Added", "Your Report Added Successfully", platform);
  }

  update(String token) {
    print('User Token: $token');
    if (_formKey.currentState.validate()) {
      dbRef.reference().child("reports/").push().set({
        "date": dateofcompcontroller.text.toString(),
        "complaint type": dropDownValue.toString(),
        "priority": dropDownValue1.toString(),
        "complaint title": comptitilecontroller.text.toString(),
        "submitted by": submitcontroller.text.toString(),
        "contact": contactcontroller.text.toString(),
        "division": dropDownValue2.toString(),
        "department": dropDownValue3.toString(),
        "assigned to": dropDownValue4.toString(),
        "action taken": actioncontroller.text.toString(),
        "status": dropDownValue5.toString(),
        "status date": stdatecontroller.text.toString(),
        "remarks": remarkcontroller.text.toString(),
        "changes if any": changecontroller.text.toString(),
        "userId": widget.userId,
        "token": token
      }).then((_) {
        Navigator.pop(context);
      });
    }
  }

  pickedDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1980),
        lastDate: DateTime(2100));
    String formatdate = new DateFormat.yMMMMEEEEd().format(picked);
    dateofcompcontroller.text = formatdate.toString();
    if (picked != null) {
      setState(() {
        date = picked;
      });
    }
  }

  _pickedDate1() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1980),
        lastDate: DateTime(2100));
    String _formatdate = new DateFormat.yMMMMEEEEd().format(picked);
    stdatecontroller.text = _formatdate.toString();
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  final listofcomplaint = [
    "ERP",
    "Email",
    "Software Installation",
    "Hardware Installation",
    "Monitor",
    "Mouse",
    "Keyboard",
    "Printer",
    "Scanner",
    "Processor",
    "Networking",
    "Remote Access",
    "Internet",
    "UPS",
    "Genset",
    "Others"
  ];
  final listofnames = [
    'Suresh Pillai',
    'G N Jha',
    'Deepak',
    'Satish',
    'Suseedran',
    'Bronson',
    'Surendran'
  ];
  final listofDepartements = [
    "Account",
    "Admin",
    "Automation",
    "Automobile",
    "Boiler",
    "Canteen",
    "CCM",
    "Civil",
    "Coal and Steel",
    "Dispatch",
    "Electrical",
    "Fabric",
    "Garden",
    "General",
    "General IT",
    "General WS",
    "House Keeping",
    "HR and Admin",
    "HR Department",
    "Instrumentation",
    "Instrumentation and Technology",
    "KLR",
    "Lab",
    "Mechanical",
    "Machine Shop",
    "Mechanical(AHS)",
    "Mechanical (CHS)",
    "NCP DM Plant",
    "NCP Electrical",
    "NCP Instrumentation",
    "NCP Mechanical",
    "NCP Shift Incharge",
    "NCP Turbine",
    "NCP Ash Handling",
    "NCP Boiler Operation",
    "NCP DM Plant",
    "NCP Operation",
    "O & M",
    "O2",
    "Operation",
    "PP Mechanical",
    "PP Ash Handling",
    "PP Boiler",
    "PP DCS",
    "PP E & I",
    "PP Electrical",
    "PP Helper",
    "PP Instrumentation",
    "PP Operation",
    "PP Shift Incharge",
    "PP Turbine",
    "Process",
    "Production",
    "Pump House Mech",
    "Purchase",
    "QC",
    "QC/QA",
    "RMD",
    "Safety and Security",
    "Scrap",
    "SID Automobile",
    "SID Electrical",
    "SID IT",
    "SID Lab",
    "SID Mechanical",
    "SID Operation",
    "SID Process",
    "SID Weigh Bridge",
    "SID Accounts",
    "SID Automobile",
    "SID Canteen",
    "SID Head Office",
    "SID House Keeping",
    "SID HR and Admin",
    "SID HR Admin & Safety",
    "SID Instrumentation",
    "SID Lab",
    "SID Purchase",
    "SID S&S",
    "SID Stores",
    "SID W/B",
    "Slag",
    "SMD",
    "Store",
    "T.O",
    "Weigh Bridge",
    "W/B",
    "WTP",
    "Yard",
    "SID Security",
    "CCTV",
    "Direct Tech",
    "Bright Tech"
  ];
  final listofDivision = ['SIDN', 'NCDN', "SMDN", 'RMDN', 'CPDN'];
  final listofStatus = [
    "Active",
    "Inactive",
    "Open",
    "Reopen",
    "Partially Open",
    "Under Observation",
    "Rejected",
    "Closed"
  ];
  final listofPriority = ["High", "Medium", "Low"];
  String dropDownValue = 'ERP';
  String dropDownValue1 = 'Low';
  String dropDownValue2 = 'SIDN';
  String dropDownValue3 = 'Account';
  String dropDownValue4 = 'Suresh Pillai';
  String dropDownValue5 = 'Active';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IT Incident Report'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListTile(
                      title: TextFormField(
                        controller: dateofcompcontroller,
                        decoration: InputDecoration(
                            labelText: 'Date of Complaint*',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      onTap: pickedDate,
                      leading: Icon(Icons.calendar_today),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Complaint Type",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofcomplaint.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue1,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Priority",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofPriority.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue1 = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: comptitilecontroller,
                      decoration: InputDecoration(
                          labelText: 'Complaint Title*',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: submitcontroller,
                      decoration: InputDecoration(
                          labelText: 'Submitted By*',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: contactcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Contact',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue2,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Division",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofDivision.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue2 = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue3,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Department",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofDepartements.map((value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue3 = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue4,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Assigned To",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofnames.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        dropDownValue4 = newValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: actioncontroller,
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: 'Action Taken',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: DropdownButtonFormField(
                      value: dropDownValue5,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Status",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listofStatus.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        dropDownValue5 = newValue;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select a Status';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: ListTile(
                      title: TextFormField(
                        controller: stdatecontroller,
                        decoration: InputDecoration(
                          labelText: 'Status Date',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      onTap: _pickedDate1,
                      leading: Icon(Icons.calendar_today),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: remarkcontroller,
                      decoration: InputDecoration(
                          labelText: 'Remarks',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: changecontroller,
                      decoration: InputDecoration(
                          labelText: 'Changes if Any',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          firebaseMessaging.getToken().then((token) {
                            update(token);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
