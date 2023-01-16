codeunit 70869802 "ESNShipping Agent REST v1UPS" implements "ESNShipping Agent RESTUPS", "ESNShipping Agent APIShip"
{
    #region "ESNShipping Agent RESTUPS" Interface
    procedure GetShippingURL(ShippingAgent: Record "Shipping Agent") ShippingURL: Text;
    var
        ShippingTestingURLLbl: Label 'https://wwwcie.ups.com/ship/%1/shipments%2', Locked = true;
        ShippingProductionURLLbl: Label 'https://onlinetools.ups.com/ship/%1/shipments%2', Locked = true;
    begin
        if ShippingAgent.IsShippingAgentUPS then begin
            case ShippingAgent."ESNREST API EndpointUPS" of
                ShippingAgent."ESNREST API EndpointUPS"::Testing:
                    begin
                        ShippingURL := StrSubstNo(ShippingTestingURLLbl,
                            ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent),
                            ShippingAgent.GetShippingURLQueryParameters());
                    end;
                ShippingAgent."ESNREST API EndpointUPS"::Production:
                    begin
                        ShippingURL := StrSubstNo(ShippingProductionURLLbl,
                            ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent),
                            ShippingAgent.GetShippingURLQueryParameters());
                    end;
            end;
        end;
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
    var
        ShippingCancelTestingURLLbl: Label 'https://wwwcie.ups.com/ship/v1/shipments/cancel', Locked = true;
        ShippingCancelProductionURLLbl: Label 'https://onlinetools.ups.com/ship/v1/shipments/cancel', Locked = true;
    begin
        if ShippingAgent.IsShippingAgentUPS then begin
            case ShippingAgent."ESNREST API EndpointUPS" of
                ShippingAgent."ESNREST API EndpointUPS"::Testing:
                    begin
                        ShippingCancelURL := ShippingCancelTestingURLLbl;
                    end;
                ShippingAgent."ESNREST API EndpointUPS"::Production:
                    begin
                        ShippingCancelURL := ShippingCancelProductionURLLbl;
                    end;
            end;
        end;
    end;

    procedure GetShippingLabelRecoveryURL(ShippingAgent: Record "Shipping Agent") ShippingLabelRecoveryURL: Text;
    var
        ShippingLabelRecoveryTestingURLLbl: Label 'https://wwwcie.ups.com/ship/%1/shipments/labels', Locked = true;
        ShippingLabelRecoveryProductionURLLbl: Label 'https://onlinetools.ups.com/ship/%1/shipments/labels', Locked = true;
    begin
        if ShippingAgent.IsShippingAgentUPS then begin
            case ShippingAgent."ESNREST API EndpointUPS" of
                ShippingAgent."ESNREST API EndpointUPS"::Testing:
                    begin
                        ShippingLabelRecoveryURL := StrSubstNo(ShippingLabelRecoveryTestingURLLbl, ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent));
                    end;
                ShippingAgent."ESNREST API EndpointUPS"::Production:
                    begin
                        ShippingLabelRecoveryURL := StrSubstNo(ShippingLabelRecoveryProductionURLLbl, ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent));
                    end;
            end;
        end;
    end;
    #endregion "ESNShipping Agent RESTUPS" Interface


    #region "ESNShipping Agent APIShip" Interface
    procedure GetShippingAgentAPIInterface(ShippingAgent: Record "Shipping Agent") ShippingAgentAPIInterface: Interface "ESNShipping Agent APIShip"
    begin
        ShippingAgentAPIInterface := ShippingAgent.GetESNShippingAgentAPIShipUPS();
    end;

    procedure RegisterShipping(Package: Record "ETI-Package-NC");
    begin
        Message('RegisterShipping, das ist ja super');
    end;

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");
    begin

    end;

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin

    end;

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin

    end;

    procedure GetTrackingStatus(RegPackage: Record "ETI-Reg. Package-NC");
    begin

    end;

    procedure GetShippingCosts(RegPackage: Record "ETI-Reg. Package-NC");
    begin

    end;
    #endregion "ESNShipping Agent APIShip" Interface
}