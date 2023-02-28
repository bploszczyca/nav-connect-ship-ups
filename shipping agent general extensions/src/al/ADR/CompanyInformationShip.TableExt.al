tableextension 70869754 "ESNCompany InformationShip" extends "Company Information"
{
    fields
    {
        field(70869750; "ESNADR Emerg. Phone No.Ship"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipper ADR Emergency Phone No.', Comment = 'Versender Gefahrgut Notfall Tel. Nr.';
            ExtendedDatatype = PhoneNo;
        }
    }
}