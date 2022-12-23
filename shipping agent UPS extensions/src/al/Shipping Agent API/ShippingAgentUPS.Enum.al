enumextension 70869800 "ESNShipping AgentShip" extends "ESNShipping AgentShip"
{
    value(10; "UPS REST")
    {
        Caption = 'UPS REST', Comment = 'UPS REST';
        Implementation = "ESNShipping Agent APIShip" = "ESNShipping Agent APIUPS";
    }
}