codeunit 70869803 "ESNShipping Agent REST vXXUPS" implements "ESNShipping Agent RESTUPS", "ESNShipping Agent APIShip"
{
    var
        NotYetImplementedLbl: Label 'Not yet implemented.', Comment = 'Noch nicht umgesetzt.';

    #region "ESNShipping Agent RESTUPS" Interface

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
    #endregion "ESNShipping Agent RESTUPS" Interface


    #region "ESNShipping Agent APIShip"
    procedure RegisterShipping(Package: Record "ETI-Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetTrackingStatus(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingCosts(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        Error(NotYetImplementedLbl);
    end;

    procedure GetShippingAgentAPIInterface(ShippingAgent: Record "Shipping Agent") ShippingAgentAPIInterface: Interface "ESNShipping Agent APIShip"
    begin
        Error(NotYetImplementedLbl);
    end;
    #endregion "ESNShipping Agent APIShip"

}