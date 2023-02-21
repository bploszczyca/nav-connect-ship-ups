page 70869763 "ESNReg. Pack ADR Line ContShip"
{
    Caption = 'Dangerous Goods';
    PageType = ListPart;
    SourceTable = "ESNReg. Package ADR ContShip";
    DataCaptionFields = "Template No.", "Template Line No.", "Line No.";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("ADR No."; rec."ADR No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
                field("Quantity per Base UoM (gr|ml)"; rec."Quantity per Base UoM (gr|ml)") { ApplicationArea = All; Visible = false; }
                field("Quantity (Base)"; rec."Quantity (Base)") { ApplicationArea = All; Visible = false; }
                field("Quantity (gr|ml)"; rec."Quantity (gr|ml)") { ApplicationArea = All; }
            }
        }
    }
}