pageextension 70869754 "ESNShipping AgentsShip" extends "Shipping Agents"
{
    layout
    {
        addlast(Control1)
        {
            field("ESNMovement Ref. NumberShip"; rec."ESNMovement Ref. NumberShip") { ApplicationArea = Basic, Suite; }
            field(ESNUPSShip; rec."ESNShipping Agent APIShip")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field("ESNDefault ServiceShip"; rec."ESNDefault ServiceShip") { ApplicationArea = Basic, Suite; Visible = false; }
            field("ESNDefault Ship-from TypeShip"; rec."ESNDefault Ship-from TypeShip") { ApplicationArea = Basic, Suite; Visible = false; }
            field("ESNDef. Ship-from ContactShip"; rec."ESNDef. Ship-from ContactShip") { ApplicationArea = Basic, Suite; Visible = false; }
        }
    }
}