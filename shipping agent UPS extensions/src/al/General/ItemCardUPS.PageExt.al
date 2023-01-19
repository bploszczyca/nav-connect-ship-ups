pageextension 70869804 "ESNItem CardUPS" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("ESNUPS Packaging CodeUPS"; rec."ESNUPS Packaging CodeUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}