page 70869754 "ESNADR ClassificationsShip"
{
    Caption = 'ADR Classifications', Comment = 'ADR Klassifizierungen';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ESNADR ClassificationShip";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; rec.Code) { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
            }
        }
    }
}