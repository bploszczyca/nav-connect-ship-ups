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
                field("Packaging Type"; rec."Packaging Type") { ApplicationArea = All; }
                field("Total Packaging Type Count"; rec."Total Packaging Type Count") { ApplicationArea = All; }
                field("ADR Quantity"; rec."ADR Quantity") { ApplicationArea = All; }
                field("ADR Unit of Measure"; rec."ADR Unit of Measure") { ApplicationArea = All; }
                field("ADR Quantity (gr|ml)"; rec."ADR Quantity (gr|ml)") { ApplicationArea = All; Visible = false; }
            }
        }
    }
}