pageextension 70869806 "ESNADR Instructions CardUPS" extends "ESNADR Instructions CardShip"
{
    layout
    {
        addafter("Excepted Quantities")
        {
            field("ESNLightly RegulatedUPS"; rec."ESNLightly RegulatedUPS") { ApplicationArea = All; }
        }
    }
}