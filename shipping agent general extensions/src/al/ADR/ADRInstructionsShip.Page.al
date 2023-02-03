page 70869757 "ESNADR InstructionsShip"
{
    Caption = 'ADR Instructions', Comment = 'ADR Anweisungen';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ESNADR InstructionShip";
    SourceTableView = where("ADR No." = filter(''));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Groupe; rec.Groupe) { ApplicationArea = All; }
                field("Code"; rec.Code) { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
            }
        }
    }
}