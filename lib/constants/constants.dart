import 'package:intl/intl.dart';
class GlobalConstants{

  static final DateFormat dateFormatViewed = DateFormat("EEEE dd-MM-yyyy");
  static final DateFormat dateFormatServer = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static final DateFormat dateFormatViewedDaysAndHours = DateFormat("EEEE dd-MM-yyyy hh:mm aa");

  // static final List<dynamic> accountsTypesList = [
  //   {
  //     "value": "USB Exception",
  //     "display": "USB Exception",
  //   },
  //   {
  //     "value": "VPN Account",
  //     "display": "VPN Account",
  //   },
  //   {
  //     "value": "IP Phone",
  //     "display": "IP Phone",
  //   },
  //   {
  //     "value": "Local Admin",
  //     "display": "Local Admin",
  //   },
  //   {
  //     "value": "Color Printing",
  //     "display": "Color Printing",
  //   },
  // ];

  static final List<String> daysInWeek=['Mon', 'Tue','Wed','Thu','Fri','Sat','Sun',];

  static final List<String> accountsTypesList = [

     "USB Exception",

    "VPN Account",
"IP Phone",
"Local Admin",
"Color Printing",];


  static final  List<String> labsType = [
    "ELmokhtaber",
    "ELBORG",
  ];
  static final List<String> serviceTypeElBorg = [
    "Lab",
    "Scan",
  ];
  static final List<String> serviceTypeElMokhtabr = [
    "Lab",
  ];
  static final List<String> embassyLetterPurposeList = [
    "Tourism",
    "Business",
  ];

  static final List<String> embassyLetterList = [
    "Afghanistan","Albania","Algeria","Angola","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahrain","Bangladesh","Belarus"
        ,"Belgium","Bolivia","Bosnia and Herzegovina","Brazil","Brunei","Bulgaria","Burkina Faso","Burundi","Cameroon",
    "Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo (Democratic Republic)","Congo (Republic)",
    "Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Equatorial Guinea",
    "Eritrea","Estonia","Ethiopia", "Finland","France","Gabon","Georgia","Germany","Ghana","Greece","Guatemala","Guinea","Holy See (Vatican City)"
    ,"Hungary","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Japan","Jordan","Kazakhstan", "Kenya","Korea (Democratic Republic)"
    ,"Korea (Republic)","Kuwait","Latvia","Lebanon","Liberia","Libya","Lithuania", "Macedonia","Malawi","Malaysia", "Mali","Malta"
    ,"Mauritania","Mauritius","Mexico","Mongolia","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua"
  ,"Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania", "Russia","Rwanda",
    "Saudi Arabia","Senegal","Serbia","Singapore","Slovakia","Slovenia","Somalia","South Africa","South Sudan","Spain"
  ,"Sri Lanka","Sudan","Sweden","Switzerland","Syria","Tajikistan","Tanzania","Thailand","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates"
  ,"United Kingdom","United States","Uruguay","Uzbekistan","Venezuela","Vietnam","Yemen", "Zambia","Zimbabwe"
  ];

  static final List<Map<String, String>> embassyLetterListNameId = [
  ];
}