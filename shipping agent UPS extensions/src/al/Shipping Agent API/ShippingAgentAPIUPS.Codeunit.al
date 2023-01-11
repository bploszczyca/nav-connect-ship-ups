codeunit 70869805 "ESNShipping Agent APIUPS" implements "ESNShipping Agent APIShip"
{

    procedure GetShippingAgentAPIInterface(ShippingAgent: Record "Shipping Agent") ShippingAgentAPIInterface: Interface "ESNShipping Agent APIShip"
    begin

    end;

    procedure RegisterShipping(Package: Record "ETI-Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(Package, ShippingAgent);
        Package.TestField("Shipping Agent Code");
        ShippingAgent.get(Package."Shipping Agent Code");
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).RegisterShipping(Package);
    end;

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(RegPackage, ShippingAgent);
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).CancelRegisteredShipping(RegPackage);
    end;

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(RegPackage, ShippingAgent);
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).GetShippingLable(RegPackage);
    end;

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(RegPackage, ShippingAgent);
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).PrintShippingLable(RegPackage);
    end;

    procedure GetTrackingStatus(RegPackage: Record "ETI-Reg. Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(RegPackage, ShippingAgent);
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).GetTrackingStatus(RegPackage);
    end;

    procedure GetShippingCosts(RegPackage: Record "ETI-Reg. Package-NC");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        DefaulCheck(RegPackage, ShippingAgent);
        ShippingAgent.GetShippingAgentAPIInterface().GetShippingAgentAPIInterface(ShippingAgent).GetShippingCosts(RegPackage);
    end;

    local procedure DefaulCheck(Package: Record "ETI-Package-NC"; var ShippingAgent: Record "Shipping Agent")
    begin
        Package.TestField("Shipping Agent Code");
        ShippingAgent.get(Package."Shipping Agent Code");
        ShippingAgent.TestField("ESNShipping Agent APIShip", ShippingAgent."ESNShipping Agent APIShip"::"UPS REST");
    end;

    local procedure DefaulCheck(RegPackage: Record "ETI-Reg. Package-NC"; var ShippingAgent: Record "Shipping Agent")
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.TransferFields(RegPackage);
        DefaulCheck(Package, ShippingAgent);
    end;
}