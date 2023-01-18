codeunit 70869781 "ESNShipment Mgt.Ship"
{

    #region Shipping Agent and Shipping Agent Services
    [EventSubscriber(ObjectType::Table, database::"Shipping Agent Services", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure ShippingAgentServices_OnBeforeDeleteEvent(var Rec: Record "Shipping Agent Services"; RunTrigger: Boolean)
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if not Rec.IsTemporary and RunTrigger then begin
            if ShippingAgent.get(Rec."Shipping Agent Code") then begin
                if ShippingAgent."ESNDefault ServiceShip" = rec.Code then begin
                    ShippingAgent.FieldError("ESNDefault ServiceShip");
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
        NewPackage."ESNShipment No.Ship" := Package."ESNShipment No.Ship";
        NewPackage.Insert(true);
        // Clear
        NewPackage.Validate("Template Document", Package."Template Document"::" ");
        // Setup new Template Recs
        NewPackage.Validate("Template Document", Package."Template Document");
        NewPackage.Validate("Template No.", Package."Template No.");
        NewPackage.Modify(true);
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package-NC", 'OnAfterValidateEvent', 'Shipping Agent Code', true, false)]
    local procedure Package_OnAfterValidateEvent_ShippingAgentCode(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC")
    var
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        if (rec."Shipping Agent Code" <> xrec."Shipping Agent Code") and (rec."Shipping Agent Code" <> '') then begin
            if ShippingAgent.get(Rec."Shipping Agent Code") and (ShippingAgent."ESNShipping Agent APIShip" <> ShippingAgent."ESNShipping Agent APIShip"::" ") and (ShippingAgent."ESNDefault ServiceShip" <> '') then begin
                if ShippingAgentServices.get(ShippingAgent.Code, ShippingAgent."ESNDefault ServiceShip") then begin
                    rec.Validate("Shipping Agent Service Code", ShippingAgent."ESNDefault ServiceShip");
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package-NC", 'OnBeforeModifyEvent', '', true, false)]
    local procedure Package_OnBeforeModifyEvent(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC")
    var
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        if not rec.IsTemporary and (rec."Shipping Agent Code" <> '') and (rec."Shipping Agent Service Code" = '') then begin
            if ShippingAgent.get(Rec."Shipping Agent Code") and (ShippingAgent."ESNShipping Agent APIShip" <> ShippingAgent."ESNShipping Agent APIShip"::" ") and (ShippingAgent."ESNDefault ServiceShip" <> '') then begin
                if ShippingAgentServices.get(ShippingAgent.Code, ShippingAgent."ESNDefault ServiceShip") then begin
                    rec.Validate("Shipping Agent Service Code", ShippingAgent."ESNDefault ServiceShip");
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package-NC", 'OnAfterValidateEvent', 'Template Document No.', true, false)]
    local procedure Package_OnAfterValidateEvent_TemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer)
    var
        CompanyInfo: Record "Company Information";
        ShippingAgent: Record "Shipping Agent";

        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        TransferHeader: Record "Transfer Header";
        ServiceHeader: Record "Service Header";
        WhseShipHeader: Record "Warehouse Shipment Header";
        WhseActHeader: Record "Warehouse Activity Header";
        SalesShipHeader: Record "Sales Shipment Header";
        ReturnShipHeader: Record "Return Shipment Header";
        TransferShipHeader: Record "Transfer Shipment Header";
        ServiceShipmentHeader: Record "Service Shipment Header";
        PostWhseShipHeader: Record "Posted Whse. Shipment Header";
        RegWhseActHeader: Record "Registered Whse. Activity Hdr.";
        PostInvtPickHeader: Record "Posted Invt. Pick Header";
        Package: Record "ETI-Package-NC";
        Package2: Record "ETI-Package-NC";
        PackageAsContent: Record "ETI-Package-NC";
        PackageAsContent2: Record "ETI-Package-NC";
        RegPackage: Record "ETI-Reg. Package-NC";
        TransportContainer: Record "ETI-Transport Container-NC";
        IsHandled: Boolean;
    begin
        OnBefore_Package_OnAfterValidateEvent_TemplateDocumentNo(xRec, Rec, CurrFieldNo, IsHandled);
        if IsHandled then
            exit;

        IF (rec."Template Document No." <> xRec."Template Document No.") and (ShippingAgent.get(rec."Shipping Agent Code")) and (ShippingAgent."ESNDefault Ship-from TypeShip" <> ShippingAgent."ESNDefault Ship-from TypeShip"::" ") THEN BEGIN
            IF rec."Template Document No." <> '' THEN BEGIN
                case ShippingAgent."ESNDefault Ship-from TypeShip" of
                    ShippingAgent."ESNDefault Ship-from TypeShip"::"Company Information":
                        begin
                            rec.Validate("ESNShip-from TypeShip", ShippingAgent."ESNDefault Ship-from TypeShip");
                        end;
                    ShippingAgent."ESNDefault Ship-from TypeShip"::Contact:
                        begin
                            rec.Validate("ESNShip-from TypeShip", ShippingAgent."ESNDefault Ship-from TypeShip");
                            rec.Validate("ESNShip-from No.Ship", ShippingAgent."ESNDef. Ship-from ContactShip");
                        end;
                    else begin
                        rec.Validate("ESNShip-from TypeShip", ShippingAgent."ESNDefault Ship-from TypeShip");
                        CASE rec."Template Document" OF
                            rec."Template Document"::" ":
                                BEGIN
                                    // Do nothing
                                END;
                            rec."Template Document"::"Sales Order":
                                BEGIN
                                    SalesHeader.GET(SalesHeader."Document Type"::Order, rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", SalesHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", SalesHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Purchase Return Order":
                                BEGIN
                                    PurchaseHeader.GET(PurchaseHeader."Document Type"::"Return Order", rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", PurchaseHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", PurchaseHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Transfer Order":
                                BEGIN
                                    TransferHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", TransferHeader."Transfer-from Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Service Order":
                                BEGIN
                                    ServiceHeader.GET(ServiceHeader."Document Type"::Order, rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ServiceHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ServiceHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Warehouse Shipment":
                                BEGIN
                                    WhseShipHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", WhseShipHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Warehouse Pick":
                                BEGIN
                                    WhseActHeader.GET(WhseActHeader.Type::Pick, rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", WhseActHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Invt. Pick":
                                BEGIN
                                    WhseActHeader.GET(WhseActHeader.Type::"Invt. Pick", rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", WhseActHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Sales Shipment":
                                BEGIN
                                    SalesShipHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", SalesShipHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", SalesShipHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Return Shipment":
                                BEGIN
                                    ReturnShipHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ReturnShipHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ReturnShipHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Transfer Shipment":
                                BEGIN
                                    TransferShipHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", TransferShipHeader."Transfer-from Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Service Shipment":
                                BEGIN
                                    ServiceShipmentHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ServiceShipmentHeader."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", ServiceShipmentHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Post. Warehouse Shipment":
                                BEGIN
                                    PostWhseShipHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", PostWhseShipHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Reg. Warehouse Pick":
                                BEGIN
                                    RegWhseActHeader.GET(RegWhseActHeader.Type::Pick, rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", RegWhseActHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::"Post. Invt. Pick":
                                BEGIN
                                    PostInvtPickHeader.GET(rec."Template Document No.");
                                    case ShippingAgent."ESNDefault Ship-from TypeShip" of
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::"Responsibility Center":
                                            begin
                                                CompanyInfo.get();
                                                rec.Validate("ESNShip-from No.Ship", CompanyInfo."Responsibility Center");
                                            end;
                                        ShippingAgent."ESNDefault Ship-from TypeShip"::Location:
                                            begin
                                                rec.Validate("ESNShip-from No.Ship", RegWhseActHeader."Location Code");
                                            end;
                                    end;
                                END;
                            rec."Template Document"::Package:
                                BEGIN
                                    IF rec."No." = rec."Template Document No." THEN
                                        rec.FIELDERROR(rec."Template Document No.");
                                    Package.GET(rec."Template Document No.");
                                    Package_OnAfterValidateEvent_PackageTemplateDocumentNo(xRec, Rec, CurrFieldNo, Package);
                                END;
                            rec."Template Document"::"Reg. Package":
                                BEGIN
                                    IF rec."No." = rec."Template Document No." THEN
                                        rec.FIELDERROR(rec."Template Document No.");
                                    RegPackage.GET(rec."Template Document No.");
                                    Package_OnAfterValidateEvent_RegPackageTemplateDocumentNo(xRec, Rec, CurrFieldNo, RegPackage);
                                END;
                            rec."Template Document"::"Transport Container":
                                BEGIN
                                    TransportContainer.GET(rec."Template Document No.");
                                    Package_OnAfterValidateEvent_TransportContainerTemplateDocumentNo(xRec, Rec, CurrFieldNo, TransportContainer);
                                END;
                            ELSE BEGIN
                                Package_OnAfterValidateEvent_UnknownTemplateDocumentNo(xRec, Rec, CurrFieldNo, IsHandled);
                                IF NOT IsHandled THEN
                                    rec.FIELDERROR(rec."Template Document");
                            END;
                        END;
                    end;
                end;
            end;
        end;
    end;

    procedure IsInternationalShipment(Package: Record "ETI-Package-NC") InternationalShipment: Boolean
    begin
        InternationalShipment := (Package."Ship-to Country/Region Code" <> '') and (Package."Ship-to Country/Region Code" <> Package."ESNShip-from Coun/Reg CodeShip") and not IsEUShipment(Package);
    end;

    procedure IsEUShipment(Package: Record "ETI-Package-NC") EUShipment: Boolean
    var
        ShipToCountry: Record "Country/Region";
        ShipFromCountry: Record "Country/Region";
    begin
        if ShipToCountry.get(Package."Ship-to Country/Region Code") then;
        if ShipFromCountry.get(Package."ESNShip-from Coun/Reg CodeShip") then;
        EUShipment := (ShipToCountry."EU Country/Region Code" <> '') and (ShipFromCountry."EU Country/Region Code" <> '');
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBefore_Package_OnAfterValidateEvent_TemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure Package_OnAfterValidateEvent_UnknownTemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure Package_OnAfterValidateEvent_PackageTemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer; Package: Record "ETI-Package-NC")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure Package_OnAfterValidateEvent_RegPackageTemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer; RegPackage: Record "ETI-Reg. Package-NC")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure Package_OnAfterValidateEvent_TransportContainerTemplateDocumentNo(var xRec: Record "ETI-Package-NC"; var Rec: Record "ETI-Package-NC"; CurrFieldNo: Integer; TransportContainer: Record "ETI-Transport Container-NC")
    begin
    end;
    #endregion

    #region reg. package
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnAfterRegisterPackage', '', true, false)]
    local procedure PackageMgt_OnAfterRegisterPackage(var Package: Record "ETI-Package-NC")
    var
        Package2: Record "ETI-Package-NC";
        PackageMgt: Codeunit "ETI-Package Mgt-NC";
    begin
        if Package."ESNShipment No.Ship" <> '' then begin
            Package2.SetRange("ESNShipment No.Ship", Package."ESNShipment No.Ship");
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
        if RegPackage."ESNShipment No.Ship" <> '' then begin
            RegPackage2.SetRange("ESNShipment No.Ship", RegPackage."ESNShipment No.Ship");
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

    procedure IsInternationalShipment(RegPackage: Record "ETI-Reg. Package-NC") InternationalShipment: Boolean
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.TransferFields(RegPackage);
        exit(IsInternationalShipment(Package));
    end;

    procedure IsEUShipment(RegPackage: Record "ETI-Reg. Package-NC") DomesticShipment: Boolean
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.TransferFields(RegPackage);
        exit(IsEUShipment(Package));
    end;
    #endregion

}