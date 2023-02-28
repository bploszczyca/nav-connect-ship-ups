pageextension 70869763 "ESNShipping Agent ServicesShip" extends "Shipping Agent Services"
{
    layout
    {
        addbefore("Shipping Time")
        {
            field("ESNTransportation ModeShip"; rec."ESNTransportation ModeShip") { ApplicationArea = all; }
        }
    }
}