interface "ESNShipping Agent RESTUPS"
{
    procedure GetShippingURL(ShippingAgent: Record "Shipping Agent") ShippingURL: Text;
    procedure GetShippingCancelURL(ShippingAgent: Record "Shipping Agent") ShippingCancelURL: Text;
    procedure GetShippingLabelRecoveryURL(ShippingAgent: Record "Shipping Agent") ShippingLabelRecoveryURL: Text;
}