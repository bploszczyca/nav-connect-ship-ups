page 70869761 "ESNPackage ADR Line ContShip"
{
    Caption = 'Dangerous Goods';
    PageType = ListPart;
    SourceTable = "ESNPackage ADR ContentShip";
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
                field("ADR Quantity"; rec."ADR Quantity") { ApplicationArea = All; }
                field("ADR Unit of Measure"; rec."ADR Unit of Measure") { ApplicationArea = All; }
                field("ADR Quantity (gr|ml)"; rec."ADR Quantity (gr|ml)") { ApplicationArea = All; Visible = false; }
            }
        }
    }
}