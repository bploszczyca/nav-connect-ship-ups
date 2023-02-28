pageextension 70869759 "ESNContact CardShip" extends "Contact Card"
{
    layout
    {
        addafter("Phone No.")
        {
            field("ESNADR Emerg. Phone No.Ship"; rec."ESNADR Emerg. Phone No.Ship") { ApplicationArea = All; Importance = Additional; }
        }
    }
}