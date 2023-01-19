pageextension 70869803 "ESNReg. Package CardUPS" extends "ETI-Reg. Package Card-NC"
{
    layout
    {
        addafter("Packing Material Item No.")
        {
            field("ESNUPS Packaging CodeUPS"; rec."ESNUPS Packaging CodeUPS") { ApplicationArea = All; Importance = Additional; }
        }
        addafter("ESNPackage CoutUPSshipShip")
        {
            field("ESNReturn ServiceUPS"; rec."ESNReturn ServiceUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}