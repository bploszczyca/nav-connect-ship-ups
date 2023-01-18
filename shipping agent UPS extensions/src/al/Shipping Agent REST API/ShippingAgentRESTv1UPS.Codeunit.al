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
    var
        RequestHttpClient: HttpClient;
        RequestHttpContent: HttpContent;
        ResponseHttpMessage: HttpResponseMessage;
        TransId: Guid;

        ShipmentRequestContent: Text;
    begin
        AddAccessDataTottpHeader(Package, RequestHttpClient.DefaultRequestHeaders());
        RequestHttpClient.DefaultRequestHeaders().Add(GetTransactionSrcHttpHeaderTag, GetTransactionSrcHttpHeaderTagContent);
        RequestHttpClient.DefaultRequestHeaders().Add(GetTransIdHttpHeaderTag, GetTransIdHttpHeaderTagContent(TransId));

        GetShipmentRequestContent(Package).WriteTo(ShipmentRequestContent);

        Message('ShipmentRequestContent: %1', ShipmentRequestContent);

        RequestHttpContent.WriteFrom(ShipmentRequestContent);

        RequestHttpClient.Post(Package.GetShippingAgent().GetShippingURL(), RequestHttpContent, ResponseHttpMessage);

        CheckResponseMessage(ResponseHttpMessage, true);

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


    #region HttpHeaders
    local procedure GetTransactionSrcHttpHeaderTag(): Text
    begin
        exit('transactionSrc');
    end;

    local procedure GetTransactionSrcHttpHeaderTagContent(): Text
    begin
        exit('Microsoft Business Central: Etiscan NAVConnect - Ship UPS');
    end;

    local procedure GetTransIdHttpHeaderTag(): Text
    begin
        exit('transId');
    end;

    local procedure GetTransIdHttpHeaderTagContent(var TransId: Guid): Text
    begin
        if IsNullGuid(TransId) then
            TransId := CreateGuid();
        exit(Format(TransId));
    end;

    local procedure GetAccessLicenseNumberHttpHeaderTag(): Text
    begin
        exit('AccessLicenseNumber');
    end;

    local procedure GetAccessLicenseNumberHttpHeaderTagContent(ShippingAgent: Record "Shipping Agent"): Text
    begin
        exit(ShippingAgent."ESNAccess KeyUPS");
    end;

    local procedure GetUsernameHttpHeaderTag(): Text
    begin
        exit('Username');
    end;

    local procedure GetUsernameHttpHeaderTagContent(ShippingAgent: Record "Shipping Agent"): Text
    begin
        exit(ShippingAgent."ESNUser NameUPS");
    end;

    local procedure GetPasswordHttpHeaderTag(): Text
    begin
        exit('Password');
    end;

    local procedure GetPasswordHttpHeaderTagContent(ShippingAgent: Record "Shipping Agent"): Text
    begin
        exit(ShippingAgent."ESNUser PasswordUPS");
    end;

    local procedure AddAccessDataTottpHeader(Package: Record "ETI-Package-NC"; RequestHttpHeaders: HttpHeaders)
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if Package.GetShippingAgent(ShippingAgent) then begin
            RequestHttpHeaders.Add(GetAccessLicenseNumberHttpHeaderTag, GetAccessLicenseNumberHttpHeaderTagContent(ShippingAgent));
            RequestHttpHeaders.Add(GetUsernameHttpHeaderTag, GetUsernameHttpHeaderTagContent(ShippingAgent));
            RequestHttpHeaders.Add(GetPasswordHttpHeaderTag(), GetPasswordHttpHeaderTagContent(ShippingAgent));
        end;
    end;
    #endregion

    #region ResponseHttpMessage
    local procedure CheckResponseMessage(ResponseHttpMessage: HttpResponseMessage; ShowInfo: Boolean)
    begin
        if not ResponseHttpMessage.IsBlockedByEnvironment and ResponseHttpMessage.IsSuccessStatusCode and ShowInfo then begin
            Message('StatusCode: %1, %2', ResponseHttpMessage.HttpStatusCode, ResponseHttpMessage.ReasonPhrase);
        end else begin
            Error('StatusCode: %1, %2', ResponseHttpMessage.HttpStatusCode, ResponseHttpMessage.ReasonPhrase);
        end;
    end;
    #endregion

    #region 
    local procedure GetShipmentRequestContent(Package: Record "ETI-Package-NC") ShipmentRequest: JsonObject
    begin
        ShipmentRequest.Add('ShipmentRequest', GetShipmentRequest_ShipmentContent(Package));
    end;

    local procedure GetShipmentRequest_ShipmentContent(Package: Record "ETI-Package-NC") ShipmentContent: JsonObject
    var
        Shipment: JsonObject;
    begin
        if Package."ESNShipment DescriptionShip" <> '' then
            ShipmentContent.Add('Description', Package."ESNShipment DescriptionShip");

        GetShipmentRequest_Shipment_ReturnServiceContent(Package, ShipmentContent);
        GetShipmentRequest_Shipment_ShipperContent(Package, ShipmentContent);
        GetShipmentRequest_Shipment_ShipTo(Package, ShipmentContent);
        GetShipmentRequest_Shipment_ShipFrom(Package, ShipmentContent);
    end;

    local procedure GetShipmentRequest_Shipment_ReturnServiceContent(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        ReturnServiceCode: JsonObject;
    begin
        // Required: No
        if Package."ESNReturn ServiceUPS" <> Package."ESNReturn ServiceUPS"::" " then begin
            ReturnServiceCode.Add('Code', Package."ESNReturn ServiceUPS".AsInteger());
            ShipmentContent.Add('ReturnService', ReturnServiceCode);
        end;
    end;

    local procedure GetShipmentRequest_Shipment_ShipperContent(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;

        ShippingAgent: Record "Shipping Agent";

        Shipper: JsonObject;
        ShipperPhoneNo: JsonObject;
        ShipperFaxNo: Text;
        ShipperEMailAddress: Text;
    begin
        // Required: No
        if Package."ESNShip-from NameShip" <> '' then
            Shipper.Add('Name', CopyStr(Package."ESNShip-from NameShip", 1, 35));

        // Required: Cond
        // Required if destination is international. 
        // Required if Invoice and CO International forms are requested and the ShipFrom address is not present.
        if Package.IsInternationalShipment() then begin
            Package.TestField("ESNShip-from ContactShip");
            Shipper.Add('AttentionName', CopyStr(Package."ESNShip-from ContactShip", 1, 35));
        end;

        // Required: Cond
        // Shipper’s Tax Identification Number.
        // Conditionally required if EEI form (International forms) is requested and ship From is not mentioned.
        if Package.IsInternationalShipment() then begin
            case Package."ESNShip-from TypeShip" of
                Package."ESNShip-from TypeShip"::Contact:
                    begin
                        Package.TestField("ESNShip-from No.Ship");
                        Contact.get(Package."ESNShip-from No.Ship");
                        Contact.TestField("VAT Registration No.");
                        Shipper.Add('TaxIdentificationNumber', CopyStr(Contact."VAT Registration No.", 1, 15));
                    end;
                else begin
                    CompanyInfo.get();
                    CompanyInfo.TestField("VAT Registration No.");
                    Shipper.Add('TaxIdentificationNumber', CopyStr(CompanyInfo."VAT Registration No.", 1, 15));
                end;
            end;
        end;

        // Required: Yes*
        Shipper.Add('Phone', GetShipperPhoneNo(Package));

        // Required: Yes
        ShippingAgent := Package.GetShippingAgent();
        ShippingAgent.TestField("ESNAccount NumberUPS");
        Shipper.Add('ShipperNumber', ShippingAgent."ESNAccount NumberUPS");

        // Required: No
        if GetShipperFaxNo(Package, ShipperFaxNo) then
            Shipper.Add('FaxNumber', ShipperFaxNo);

        // Required: No
        if GetShipperEMailAddress(Package, ShipperEMailAddress) then
            Shipper.Add('EMailAddress', ShipperEMailAddress);

        // Required: Yes
        Shipper.Add('Address', GetShipperAddress(Package));

        ShipmentContent.Add('Shipper', Shipper);
    end;


    local procedure GetShipmentRequest_Shipment_ShipTo(Package: Record "ETI-Package-NC"; ShipToContent: JsonObject)
    var
        ShipTo: JsonObject;
        ShipToPhoneNo: JsonObject;

        ShipToFaxNo: Text;
        ShipToEMailAddress: Text;
        ShipToText: Text;
    begin
        // Required: Yes
        Package.TestField("Ship-to Name");
        ShipToText := Package."Ship-to Name";
        if Package."Ship-to Name 2" <> '' then
            ShipToText += ', ' + Package."Ship-to Name 2";
        ShipTo.Add('Name', CopyStr(ShipToText, 1, 35));

        if Package.IsInternationalShipment() then begin
            Package.TestField("Ship-to Contact");
            ShipTo.Add('AttentionName', CopyStr(Package."Ship-to Contact", 1, 35));
        end;

        // Required: Yes*
        if GetShipToPhoneNo(Package, ShipToPhoneNo) then
            ShipTo.Add('Phone', ShipToPhoneNo);

        // Required: No
        if GetShipToFaxNo(Package, ShipToFaxNo) then
            ShipTo.Add('FaxNumber', ShipToFaxNo);

        // Required: No
        if GetShipToEMailAddress(Package, ShipToEMailAddress) then
            ShipTo.Add('EMailAddress', ShipToEMailAddress);

        // Required: Yes
        ShipTo.Add('Address', GetShipToAddress(Package));

        ShipToContent.Add('ShipTo', ShipTo);
    end;

    local procedure GetShipmentRequest_Shipment_ShipFrom(Package: Record "ETI-Package-NC"; ShipFromContent: JsonObject)
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;

        ShipFrom: JsonObject;
        ShipperFaxNo: Text;
        ShipperEMailAddress: Text;
        ShipFromText: Text;
    begin
        // Required: Yes
        Package.TestField("ESNShip-from NameShip");
        ShipFromText := Package."ESNShip-from NameShip";
        if Package."ESNShip-from Name 2Ship" <> '' then
            ShipFromText += ', ' + Package."ESNShip-from Name 2Ship";
        ShipFrom.Add('Name', CopyStr(ShipFromText, 1, 35));

        // Required: Cond
        // Required if destination is international. 
        // Required if Invoice and CO International forms are requested and the ShipFrom address is not present.
        if Package.IsInternationalShipment() then begin
            Package.TestField("ESNShip-from ContactShip");
            ShipFrom.Add('AttentionName', CopyStr(Package."ESNShip-from ContactShip", 1, 35));
        end;

        // Required: Cond
        // Shipper’s Tax Identification Number.
        // Conditionally required if EEI form (International forms) is requested and ship From is not mentioned.
        if Package.IsInternationalShipment() then begin
            case Package."ESNShip-from TypeShip" of
                Package."ESNShip-from TypeShip"::Contact:
                    begin
                        Package.TestField("ESNShip-from No.Ship");
                        Contact.get(Package."ESNShip-from No.Ship");
                        Contact.TestField("VAT Registration No.");
                        ShipFrom.Add('TaxIdentificationNumber', CopyStr(Contact."VAT Registration No.", 1, 15));
                    end;
                else begin
                    CompanyInfo.get();
                    CompanyInfo.TestField("VAT Registration No.");
                    ShipFrom.Add('TaxIdentificationNumber', CopyStr(CompanyInfo."VAT Registration No.", 1, 15));
                end;
            end;
        end;

        // Required: Yes*
        ShipFrom.Add('Phone', GetShipperPhoneNo(Package));

        // Required: No
        if GetShipperFaxNo(Package, ShipperFaxNo) then
            ShipFrom.Add('FaxNumber', ShipperFaxNo);

        // Required: No
        if GetShipperEMailAddress(Package, ShipperEMailAddress) then
            ShipFrom.Add('EMailAddress', ShipperEMailAddress);

        // Required: Yes
        ShipFrom.Add('Address', GetShipperAddress(Package));

        ShipFromContent.Add('ShipFrom', ShipFrom);
    end;
    #endregion

    #region etc.
    local procedure GetShipperPhoneNo(Package: Record "ETI-Package-NC") ShipperPhoneNo: JsonObject
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;
    begin
        case Package."ESNShip-from TypeShip" of
            Package."ESNShip-from TypeShip"::"Responsibility Center":
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    ResponsibilityCenter.get(Package."ESNShip-from No.Ship");
                    ResponsibilityCenter.TestField("Phone No.");
                    ShipperPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(ResponsibilityCenter."Phone No."))
                end;
            Package."ESNShip-from TypeShip"::Location:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Location.get(Package."ESNShip-from No.Ship");
                    Location.TestField("Phone No.");
                    ShipperPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Location."Phone No."))
                end;
            Package."ESNShip-from TypeShip"::Contact:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Contact.get(Package."ESNShip-from No.Ship");
                    Contact.TestField("Phone No.");
                    ShipperPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Contact."Phone No."));
                end;
            else begin
                CompanyInfo.get();
                CompanyInfo.TestField("Phone No.");
                ShipperPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(CompanyInfo."Phone No."));
            end;
        end;
    end;

    local procedure GetShipperFaxNo(Package: Record "ETI-Package-NC"; var ShipperFaxNo: Text) AddShipperFaxNo: Boolean
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;
    begin
        case Package."ESNShip-from TypeShip" of
            Package."ESNShip-from TypeShip"::"Responsibility Center":
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    ResponsibilityCenter.get(Package."ESNShip-from No.Ship");
                    ResponsibilityCenter.TestField("Fax No.");
                    ShipperFaxNo := GetUPSFormatedShipperPhoneNo(ResponsibilityCenter."Fax No.");
                end;
            Package."ESNShip-from TypeShip"::Location:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Location.get(Package."ESNShip-from No.Ship");
                    Location.TestField("Fax No.");
                    ShipperFaxNo := GetUPSFormatedShipperPhoneNo(Location."Fax No.");
                end;
            Package."ESNShip-from TypeShip"::Contact:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Contact.get(Package."ESNShip-from No.Ship");
                    Contact.TestField("Fax No.");
                    ShipperFaxNo := GetUPSFormatedShipperPhoneNo(Contact."Fax No.");
                end;
            else begin
                CompanyInfo.get();
                CompanyInfo.TestField("Fax No.");
                ShipperFaxNo := GetUPSFormatedShipperPhoneNo(CompanyInfo."Fax No.");
            end;
        end;
        AddShipperFaxNo := ShipperFaxNo <> '';
    end;

    local procedure GetShipperEMailAddress(Package: Record "ETI-Package-NC"; var ShipperEMailAddress: Text) AddShipperEMailAddress: Boolean
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;
    begin
        // Required: No
        case Package."ESNShip-from TypeShip" of
            Package."ESNShip-from TypeShip"::"Responsibility Center":
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    ResponsibilityCenter.get(Package."ESNShip-from No.Ship");
                    ShipperEMailAddress := CopyStr(ResponsibilityCenter."E-Mail", 1, 50);
                end;
            Package."ESNShip-from TypeShip"::Location:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Location.get(Package."ESNShip-from No.Ship");
                    ShipperEMailAddress := CopyStr(Location."E-Mail", 1, 50);
                end;
            Package."ESNShip-from TypeShip"::Contact:
                begin
                    Package.TestField("ESNShip-from No.Ship");
                    Contact.get(Package."ESNShip-from No.Ship");
                    ShipperEMailAddress := CopyStr(Contact."E-Mail", 1, 50);
                end;
            else begin
                CompanyInfo.get();
                ShipperEMailAddress := CopyStr(CompanyInfo."E-Mail", 1, 50);
            end;
        end;
        AddShipperEMailAddress := ShipperEMailAddress <> '';
    end;

    local procedure GetShipperAddress(Package: Record "ETI-Package-NC") ShipperAddress: JsonObject
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;
        CountryRegion: Record "Country/Region";

        ShipFromText: Text;
    begin
        // AddressLine
        // Required: Yes
        Package.TestField("ESNShip-from AddressShip");
        ShipFromText := Package."ESNShip-from AddressShip";
        if Package."ESNShip-from Address 2Ship" <> '' then
            ShipFromText += ', ' + Package."ESNShip-from Address 2Ship";
        ShipperAddress.Add('AddressLine', CopyStr(ShipFromText, 1, 35));

        // Required: Yes
        Package.TestField("ESNShip-from CityShip");
        ShipperAddress.Add('City', CopyStr(Package."ESNShip-from CityShip", 1, 30));

        // Required: Cond
        if (Package."ESNShip-from CountyShip" <> '') and (StrLen(Package."ESNShip-from CountyShip") >= 2) then begin
            ShipperAddress.Add('StateProvinceCode', CopyStr(Package."ESNShip-from CountyShip", 1, 5));
        end;

        // Required: Yes
        Package.TestField("ESNShip-from Post CodeShip");
        ShipperAddress.Add('PostalCode', CopyStr(Package."ESNShip-from Post CodeShip", 1, 9));

        // Required: Yes
        if Package."ESNShip-from Coun/Reg CodeShip" <> '' then begin
            CountryRegion.get(Package."ESNShip-from Coun/Reg CodeShip");
            CountryRegion.TestField("ISO Code");
            ShipperAddress.Add('CountryCode', CopyStr(CountryRegion."ISO Code", 1, 2));
        end;
    end;

    local procedure GetShipToPhoneNo(Package: Record "ETI-Package-NC"; ShipToPhoneNo: JsonObject) AddShipToPhoneNo: Boolean
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Contact: Record Contact;
        Location: Record Location;
    begin
        // Required: Yes*
        case Package."Ship-to Type" of
            Package."Ship-to Type"::Contact:
                begin
                    Package.TestField("Ship-to No.");
                    Contact.get(Package."Ship-to No.");
                    if Package.IsInternationalShipment() then
                        Contact.TestField("Phone No.");
                    ShipToPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Contact."Phone No."));
                    AddShipToPhoneNo := Contact."Phone No." <> '';
                end;
            Package."Ship-to Type"::Customer:
                begin
                    Package.TestField("Ship-to No.");
                    Customer.get(Package."Ship-to No.");
                    if Package.IsInternationalShipment() then
                        Customer.TestField("Phone No.");
                    ShipToPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Customer."Phone No."));
                    AddShipToPhoneNo := Customer."Phone No." <> '';
                end;
            Package."Ship-to Type"::Location:
                begin
                    Package.TestField("Ship-to No.");
                    Location.get(Package."Ship-to No.");
                    if Package.IsInternationalShipment() then
                        Location.TestField("Phone No.");
                    ShipToPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Location."Phone No."));
                    AddShipToPhoneNo := Location."Phone No." <> '';
                end;
            Package."Ship-to Type"::Vendor:
                begin
                    Package.TestField("Ship-to No.");
                    Vendor.get(Package."Ship-to No.");
                    if Package.IsInternationalShipment() then
                        Vendor.TestField("Phone No.");
                    ShipToPhoneNo.Add('Number', GetUPSFormatedShipperPhoneNo(Vendor."Phone No."));
                    AddShipToPhoneNo := Vendor."Phone No." <> '';
                end;
            else begin
                Package.FieldError("Ship-to Type");
            end;
        end;
    end;

    local procedure GetShipToFaxNo(Package: Record "ETI-Package-NC"; var ShipToFaxNo: Text) AddShipToFaxNo: Boolean
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Contact: Record Contact;
        Location: Record Location;
    begin
        // Required: No
        case Package."Ship-to Type" of
            Package."Ship-to Type"::Contact:
                begin
                    Package.TestField("Ship-to No.");
                    Contact.get(Package."Ship-to No.");
                    ShipToFaxNo := GetUPSFormatedShipperPhoneNo(Contact."Fax No.");
                end;
            Package."Ship-to Type"::Customer:
                begin
                    Package.TestField("Ship-to No.");
                    Customer.get(Package."Ship-to No.");
                    ShipToFaxNo := GetUPSFormatedShipperPhoneNo(Customer."Fax No.");
                end;
            Package."Ship-to Type"::Location:
                begin
                    Package.TestField("Ship-to No.");
                    Location.get(Package."Ship-to No.");
                    ShipToFaxNo := GetUPSFormatedShipperPhoneNo(Location."Fax No.");
                end;
            Package."Ship-to Type"::Vendor:
                begin
                    Package.TestField("Ship-to No.");
                    Vendor.get(Package."Ship-to No.");
                    ShipToFaxNo := GetUPSFormatedShipperPhoneNo(Vendor."Fax No.");
                end;
            else begin
                Package.FieldError("Ship-to Type");
            end;
        end;
        AddShipToFaxNo := ShipToFaxNo <> '';
    end;

    local procedure GetShipToEMailAddress(Package: Record "ETI-Package-NC"; var ShipToEMailAddress: Text) AddShipToEMailAddress: Boolean
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Contact: Record Contact;
        Location: Record Location;
    begin
        // Required: No
        case Package."Ship-to Type" of
            Package."Ship-to Type"::Contact:
                begin
                    Package.TestField("Ship-to No.");
                    Contact.get(Package."Ship-to No.");
                    ShipToEMailAddress := CopyStr(Contact."E-Mail", 1, 50);
                end;
            Package."Ship-to Type"::Customer:
                begin
                    Package.TestField("Ship-to No.");
                    Customer.get(Package."Ship-to No.");
                    ShipToEMailAddress := CopyStr(Customer."E-Mail", 1, 50);
                end;
            Package."Ship-to Type"::Location:
                begin
                    Package.TestField("Ship-to No.");
                    Location.get(Package."Ship-to No.");
                    ShipToEMailAddress := CopyStr(Location."E-Mail", 1, 50);
                end;
            Package."Ship-to Type"::Vendor:
                begin
                    Package.TestField("Ship-to No.");
                    Vendor.get(Package."Ship-to No.");
                    ShipToEMailAddress := CopyStr(Vendor."E-Mail", 1, 50);
                end;
            else begin
                Package.FieldError("Ship-to Type");
            end;
        end;
        AddShipToEMailAddress := ShipToEMailAddress <> '';
    end;

    local procedure GetShipToAddress(Package: Record "ETI-Package-NC") ShipToAddress: JsonObject
    var
        CompanyInfo: Record "Company Information";
        Contact: Record Contact;
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record Location;
        CountryRegion: Record "Country/Region";

        ShipToText: Text;
    begin
        // AddressLine
        // Required: Yes
        Package.TestField("ship-to Address");
        ShipToText := Package."ship-to Address";
        if Package."ship-to Address 2" <> '' then
            ShipToText += ', ' + Package."ship-to Address 2";
        ShipToAddress.Add('AddressLine', CopyStr(ShipToText, 1, 35));

        // Required: Yes
        Package.TestField("ship-to City");
        ShipToAddress.Add('City', CopyStr(Package."ship-to City", 1, 30));

        // Required: Cond
        if (Package."ship-to County" <> '') and (StrLen(Package."ship-to County") >= 2) then begin
            ShipToAddress.Add('StateProvinceCode', CopyStr(Package."ship-to County", 1, 5));
        end;

        // Required: Yes
        Package.TestField("ship-to Post Code");
        ShipToAddress.Add('PostalCode', CopyStr(Package."ship-to Post Code", 1, 9));

        // Required: Yes
        if Package."Ship-to Country/Region Code" <> '' then begin
            CountryRegion.get(Package."Ship-to Country/Region Code");
            CountryRegion.TestField("ISO Code");
            ShipToAddress.Add('CountryCode', CopyStr(CountryRegion."ISO Code", 1, 2));
        end;
    end;

    local procedure GetUPSFormatedShipperPhoneNo(ShipperPhoneNo: Text) UPSFormatedShipperPhoneNo: Text
    begin
        // TODO
        UPSFormatedShipperPhoneNo := CopyStr(ShipperPhoneNo, 1, 15);
    end;
    #endregion

}