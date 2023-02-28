pageextension 70869806 "ESNADR Instructions CardUPS" extends "ESNADR Instructions CardShip"
{
    layout
    {
        addafter("Description 2")
        {
            field("ESNAdditional DescriptionUPS"; rec."ESNAdditional DescriptionUPS") { ApplicationArea = All; }
        }
        addafter("Excepted Quantities")
        {
            field("ESNLightly RegulatedUPS"; rec."ESNLightly RegulatedUPS") { ApplicationArea = All; }
        }
    }
}