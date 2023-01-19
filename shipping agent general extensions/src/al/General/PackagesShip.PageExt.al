pageextension 70869751 "ESNPackagesShip" extends "ETI-Packages-NC"
{
    layout
    {
        addafter("No.")
        {
            field("ESNShipment No.Ship"; rec."ESNShipment No.Ship") { ApplicationArea = All; }
            field("ESNPackage CoutShip"; rec."ESNPackage CoutShip") { ApplicationArea = All; Visible = false; }
        }
        addbefore(Links)
        {
            part("Packages on Ship"; "ESNPackages FactBoxShip")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.Ship" = field("ESNShipment No.Ship");
            }
        }
    }

}