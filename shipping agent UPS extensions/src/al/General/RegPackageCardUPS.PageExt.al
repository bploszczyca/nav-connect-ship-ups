pageextension 70869803 "ESNReg. Package CardUPS" extends "ETI-Reg. Package Card-NC"
{
    layout
    {
        addafter("ESNPackage CoutUPSshipShip")
        {
            field("ESNReturn ServiceUPS"; rec."ESNReturn ServiceUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}