pageextension 70869784 "ESNPackagesUPS" extends "ETI-Packages-NC"
{
    layout
    {
        addafter("No.")
        {
            field("ESNShipment No.UPS"; rec."ESNShipment No.UPS") { ApplicationArea = All; }
            field("ESNPackage CoutUPS"; rec."ESNPackage CoutUPS") { ApplicationArea = All; Visible = false; }
        }
        addbefore(Links)
        {
            part("Packages on Ship"; "ESNPackages on Ship FactBoxUPS")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.UPS" = field("ESNShipment No.UPS");
            }
        }
    }

}