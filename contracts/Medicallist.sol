pragma solidity >=0.4.22 <9.0.0;

contract MedicalList{
    uint public medicalcount;

    struct Record{
        string customername;
        string customeremail;
        string doctorid;
        string doctorname;
        string doctoremail;
        string recordhash;
    }

    mapping(uint=>Record) public rec1;

    event RecordAdded(string customername, string customeremail, string doctorid, string doctorname , string doctoremail, string recordhash);

    constructor() public{
        medicalcount = 0;
    }

    function createRecord(string memory customername, string memory customeremail, string memory doctorid, string memory doctorname , string memory doctoremail, string memory recordhash) public {
        rec1[medicalcount++] = Record(customername,customeremail,doctorid,doctorname,doctoremail,recordhash);
        emit RecordAdded(customername, customeremail, doctorid, doctorname, doctoremail, recordhash);
    }

}