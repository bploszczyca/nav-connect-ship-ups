page 70869758 "ESNItem ADR QuantitiesShip"
{
    Caption = 'Item ADR Quantities', Comment = 'Artikel ADR Mengen';
    PageType = List;
    SourceTable = "ESNItem ADR QuantityShip";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Variant Code"; rec."Variant Code") { ApplicationArea = All; Visible = false; }
                field("ADR No."; rec."ADR No.") { ApplicationArea = All; }
                field("Packaging Type"; rec."Packaging Type") { ApplicationArea = All; }
                field("Pack. Count per Item Base UoM"; rec."Pack. Count per Item Base UoM") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; Lookup = false; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Lookup = false; Visible = false; }
                field("Quantity per Base UoM (gr|ml)"; rec."Quantity per Item Base UoM") { ApplicationArea = All; }
                field("ADR Unit of Measure"; rec."ADR Unit of Measure") { ApplicationArea = All; }
            }
        }
    }
}