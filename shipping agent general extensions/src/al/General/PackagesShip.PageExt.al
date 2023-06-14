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
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(81804),
                              "No." = FIELD("No.");
            }
        }

    }
    actions
    {
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