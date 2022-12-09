pageextension 70869783 "ESNPackage CardUPS" extends "ETI-Package Card-NC"
{
    layout
    {
        addbefore(Lieferung)
        {
            group(Shipment)
            {
                field("ESNShipment No.UPS"; rec."ESNShipment No.UPS") { ApplicationArea = All; }
                field("ESNPackage CoutUPS"; rec."ESNPackage CoutUPS") { ApplicationArea = All; }
            }
        }
        addbefore("Etiscan Package Cont FactBox")
        {
            part("Packages on Ship"; "ESNPackages on Ship FactBoxUPS")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.UPS" = field("ESNShipment No.UPS");
            }
        }
    }
}