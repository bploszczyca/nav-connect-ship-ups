codeunit 70869783 "ESNShipping Agent REST vXXUPS" implements "ESNShipping Agent RESTUPS"
{
    var
        NotYetImplementedLbl: Label 'Not yet implemented.', Comment = 'Noch nicht umgesetzt.';

    procedure GetShippingURL(ShippingAgent: Record "Shipping Agent") ShippingURL: Text;
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingCancelURL(ShippingAgent: Record "Shipping Agent") ShippingCancelURL: Text;
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingLabelRecoveryURL(ShippingAgent: Record "Shipping Agent") ShippingLabelRecoveryURL: Text;
    begin
        Error(NotYetImplementedLbl);
    end;
}