tableextension 70869755 "ESNResponsibility CenterShip" extends "Responsibility Center"
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