pageextension 70869804 "ESNItem CardUPS" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("ESNUPS Packaging CodeUPS"; rec."ESNUPS Packaging CodeUPS") { ApplicationArea = All; Importance = Additional; }
            field("ESNUPS Simple RateUPS"; rec."ESNUPS Simple RateUPS") { ApplicationArea = All; Importance = Additional; }
        }
    }
}