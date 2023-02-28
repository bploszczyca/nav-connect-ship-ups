pageextension 70869762 "ESNLocation CardShip" extends "Location Card"
{
    layout
    {
        addafter("Phone No.")
        {
            field("ESNADR Emerg. Phone No.Ship"; rec."ESNADR Emerg. Phone No.Ship") { ApplicationArea = All; Importance = Additional; }
        }
    }
}