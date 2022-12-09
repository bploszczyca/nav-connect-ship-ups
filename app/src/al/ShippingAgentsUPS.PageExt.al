pageextension 70869781 "ESNShipping AgentsUPS" extends "Shipping Agents"
{
    layout
    {
        addlast(Control1)
        {
            field(ESNUPS; rec.ESNUPS)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        addlast(navigation)
        {
            group("&UPS")
            {
                Caption = '&UPS';
                Image = Line;
                action("UPS REST api Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'UPS REST api Setup ';
                    Image = NewWarehouseShipment;
                    RunObject = Page "ESNShipping Agent CardUPS";
                    RunPageLink = Code = FIELD(Code);
                }
            }
        }
    }
}