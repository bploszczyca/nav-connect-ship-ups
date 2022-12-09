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
        NewPackage."No." := '';
        NewPackage."ESNShipment No.UPS" := Package."ESNShipment No.UPS";
        NewPackage.Insert(true);
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

}