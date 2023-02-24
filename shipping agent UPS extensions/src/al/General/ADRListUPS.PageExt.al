pageextension 70869805 "ESNADR ListUPS" extends "ESNADR ListShip"
{
    layout
    {
        addafter("Excepted Quantities")
        {
            field("ESNLightly RegulatedUPS"; rec."ESNLightly RegulatedUPS") { ApplicationArea = All; }
        }
    }
}