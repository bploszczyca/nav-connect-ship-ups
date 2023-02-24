page 70869760 "ESNPackage ADR ContentShip"
{
    Caption = 'Dangerous Goods';
    PageType = ListPart;
    SourceTable = "ESNPackage ADR ContentShip";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("ADR No."; rec."ADR No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
                field("ADR Content Quantity (gr|ml)"; rec."ADR Content Quantity (gr|ml)") { ApplicationArea = All; Visible = false; }
                field("ADR Content Quantity"; rec."ADR Content Quantity") { ApplicationArea = All; }
                field("ADR Content Unit of Measure"; rec."ADR Content Unit of Measure") { ApplicationArea = All; }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcPackageQuantityGrMl();
    end;
}