page 70869781 "ESNPackages FactBoxShip"
{
    Caption = 'Packages on Ship';
    PageType = ListPart;
    SourceTable = "ETI-Package-NC";
    SourceTableView = where("ESNShipment No.Ship" = filter('<>'''''));
    Editable = false;

    layout
    {
        area(Content)
        {
            field("ESNPackage CoutShip"; rec."ESNPackage CoutShip") { ApplicationArea = All; }
            repeater(GroupName)
            {
                field("No."; rec."No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
            }
        }
    }
}