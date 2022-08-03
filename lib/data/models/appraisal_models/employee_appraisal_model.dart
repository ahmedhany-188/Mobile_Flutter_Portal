
class EmployeeAppraisalModel{

  int ?code,id,appID,status;
  bool ?error;

  double ?companyScore,departmentScore,competencescore,individualScore,overallscore;
  String ?trainingneeds,acknowledge1,acknowledge2,inUser,inDate,message,hrcode;


  EmployeeAppraisalModel(
      this.code,
      this.id,
      this.appID,
      this.status,
      this.error,
      this.companyScore,
      this.departmentScore,
      this.competencescore,
      this.individualScore,
      this.overallscore,
      this.trainingneeds,
      this.acknowledge1,
      this.acknowledge2,
      this.inUser,
      this.inDate,
      this.message,
      this.hrcode);


}