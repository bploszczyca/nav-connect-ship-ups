page 70869759 "ESNADR Assi. ItemsShip"
{
    Caption = 'Assigned Items', Comment = 'Zugewiesene Artikel';
    PageType = ListPart;
    SourceTable = "ESNItem ADR QuantityShip";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; rec."Item No.") { ApplicationArea = All; }
                field("Variant Code"; rec."Variant Code") { ApplicationArea = All; Visible = false; }
                field("Item Description"; rec."Item Description") { ApplicationArea = All; }
                field("Item Description 2"; rec."Item Description 2") { ApplicationArea = All; Visible = false; }
                field("Quantity per Item Base UoM"; rec."Quantity per Item Base UoM") { ApplicationArea = All; }
                field("ADR Unit of Measure"; rec."ADR Unit of Measure") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Item Card")
            {
                Caption = 'Item Card';
                ApplicationArea = All;
                Image = Item;
                RunObject = page "Item Card";
                RunPageLink = "No." = field("Item No.");
            }
        }
    }
}