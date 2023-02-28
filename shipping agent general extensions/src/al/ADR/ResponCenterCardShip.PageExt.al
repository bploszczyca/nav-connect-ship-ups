pageextension 70869761 "ESNRespon. Center CardShip" extends "Responsibility Center Card"
{
    layout
    {
        addafter("Phone No.")
        {
            field("ESNADR Emerg. Phone No.Ship"; rec."ESNADR Emerg. Phone No.Ship") { ApplicationArea = All; Importance = Additional; }
        }
    }
}