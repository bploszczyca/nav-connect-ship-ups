codeunit 70869803 "ESNShipping Agent REST vXXUPS" implements "ESNShipping Agent RESTUPS"
{
    var
        NotYetImplementedLbl: Label 'Not yet implemented.', Comment = 'Noch nicht umgesetzt.';

    procedure GetShippingURL(ShippingAgent: Record "Shipping Agent") ShippingURL: Text;
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingURLQueryParameters(ShippingAgent: Record "Shipping Agent") ShippingURLQueryParameters: Text;
    var
        ShippingURLQueryParametersLbl: Label '?additionaladdressvalidation=city';
    begin
        if ShippingAgent.IsShippingAgentUPS then begin
            ShippingURLQueryParameters := ShippingURLQueryParametersLbl;
        end;
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