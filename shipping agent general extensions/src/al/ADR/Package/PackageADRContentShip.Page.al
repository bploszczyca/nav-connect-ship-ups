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
                field("Manually Ent. Qty. (gr|ml)"; rec."Manually Ent. Qty. (gr|ml)") { ApplicationArea = All; Visible = false; }
                field("Package Quantity (gr|ml)"; rec."Package Quantity (gr|ml)") { ApplicationArea = All; }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcPackageQuantityGrMl();
    end;
}