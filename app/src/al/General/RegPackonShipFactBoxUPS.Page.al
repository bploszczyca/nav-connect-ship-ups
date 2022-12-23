page 70869782 "ESNRegPack. on Ship FactBoxUPS"
{
    Caption = 'Packages on Ship';
    PageType = ListPart;
    SourceTable = "ETI-Reg. Package-NC";
    SourceTableView = where("ESNShipment No.UPS" = filter('<>'''''));
    Editable = false;

    layout
    {
        area(Content)
        {
            field("ESNPackage CoutUPS"; rec."ESNPackage CoutUPS") { ApplicationArea = All; }
            repeater(GroupName)
            {
                field("No."; rec."No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
            }
        }
    }
}