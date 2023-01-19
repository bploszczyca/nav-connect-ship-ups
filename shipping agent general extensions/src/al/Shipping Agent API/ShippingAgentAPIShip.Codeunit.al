codeunit 70869751 "ESNShipping Agent APIShip" implements "ESNShipping Agent APIShip"
{
    #region implements "ESNShipping Agent APIShip"
    procedure GetShippingAgentAPIInterface(ShippingAgent: Record "Shipping Agent") ShippingAgentAPIInterface: Interface "ESNShipping Agent APIShip"
    begin
        ShippingAgentAPIInterface := "ESNShipping AgentShip"::" ";
    end;

    procedure RegisterShipping(Package: Record "ETI-Package-NC");
    begin
        // DefaultImplementation(Package);
        // Message('Test: RegisterShipping');
    end;

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        // DefaultImplementation(RegPackage);
        // Message('Test: CancelRegisteredShipping');
    end;

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        DefaultImplementation(RegPackage);
    end;

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");
    begin
        // DefaultImplementation(RegPackage);
        // Message('Test: PrintShippingLable');
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
    #endregion implements "ESNShipping Agent APIShip"

    #region reg. package
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnBeforRegisterPackage', '', true, false)]
    local procedure PackageMgt_OnBeforRegisterPackage(var Package: Record "ETI-Package-NC")
    begin
        if Package."ESNShipment No.Ship" <> '' then begin
            Package.GetShippingAgentAPI().RegisterShipping(Package);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnAfterUndoRegisterPackage', '', true, false)]
    local procedure PackageMgt_OnAfterUndoRegisterPackage(var RegPackage: Record "ETI-Reg. Package-NC")
    begin
        if RegPackage."ESNShipment No.Ship" <> '' then begin
            RegPackage.GetShippingAgentAPI().CancelRegisteredShipping(RegPackage);
        end;
    end;
    #endregion
}