codeunit 70869782 "ESNShipping Agent REST v1UPS" implements "ESNShipping Agent RESTUPS"
{
    procedure GetShippingURL(ShippingAgent: Record "Shipping Agent") ShippingURL: Text;
    var
        ShippingTestingURLLbl: Label 'https://wwwcie.ups.com/ship/%1/shipments', Locked = true;
        ShippingProductionURLLbl: Label 'https://onlinetools.ups.com/ship/%1/shipments', Locked = true;
    begin
        if ShippingAgent.ESNUPS then begin
            case ShippingAgent."ESNREST API EndpointUPS" of
                ShippingAgent."ESNREST API EndpointUPS"::Testing:
                    begin
                        ShippingURL := StrSubstNo(ShippingTestingURLLbl, ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent));
                    end;
                ShippingAgent."ESNREST API EndpointUPS"::Production:
                    begin
                        ShippingURL := StrSubstNo(ShippingProductionURLLbl, ShippingAgent.GetShipAgentRESTVerInterface().GetVersionString(ShippingAgent));
                    end;
            end;
        end;
    end;

    procedure GetShippingCancelURL(ShippingAgent: Record "Shipping Agent") ShippingCancelURL: Text;
    var
        ShippingCancelTestingURLLbl: Label 'https://wwwcie.ups.com/ship/v1/shipments/cancel', Locked = true;
        ShippingCancelProductionURLLbl: Label 'https://onlinetools.ups.com/ship/v1/shipments/cancel', Locked = true;
    begin
        if ShippingAgent.ESNUPS then begin
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
        if ShippingAgent.ESNUPS then begin
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

}