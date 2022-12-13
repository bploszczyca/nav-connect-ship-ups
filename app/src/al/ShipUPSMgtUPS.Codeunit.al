codeunit 70869781 "ESNShip UPS Mgt.UPS"
{

    #region Shipping Agent and Shipping Agent Services
    [EventSubscriber(ObjectType::Table, database::"Shipping Agent Services", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure ShippingAgentServices_OnBeforeDeleteEvent(var Rec: Record "Shipping Agent Services"; RunTrigger: Boolean)
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if not Rec.IsTemporary and RunTrigger then begin
            if ShippingAgent.get(Rec."Shipping Agent Code") then begin
                if ShippingAgent."ESNDefault ServiceUPS" = rec.Code then begin
                    ShippingAgent.FieldError("ESNDefault ServiceUPS");
                end;
            end;
        end;
    end;
    #endregion

    #region Package    
    procedure AddPackageToShipmentNo(Package: Record "ETI-Package-NC"; var NewPackage: Record "ETI-Package-NC")
    begin
        NewPackage.Init();
        NewPackage.TransferFields(Package);
        NewPackage."No." := '';
        NewPackage."ESNShipment No.UPS" := Package."ESNShipment No.UPS";
        NewPackage.Insert(true);
        // Clear
        NewPackage.Validate("Template Document", Package."Template Document"::" ");
        // Setup new Template Recs
        NewPackage.Validate("Template Document", Package."Template Document");
        NewPackage.Validate("Template No.", Package."Template No.");
        NewPackage.Modify(true);
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package-NC", 'OnBeforeValidateEvent', 'Shipping Agent Code', true, false)]
    local procedure Package_OnBeforeValidateEvent_ShippingAgentCode(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC")
    var
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        if (rec."Shipping Agent Code" <> xrec."Shipping Agent Code") and (rec."Shipping Agent Code" <> '') then begin
            if ShippingAgent.get(Rec."Shipping Agent Code") and ShippingAgent.ESNUPS and (ShippingAgent."ESNDefault ServiceUPS" <> '') then begin
                if ShippingAgentServices.get(ShippingAgent.Code, ShippingAgent."ESNDefault ServiceUPS") then begin
                    rec.Validate("Shipping Agent Service Code", ShippingAgent."ESNDefault ServiceUPS");
                end;
            end;
        end;
    end;
    #endregion

    #region reg. package
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnAfterRegisterPackage', '', true, false)]
    local procedure PackageMgt_OnAfterRegisterPackage(var Package: Record "ETI-Package-NC")
    var
        Package2: Record "ETI-Package-NC";
        PackageMgt: Codeunit "ETI-Package Mgt-NC";
    begin
        if Package."ESNShipment No.UPS" <> '' then begin
            Package2.SetRange("ESNShipment No.UPS", Package."ESNShipment No.UPS");
            if not Package2.IsEmpty then
                if Package2.Find('-') then
                    repeat
                        // Can be proced by other Reg. Call
                        if Package2.get(Package2."No.") then begin
                            PackageMgt.RegisterPackage(Package2, true);
                        end;
                    until Package2.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnAfterUndoRegisterPackage', '', true, false)]
    local procedure PackageMgt_OnAfterUndoRegisterPackage(var RegPackage: Record "ETI-Reg. Package-NC")
    var
        RegPackage2: Record "ETI-Reg. Package-NC";
        PackageMgt: Codeunit "ETI-Package Mgt-NC";
    begin
        if RegPackage."ESNShipment No.UPS" <> '' then begin
            RegPackage2.SetRange("ESNShipment No.UPS", RegPackage."ESNShipment No.UPS");
            if not RegPackage2.IsEmpty then
                if RegPackage2.Find('-') then
                    repeat
                        // Can be proced by other Reg. Call
                        if RegPackage2.get(RegPackage2."No.") then begin
                            PackageMgt.UndoPackageRegistration(RegPackage2, true);
                        end;
                    until RegPackage2.Next() = 0;
        end;
    end;
    #endregion

}