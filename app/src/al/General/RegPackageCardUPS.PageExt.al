pageextension 70869785 "ESNReg. Package CardUPS" extends "ETI-Reg. Package Card-NC"
{
    layout
    {
        addbefore(Lieferung)
        {
            group(ESNShipmentUPS)
            {
                field("ESNShipment No.UPS"; rec."ESNShipment No.UPS") { ApplicationArea = All; }
                field("ESNPackage CoutUPS"; rec."ESNPackage CoutUPS") { ApplicationArea = All; }
            }
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