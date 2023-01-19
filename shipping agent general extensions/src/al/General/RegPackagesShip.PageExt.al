pageextension 70869753 "ESNRegPackagesShip" extends "ETI-Reg. Packages-NC"
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
            part("Packages on Ship"; "ESNRegPack. FactBoxShip")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.Ship" = field("ESNShipment No.Ship");
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            group("F&unktion")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Tracking Status")
                {
                    Caption = 'Tracking Status';
                    Ellipsis = true;
                    Image = LaunchWeb;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    begin
                        rec.GetShippingAgentAPI().GetTrackingStatus(Rec);
                    end;
                }
            }
        }
        addafter("D&rucken")
        {

            action("Print Shipping Lable")
            {
                Caption = 'Print &Shipping Lable';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    rec.GetShippingAgentAPI().PrintShippingLable(Rec);
                end;
            }
        }
    }
}