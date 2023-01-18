pageextension 70869803 "ESNPackage CardUPS" extends "ETI-Package Card-NC"
{
    layout
    {
        addafter("ESNPackage CoutUPSshipShip")
        {
            field("ESNReturn ServiceUPS"; rec."ESNReturn ServiceUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}