pageextension 70869800 "ESNPackage CardUPS" extends "ETI-Package Card-NC"
{
    layout
    {
        addafter("ESNPackage CoutUPSshipShip")
        {
            field("ESNReturn ServiceUPS"; rec."ESNReturn ServiceUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}