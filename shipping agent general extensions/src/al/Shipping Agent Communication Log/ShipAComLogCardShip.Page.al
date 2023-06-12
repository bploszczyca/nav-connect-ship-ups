page 70869766 "ESNShip. A. Com. Log CardShip"
{
    Caption = 'Shipping Agent Communication Log Card';
    PageType = Card;
    SourceTable = "ESNShip. Agent Com. LogShip";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    Visible = false;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the date and time when this change log entry was created.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."User ID");
                    end;
                }
                field("Source Subtype"; Rec."Source Subtype") { ApplicationArea = all; Visible = false; }
                field(Status; Rec.Status) { ApplicationArea = all; }
                field("Status Text"; Rec."Status Text") { ApplicationArea = all; }
                field("HTTP Status Code"; Rec."HTTP Status Code") { ApplicationArea = all; Importance = Additional; }
            }
            group(ShippingAgent)
            {
                field("Shipping Agent Code"; Rec."Shipping Agent Code") { ApplicationArea = all; }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code") { ApplicationArea = all; }
                field("ESNShipping Agent APIShip"; Rec."ESNShipping Agent APIShip") { ApplicationArea = all; Importance = Additional; }
            }
            group(Send)
            {
                field("Send Data"; rec.GetSendData()) { ApplicationArea = all; MultiLine = true; }

            }
            group(Received)
            {
                field("Received Data"; rec.GetReceivedData()) { ApplicationArea = all; MultiLine = true; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}