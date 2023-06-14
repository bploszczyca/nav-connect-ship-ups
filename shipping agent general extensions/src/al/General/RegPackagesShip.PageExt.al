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
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(81806),
                              "No." = FIELD("No.");
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
        addlast(Navigation)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
        }
    }
}