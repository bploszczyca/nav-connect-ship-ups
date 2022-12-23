codeunit 70869805 "ESNShipping Agent APIUPS" implements "ESNShipping Agent APIShip"
{
    procedure RegisterShipping(Package: Record "ETI-Package-NC");
    begin
        DefaultImplementation(Package);
    end;

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    procedure GetTrackingStatus(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    procedure GetShippingCosts(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    local procedure DefaultImplementation(Package: Record "ETI-Package-NC")
    var
        ShippingAgent: Record "Shipping Agent";
        NotYetImplementedLbl: Label 'Not yet implemented.', Comment = 'Noch nicht umgesetzt.';
    begin
        Package.TestField("Shipping Agent Code");
        ShippingAgent.get(Package."Shipping Agent Code");
        ShippingAgent.TestField("ESNShipping Agent APIShip");
        Error(NotYetImplementedLbl);
    end;

    local procedure DefaultImplementation(RegPackage: Record "ETI-Reg. Package-NC")
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.TransferFields(RegPackage);
        DefaultImplementation(Package);
    end;
}