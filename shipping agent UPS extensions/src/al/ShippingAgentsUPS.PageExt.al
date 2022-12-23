pageextension 70869802 "ESNShipping AgentsUPS" extends "Shipping Agents"
{
    actions
    {
        addlast(navigation)
        {
            group("&UPS")
            {
                Caption = '&UPS';
                Image = Line;
                Enabled = EnableUPSActions;
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

    var
        [InDataSet]
        EnableUPSActions: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        EnableUPSActions := rec.IsShippingAgentUPS();
    end;
}