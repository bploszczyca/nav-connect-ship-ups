#pragma implicitwith disable
page 70869765 "ESNShip. Agent Com. LogShip"
{
    Caption = 'Shipping Agent Communication Log';
    ApplicationArea = All;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = true;
    CardPageId = "ESNShip. A. Com. Log CardShip";
    PageType = List;
    SourceTable = "ESNShip. Agent Com. LogShip";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
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
                field(Status; Rec.Status) { ApplicationArea = all; }
                field("Status Text"; Rec."Status Text") { ApplicationArea = all; Visible = false; }
                field("HTTP Status Code"; Rec."HTTP Status Code") { ApplicationArea = all; Visible = false; }
                field("Shipping Agent Code"; Rec."Shipping Agent Code") { ApplicationArea = all; }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code") { ApplicationArea = all; Visible = false; }
                field("Source Type"; Rec."Source Type") { ApplicationArea = all; Visible = false; }
                field("Source Subtype"; Rec."Source Subtype") { ApplicationArea = all; Visible = false; }
                field("Source No."; Rec."Source No.") { ApplicationArea = all; }
                field("Source Line No."; Rec."Source Line No.") { ApplicationArea = all; Visible = false; }
                field("Source Subline No."; Rec."Source Subline No.") { ApplicationArea = all; Visible = false; }

            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RetentionPolicy)
            {
                ApplicationArea = All;
                Caption = 'Retention Policy';
                Tooltip = 'View or Edit the retention policy.';
                Image = Delete;
                RunObject = Page "Retention Policy Setup Card";
                RunPageView = where("Table Id" = const(70869757)); // Database::"ESNShip. Agent Com. LogShip";
                AccessByPermission = tabledata "Retention Policy Setup" = R;
                RunPageMode = View;
                Ellipsis = true;
            }
        }
    }
}

#pragma implicitwith restore
