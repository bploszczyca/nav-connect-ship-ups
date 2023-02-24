page 70869764 "ESNADR LableInst. SubPageShip"
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
                field(Lable; rec.Lable) { ApplicationArea = All; }
            }
        }
    }
}