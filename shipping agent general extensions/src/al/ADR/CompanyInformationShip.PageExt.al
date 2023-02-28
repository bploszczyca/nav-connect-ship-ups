pageextension 70869760 "ESNCompany InformationShip" extends "Company Information"
{
    layout
    {
        addafter("Phone No.")
        {
            field("ESNADR Emerg. Phone No.Ship"; rec."ESNADR Emerg. Phone No.Ship") { ApplicationArea = All; Importance = Additional; }
        }
    }
}