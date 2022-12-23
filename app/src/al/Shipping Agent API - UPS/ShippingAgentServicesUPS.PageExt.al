pageextension 70869782 "ESNShipping Agent ServicesUPS" extends "Shipping Agent Services"
{
    layout
    {
        addlast(Control1)
        {
            field("ESNShipment Service CodeUPS"; rec."ESNShipment Service CodeUPS") { ApplicationArea = All; }
        }
    }
}