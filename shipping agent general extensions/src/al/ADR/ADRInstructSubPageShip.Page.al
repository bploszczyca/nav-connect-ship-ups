page 70869756 "ESNADR Instruct. SubPageShip"
{
    PageType = ListPart;
    SourceTable = "ESNADR InstructionShip";
    LinksAllowed = false;
    DelayedInsert = true;
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