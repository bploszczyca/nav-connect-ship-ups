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
                field("Manually entered Quantity"; rec."Manually entered Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Total ADR Content Quantity"; rec."Total ADR Package Quantity") { ApplicationArea = All; }
                field("ADR Content Unit of Measure"; rec."ADR Content Unit of Measure") { ApplicationArea = All; }
                field("Regulated Level"; rec."Regulated Level") { ApplicationArea = All; }
            }
        }
    }
}