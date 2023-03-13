codeunit 70869802 "ESNShip. Agent REST v1807UPS" implements "ESNShipping Agent RESTUPS", "ESNShipping Agent APIShip"
{
    var
        ShippingAgentFnc: Codeunit "ESNShipping Agent FncUPS";

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
    var
        Errorcode: List of [Text];
        ErrorcodeTxt: Text;
        Errordescription: List of [Text];
        ErrordescriptionTxt: Text;

    // HeadersKey: Text;
    // HeadersKeyJson: JsonObject;
    // HeadersKeyValues: list of [Text];
    // HeadersKeyValuesTxt: Text;
    // ResponseHttpMessageHeaders: Text;
    begin
        if not ResponseHttpMessage.IsBlockedByEnvironment and ResponseHttpMessage.IsSuccessStatusCode and ShowInfo then begin
            Message('StatusCode: %1, %2', ResponseHttpMessage.HttpStatusCode, ResponseHttpMessage.ReasonPhrase);
        end else begin
            // foreach HeadersKey in ResponseHttpMessage.Headers().Keys() do begin
            //     if ResponseHttpMessage.Headers().Contains(HeadersKey) then begin
            //         Clear(Errorcode);
            //         if ResponseHttpMessage.Headers().GetValues(HeadersKey, Errorcode) then begin
            //             Errorcode.get(1, ErrorcodeTxt);
            //             HeadersKeyJson.Add(HeadersKey, ErrorcodeTxt);
            //         end;
            //     end;
            // end;
            // HeadersKeyJson.WriteTo(ResponseHttpMessageHeaders);
            // Message('ResponseHttpMessageHeaders: %1', ResponseHttpMessageHeaders);
            // Clear(Errorcode);

            if ResponseHttpMessage.Headers().Contains('errorcode') then begin
                if ResponseHttpMessage.Headers().GetValues('errorcode', Errorcode) then begin
                    Errorcode.get(1, ErrorcodeTxt);
                end;
            end;
            if ResponseHttpMessage.Headers().Contains('errordescription') then begin
                if ResponseHttpMessage.Headers().GetValues('errordescription', errordescription) then begin
                    errordescription.get(1, ErrordescriptionTxt);
                end;
            end;
            if ErrorcodeTxt <> '' then begin
                Error('Errorcode: %1, %2', ErrorcodeTxt, ErrordescriptionTxt);
            end else begin
                Error('StatusCode: %1, %2', ResponseHttpMessage.HttpStatusCode, ResponseHttpMessage.ReasonPhrase);
            end;
        end;
    end;
    #endregion

    #region 
    local procedure GetShipmentRequestContent(Package: Record "ETI-Package-NC") ShipmentRequest: JsonObject
    var
        ShipmentContentContent: JsonObject;
    begin
        ShipmentContentContent.Add('Shipment', GetShipmentRequest_ShipmentContent(Package));
        ShipmentContentContent.Add('LabelSpecification', GetShipmentRequest_LabelSpecification(Package));

        ShipmentRequest.Add('ShipmentRequest', ShipmentContentContent);
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
        GetShipmentRequest_Shipment_PaymentInformation(Package, ShipmentContent);   // Keine PromotionalDiscountInformation möglich!
        // Schnistellen kann keine "FreightShipmentInformation"."FreightDensityInfo".("AdjustedHeight", "HandlingUnits")
        GetShipmentRequest_Shipment_MovementReferenceNumber(Package, ShipmentContent);
        GetShipmentRequest_Shipment_Service(Package, ShipmentContent);
        GetShipmentRequest_Shipment_NumOfPiecesInShipment(Package, ShipmentContent);
        GetShipmentRequest_Shipment_MILabelCN22Indicator(Package, ShipmentContent);
        GetShipmentRequest_Shipment_CostCenter(Package, ShipmentContent);
        GetShipmentRequest_Shipment_RatingMethodRequestedIndicator(Package, ShipmentContent);
        GetShipmentRequest_Shipment_TaxInformationIndicator(Package, ShipmentContent);
        GetShipmentRequest_Shipment_ShipmentServiceOptions(Package, ShipmentContent);

        GetShipmentRequest_Shipment_Packages(Package, ShipmentContent);
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

    local procedure GetShipmentRequest_Shipment_PaymentInformation(Package: Record "ETI-Package-NC"; ShipFromContent: JsonObject)
    var
        ShipmentChargeJsonObject: JsonObject;
        ShipmentChargeJsonArray: JsonArray;

        ShipmentChargeTransportationInformation: JsonObject;
        ShipmentChargeDutiesAndTaxesInformation: JsonObject;
    begin
        if not Package.IsInternationalShipment() then begin
            GetShipmentRequest_Shipment_PaymentInformation_ShipmentCharge_Transportation(Package, ShipmentChargeTransportationInformation);
            ShipmentChargeJsonObject.Add('ShipmentCharge', ShipmentChargeTransportationInformation);
        end else begin
            GetShipmentRequest_Shipment_PaymentInformation_ShipmentCharge_Transportation(Package, ShipmentChargeTransportationInformation);
            ShipmentChargeJsonArray.Add(ShipmentChargeTransportationInformation);
            GetShipmentRequest_Shipment_PaymentInformation_ShipmentCharge_DutiesAndTaxes(Package, ShipmentChargeDutiesAndTaxesInformation);
            ShipmentChargeJsonArray.Add(ShipmentChargeDutiesAndTaxesInformation);

            ShipmentChargeJsonObject.Add('ShipmentCharge', ShipmentChargeJsonArray);
        end;
        ShipFromContent.Add('PaymentInformation', ShipmentChargeJsonObject);
    end;

    local procedure GetShipmentRequest_Shipment_PaymentInformation_ShipmentCharge_Transportation(Package: Record "ETI-Package-NC"; ShipmentChargeTransportationInformation: JsonObject)
    var
        ShippingAgent: Record "Shipping Agent";

        BillShipper: JsonObject;
        BillShipperCredCard: JsonObject;
        BillReceiver: JsonObject;
        BillThirdParty: JsonObject;
    begin
        ShipmentChargeTransportationInformation.Add('Type', '01');

        ShippingAgent := Package.GetShippingAgent();
        case ShippingAgent."ESNTransportation PaymentUPS" of
            ShippingAgent."ESNTransportation PaymentUPS"::"Bill Shipper":
                begin
                    case ShippingAgent."ESNTransBillShip Pay TypeUPS" of
                        ShippingAgent."ESNTransBillShip Pay TypeUPS"::"UPS Account Number":
                            begin
                                ShippingAgent.TestField("ESNAccount NumberUPS");
                                BillShipper.Add('AccountNumber', ShippingAgent."ESNAccount NumberUPS");
                            end;
                        ShippingAgent."ESNTransBillShip Pay TypeUPS"::"Credit Card":
                            begin
                                ShippingAgent.TestField("ESNTransBillShipCredit CardUPS");
                                ShippingAgent.TestField("ESNTransBillShipCard NumberUPS");
                                ShippingAgent.TestField("ESNTransBillShipCard Exp. UPS");
                                ShippingAgent.TestField("ESNTransBillShipCard Sec. UPS");
                                BillShipperCredCard.Add('Type', GetUPSFormated2CharType(ShippingAgent."ESNTransBillShipCredit CardUPS".AsInteger()));
                                BillShipperCredCard.Add('Number', ShippingAgent."ESNTransBillShipCard NumberUPS");
                                BillShipperCredCard.Add('ExpirationDate', GetUPSFormatedCredCardExpDate(ShippingAgent."ESNTransBillShipCard Exp. UPS"));
                                BillShipperCredCard.Add('SecurityCode', ShippingAgent."ESNTransBillShipCard Sec. UPS");

                                BillShipper.Add('CreditCard', BillShipperCredCard);
                            end;
                    end;
                    ShipmentChargeTransportationInformation.Add('BillShipper', BillShipper)
                end;
            ShippingAgent."ESNTransportation PaymentUPS"::"Bill Receiver":
                begin
                    ShippingAgent.TestField("ESNTransBillReceiver AccUPS");
                    BillReceiver.Add('AccountNumber', ShippingAgent."ESNTransBillReceiver AccUPS");

                    ShipmentChargeTransportationInformation.Add('BillReceiver', BillReceiver)
                end;
            ShippingAgent."ESNTransportation PaymentUPS"::"Bill Third Party":
                begin
                    ShippingAgent.TestField("ESNTransBillThird AccUPS");
                    BillThirdParty.Add('AccountNumber', ShippingAgent."ESNTransBillThird AccUPS");

                    ShipmentChargeTransportationInformation.Add('BillThirdParty', BillThirdParty)
                end;
            else begin
                ShippingAgent.FieldError("ESNTransportation PaymentUPS");
            end;
        end;
    end;

    local procedure GetShipmentRequest_Shipment_PaymentInformation_ShipmentCharge_DutiesAndTaxes(Package: Record "ETI-Package-NC"; ShipmentChargeTransportationInformation: JsonObject)
    var
        ShippingAgent: Record "Shipping Agent";

        BillShipper: JsonObject;
        BillShipperCredCard: JsonObject;
        BillReceiver: JsonObject;
        BillThirdParty: JsonObject;
    begin
        if Package.IsInternationalShipment() then begin
            ShipmentChargeTransportationInformation.Add('Type', '02');

            ShippingAgent := Package.GetShippingAgent();
            case ShippingAgent."ESNDuty PaymentUPS" of
                ShippingAgent."ESNDuty PaymentUPS"::"Bill Shipper":
                    begin
                        case ShippingAgent."ESNDutyBillShip Pay. TypeUPS" of
                            ShippingAgent."ESNDutyBillShip Pay. TypeUPS"::"UPS Account Number":
                                begin
                                    ShippingAgent.TestField("ESNAccount NumberUPS");
                                    BillShipper.Add('AccountNumber', ShippingAgent."ESNAccount NumberUPS");
                                end;
                            ShippingAgent."ESNDutyBillShip Pay. TypeUPS"::"Credit Card":
                                begin
                                    ShippingAgent.TestField("ESNDutyBillShipCredit CardUPS");
                                    ShippingAgent.TestField("ESNDutyBillShipCard NumberUPS");
                                    ShippingAgent.TestField("ESNDutyBillShipCard Exp. UPS");
                                    ShippingAgent.TestField("ESNDutyBillShipCard Sec. UPS");
                                    BillShipperCredCard.Add('Type', GetUPSFormated2CharType(ShippingAgent."ESNDutyBillShipCredit CardUPS".AsInteger()));
                                    BillShipperCredCard.Add('Number', ShippingAgent."ESNDutyBillShipCard NumberUPS");
                                    BillShipperCredCard.Add('ExpirationDate', GetUPSFormatedCredCardExpDate(ShippingAgent."ESNDutyBillShipCard Exp. UPS"));
                                    BillShipperCredCard.Add('SecurityCode', ShippingAgent."ESNDutyBillShipCard Sec. UPS");

                                    BillShipper.Add('CreditCard', BillShipperCredCard);
                                end;
                        end;
                        ShipmentChargeTransportationInformation.Add('BillShipper', BillShipper)
                    end;
                ShippingAgent."ESNDuty PaymentUPS"::"Bill Receiver":
                    begin
                        ShippingAgent.TestField("ESNDutyBillReceiver AccUPS");
                        BillReceiver.Add('AccountNumber', ShippingAgent."ESNDutyBillReceiver AccUPS");

                        ShipmentChargeTransportationInformation.Add('BillReceiver', BillReceiver)
                    end;
                ShippingAgent."ESNDuty PaymentUPS"::"Bill Third Party":
                    begin
                        ShippingAgent.TestField("ESNDutyBillThird AccUPS");
                        BillThirdParty.Add('AccountNumber', ShippingAgent."ESNDutyBillThird AccUPS");

                        ShipmentChargeTransportationInformation.Add('BillThirdParty', BillThirdParty)
                    end;
                else begin
                    ShippingAgent.FieldError("ESNDuty PaymentUPS");
                end;
            end;
        end;
    end;

    local procedure GetShipmentRequest_Shipment_MovementReferenceNumber(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        ShippingAgent: Record "Shipping Agent";
        CountryRegion: Record "Country/Region";
        CharacterMustBeequalLbl: Label '3th and 4th character of %1 must be "%2".';
        HasToBe18CharLbl: Label '%1 has to be 18 characters long.';
    begin
        // Required: No
        ShippingAgent := Package.GetShippingAgent();
        if ShippingAgent."ESNMovement Ref. NumberShip" <> '' then begin
            Package.TestField("ESNShip-from Coun/Reg CodeShip");
            CountryRegion.get(Package."ESNShip-from Coun/Reg CodeShip");
            CountryRegion.TestField("ISO Code");
            if CopyStr(ShippingAgent."ESNMovement Ref. NumberShip", 3, 2) <> CountryRegion."ISO Code" then begin
                Error(CharacterMustBeequalLbl, ShippingAgent.FieldCaption("ESNMovement Ref. NumberShip"), CountryRegion."ISO Code");
            end;
            if StrLen(ShippingAgent."ESNMovement Ref. NumberShip") <> 18 then begin
                Error(HasToBe18CharLbl, ShippingAgent.FieldCaption("ESNMovement Ref. NumberShip"));
            end;

            ShipmentContent.Add('MovementReferenceNumber', ShippingAgent."ESNMovement Ref. NumberShip");
        end;
    end;

    local procedure GetShipmentRequest_Shipment_Service(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        ShippingAgentService: Record "Shipping Agent Services";
        ServiceCode: JsonObject;
    begin
        // Required: Yes
        Package.TestField("Shipping Agent Code");
        Package.TestField("Shipping Agent Service Code");
        ShippingAgentService.get(Package."Shipping Agent Code", Package."Shipping Agent Service Code");
        ShippingAgentService.TestField("ESNShipment Service CodeUPS");
        ServiceCode.Add('Code', ShippingAgentService."ESNShipment Service CodeUPS");

        if ShippingAgentService.Description <> '' then begin
            ServiceCode.Add('Description', CopyStr(ShippingAgentService.Description, 1, 35));
        end;

        ShipmentContent.Add('Service', ServiceCode);
    end;

    local procedure GetShipmentRequest_Shipment_NumOfPiecesInShipment(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        Package2: Record "ETI-Package-NC";
    begin
        // Required: Yes*
        Package.TestField("ESNShipment No.Ship");
        Package2.SetRange("ESNShipment No.Ship", Package."ESNShipment No.Ship");

        ShipmentContent.Add('NumOfPiecesInShipment', Format(Package2.Count));
    end;

    local procedure GetShipmentRequest_Shipment_MILabelCN22Indicator(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    begin
        // Required: Cond*
        if Package.IsInternationalShipment() then begin
            // ShipmentContent.Add('MILabelCN22Indicator', ''); 
        end;
    end;


    local procedure GetShipmentRequest_Shipment_CostCenter(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    begin
        // Required: No
        if Package."ESNCost  IdentifierShip" <> '' then begin
            ShipmentContent.Add('CostCenter', Package."ESNCost  IdentifierShip");
        end;
    end;

    local procedure GetShipmentRequest_Shipment_RatingMethodRequestedIndicator(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    begin
        // Required: No
        ShipmentContent.Add('RatingMethodRequestedIndicator', '');
    end;

    local procedure GetShipmentRequest_Shipment_TaxInformationIndicator(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    begin
        // Required: No
        ShipmentContent.Add('TaxInformationIndicator', '');
    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        ShipmentServiceOptions: JsonObject;
    begin
        // Required: No
        if Package."ESNSaturday Delivery Req.Ship" then
            ShipmentServiceOptions.Add('SaturdayDeliveryIndicator', '');
        if Package."ESNSaturday Pickup Req.Ship" then
            ShipmentServiceOptions.Add('SaturdayPickupIndicator', '');

        // COD (Collect on Delivery) wird nicht unterstützt
        if Package."ESNDirect Delivery OnlyShip" then
            ShipmentServiceOptions.Add('DirectDeliveryOnlyIndicator', '');

        GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification(Package, ShipmentServiceOptions);
        GetShipmentRequest_Shipment_ShipmentServiceOptions_DeliveryConfirmation(Package, ShipmentServiceOptions);
        // RestrictedArticles werden nicht unterstützt

        ShipmentContent.Add('ShipmentServiceOptions', ShipmentServiceOptions);
    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification(Package: Record "ETI-Package-NC"; ShipmentServiceOptionsContent: JsonObject)
    var
        ShipmentNotification: JsonObject;
    begin
        if Package."ESNNotification CodeUPS" <> Package."ESNNotification CodeUPS"::" " then begin

            case Package."ESNNotification CodeUPS" of
                Package."ESNNotification CodeUPS"::"Alternate Delivery Location Notification",
                Package."ESNNotification CodeUPS"::"Shipper Notification":
                    begin
                        ShipmentNotification.Add('NotificationCode', GetUPSFormated3CharType(Package."ESNNotification CodeUPS".AsInteger()));
                    end;
                else begin
                    ShipmentNotification.Add('NotificationCode', Format(Package."ESNNotification CodeUPS".AsInteger()));
                end;
            end;


            GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Email(Package, ShipmentNotification);
            GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Voice(Package, ShipmentNotification);
            GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Text(Package, ShipmentNotification);

            if ShipmentNotification.Keys.Count > 0 then begin
                ShipmentServiceOptionsContent.Add('Notification', ShipmentNotification)
            end;
        end;

    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Email(Package: Record "ETI-Package-NC"; ShipmentNotificationContent: JsonObject)
    var
        EmailNotification: JsonObject;
    begin
        if Package."ESNNotification To EmailShip" <> '' then
            EmailNotification.Add('EMailAddress', CopyStr(Package."ESNNotification To EmailShip", 1, 50));
        if Package."ESNUndeli. Not. EmailShip" <> '' then
            EmailNotification.Add('UndeliverableEMailAddress', CopyStr(Package."ESNUndeli. Not. EmailShip", 1, 50));
        if Package."ESNNotification From EmailShip" <> '' then
            EmailNotification.Add('FromEMailAddress', CopyStr(Package."ESNNotification From EmailShip", 1, 50));
        if Package."ESNNotification From NameShip" <> '' then
            EmailNotification.Add('FromName', CopyStr(Package."ESNNotification From NameShip", 1, 35));
        if Package."ESNNotification Email-TextShip" <> '' then
            EmailNotification.Add('Memo', CopyStr(Package."ESNNotification Email-TextShip", 1, 50));
        if EmailNotification.Keys.Count > 0 then begin
            ShipmentNotificationContent.Add('EMail', EmailNotification)
        end;
    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Voice(Package: Record "ETI-Package-NC"; ShipmentNotificationContent: JsonObject)
    var
        VoiceNotification: JsonObject;
    begin
        if Package."ESNVoice Noti. Phone No.Ship" <> '' then
            VoiceNotification.Add('PhoneNumber', GetUPSFormatedShipperPhoneNo(Package."ESNVoice Noti. Phone No.Ship"));

        if VoiceNotification.Keys.Count > 0 then begin
            ShipmentNotificationContent.Add('VoiceMessage', VoiceNotification)
        end;
    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions_Notification_Text(Package: Record "ETI-Package-NC"; ShipmentNotificationContent: JsonObject)
    var
        TextNotification: JsonObject;
    begin
        if Package."ESNText Noti. Phone No.Ship" <> '' then
            TextNotification.Add('PhoneNumber', GetUPSFormatedShipperPhoneNo(Package."ESNText Noti. Phone No.Ship"));

        if TextNotification.Keys.Count > 0 then begin
            ShipmentNotificationContent.Add('TextMessage', TextNotification)
        end;
    end;

    local procedure GetShipmentRequest_Shipment_ShipmentServiceOptions_DeliveryConfirmation(Package: Record "ETI-Package-NC"; ShipmentServiceOptionsContent: JsonObject)
    var
        DeliveryConfirmation: JsonObject;
    begin
        if Package."ESNDCIS TypeShip" <> Package."ESNDCIS TypeShip"::" " then begin
            DeliveryConfirmation.Add('DCISType', Format(Package."ESNDCIS TypeShip", 0, 9));
        end;

        if DeliveryConfirmation.Keys.Count > 0 then begin
            ShipmentServiceOptionsContent.Add('DeliveryConfirmation', DeliveryConfirmation)
        end;
    end;

    local procedure GetShipmentRequest_Shipment_Packages(Package: Record "ETI-Package-NC"; ShipmentContent: JsonObject)
    var
        Package2: Record "ETI-Package-NC";
        PackagesJsonArray: JsonArray;
        PackageJsonObject: JsonObject;
    begin
        // Required: Yes
        Package.TestField("ESNShipment No.Ship");
        Package2.SetRange("ESNShipment No.Ship", Package."ESNShipment No.Ship");

        if not Package2.IsEmpty then
            if Package2.Find('-') then
                repeat
                    Clear(PackageJsonObject);
                    GetShipmentRequest_Shipment_Package(Package2, PackageJsonObject);
                    PackagesJsonArray.Add(PackageJsonObject);
                until Package2.Next() = 0;

        if PackagesJsonArray.Count > 0 then
            ShipmentContent.Add('Package', PackagesJsonArray);
    end;

    local procedure GetShipmentRequest_Shipment_Package(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        PackagingCode: JsonObject;
    begin
        if Package.Description <> '' then begin
            PackageJsonObject.Add('Description', CopyStr(Package.Description, 1, 35));
        end;
        if (Package.Description <> '') or (Package."Description 2" <> '') then begin
            PackageJsonObject.Add('PalletDescription', CopyStr(Package.Description + ' ' + Package.Description, 1, 150));
        end;

        if Package."ESNUPS Packaging CodeUPS" = Package."ESNUPS Packaging CodeUPS"::" " then
            Package."ESNUPS Packaging CodeUPS" := Package."ESNUPS Packaging CodeUPS"::"02";

        PackagingCode.Add('Code', CopyStr(ShippingAgentFnc.GetEnumValueName(Package."ESNUPS Packaging CodeUPS"), 1, 2));
        PackageJsonObject.Add('Packaging', PackagingCode);

        GetShipmentRequest_Shipment_Package_Dimensions(Package, PackageJsonObject);
        GetShipmentRequest_Shipment_Package_PackageWeight(Package, PackageJsonObject);
        GetShipmentRequest_Shipment_Package_UPSPremier(Package, PackageJsonObject);
        GetShipmentRequest_Shipment_Package_PackageServiceOptions(Package, PackageJsonObject);
        GetShipmentRequest_Shipment_Package_HazMatPackageInformation(Package, PackageJsonObject);

        GetShipmentRequest_Shipment_Package_SimpleRate(Package, PackageJsonObject);


    end;

    local procedure GetShipmentRequest_Shipment_Package_Dimensions(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        ShippingAgent: Record "Shipping Agent";
        Dimensions: JsonObject;
        UnitOfMeasurement: JsonObject;

        NotLargerThanCm: Label 'Package must not be larger than 274cm.';
        NotLargerThanIn: Label 'Package must not be larger than 128in.';
    begin
        ShippingAgent := Package.GetShippingAgent();
        UnitOfMeasurement.Add('Code', GetUPSFormated2CharType(ShippingAgent."ESNUPS Dimensions UoMUPS".AsInteger()));
        Dimensions.Add('UnitOfMeasurement', UnitOfMeasurement);

        SwitchDimensToMakeLengthLongestDimension(Package);
        case ShippingAgent."ESNUPS Dimensions UoMUPS" of
            // Valid values are 0 to 108 IN and 0 to 274 CM.
            ShippingAgent."ESNUPS Dimensions UoMUPS"::"00":
                begin
                    //'Metric Units of Measurement' 
                    if Package.Length > 274 then begin
                        Error(NotLargerThanCm);
                    end;
                end;
            ShippingAgent."ESNUPS Dimensions UoMUPS"::"01":
                begin
                    if Package.Length > 108 then begin
                        Error(NotLargerThanIn);
                    end;
                end;
            else
                ShippingAgent.FieldError("ESNUPS Dimensions UoMUPS");
        end;
        Dimensions.Add('Length', Format(Round(Package.Length, 1)));
        Dimensions.Add('Width', Format(Round(Package.Width, 1)));
        Dimensions.Add('Height', Format(Round(Package.Height, 1)));


        if Dimensions.Keys.Count > 0 then
            PackageJsonObject.Add('Dimensions', Dimensions);
    end;

    local procedure GetShipmentRequest_Shipment_Package_PackageWeight(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        ShippingAgent: Record "Shipping Agent";
        PackageWeight: JsonObject;
        UnitOfMeasurement: JsonObject;
    begin
        ShippingAgent := Package.GetShippingAgent();
        UnitOfMeasurement.Add('Code', format(ShippingAgent."ESNUPS Weight DimensionsUPS"));

        PackageWeight.Add('UnitOfMeasurement', UnitOfMeasurement);

        // Required: Yes
        Package.TestField(Weight);
        // There is one implied decimal place (e.g. 115 = 11.5).
        PackageWeight.Add('Weight', Format(Round(Package.Weight * 10, 1)));

        if PackageWeight.Keys.Count > 0 then
            PackageJsonObject.Add('PackageWeight', PackageWeight);
    end;

    local procedure GetShipmentRequest_Shipment_Package_UPSPremier(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        UPSPremier: JsonObject;
    begin
        if Package."ESNUPS Premier CategoryUPS" <> Package."ESNUPS Premier CategoryUPS"::" " then begin

            UPSPremier.Add('Category', GetUPSFormated2CharType(Package."ESNUPS Premier CategoryUPS".AsInteger()));
            UPSPremier.Add('SensorID', Package."ESNUPS Premier SensorIDUPS");

            UPSPremier.Add('HandlingInstructions', GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions(Package));


            if UPSPremier.Keys.Count > 0 then
                PackageJsonObject.Add('UPSPremier', UPSPremier);
        end;
    end;

    local procedure GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions(Package: Record "ETI-Package-NC") UPSPremierHandlingInstructions: JsonToken
    var
        HandlingInstructions: JsonArray;
        InstructionsJsonObject: JsonObject;
        InstructionsJsonToken: JsonToken;

    begin
        if (Package."ESNUPS Pre. Handl. Instr 1.UPS" = Package."ESNUPS Pre. Handl. Instr 1.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 2.UPS" = Package."ESNUPS Pre. Handl. Instr 2.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 3.UPS" = Package."ESNUPS Pre. Handl. Instr 3.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 4.UPS" = Package."ESNUPS Pre. Handl. Instr 4.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 5.UPS" = Package."ESNUPS Pre. Handl. Instr 5.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 6.UPS" = Package."ESNUPS Pre. Handl. Instr 6.UPS"::" ") and
            (Package."ESNUPS Pre. Handl. Instr 7.UPS" = Package."ESNUPS Pre. Handl. Instr 7.UPS"::" ") then begin
            Package.TestField("ESNUPS Pre. Handl. Instr 1.UPS");
        end;

        if Package."ESNUPS Pre. Handl. Instr 1.UPS" <> Package."ESNUPS Pre. Handl. Instr 1.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 1.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 2.UPS" <> Package."ESNUPS Pre. Handl. Instr 2.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 2.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 3.UPS" <> Package."ESNUPS Pre. Handl. Instr 3.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 3.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 4.UPS" <> Package."ESNUPS Pre. Handl. Instr 4.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 4.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 5.UPS" <> Package."ESNUPS Pre. Handl. Instr 5.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 5.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 6.UPS" <> Package."ESNUPS Pre. Handl. Instr 6.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 6.UPS", HandlingInstructions);
        end;
        if Package."ESNUPS Pre. Handl. Instr 7.UPS" <> Package."ESNUPS Pre. Handl. Instr 7.UPS"::" " then begin
            GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(Package."ESNUPS Pre. Handl. Instr 7.UPS", HandlingInstructions);
        end;

        if HandlingInstructions.Count > 1 then begin
            UPSPremierHandlingInstructions := HandlingInstructions.AsToken();
        end else begin
            HandlingInstructions.Get(0, UPSPremierHandlingInstructions);
        end;
    end;

    local procedure GetShipmentRequest_Shipment_Package_UPSPremier_HandlingInstructions_AddInstructionToArray(UPSPremier_HandlingInstruction: Enum "ESNUPS Pre. Handl. Instr.UPS"; HandlingInstructions: JsonArray)
    var
        Instructions: JsonObject;
    begin
        if UPSPremier_HandlingInstruction <> UPSPremier_HandlingInstruction::" " then begin
            Instructions.Add('Instruction', GetUPSFormated3CharType(UPSPremier_HandlingInstruction.AsInteger()));
            HandlingInstructions.Add(Instructions);
        end;
    end;


    local procedure GetShipmentRequest_Shipment_Package_PackageServiceOptions(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        PackageServiceOptions: JsonObject;
    begin

        GetShipmentRequest_Shipment_Package_PackageServiceOptions_HazMat(Package, PackageServiceOptions);
        GetShipmentRequest_Shipment_Package_PackageServiceOptions_PackageIdentifier(Package, PackageServiceOptions);

        if PackageServiceOptions.Keys.Count > 0 then
            PackageJsonObject.Add('PackageServiceOptions', PackageServiceOptions);
    end;

    local procedure GetShipmentRequest_Shipment_Package_PackageServiceOptions_PackageIdentifier(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        CopyFromPosition: Integer;
    begin
        CopyFromPosition := 1;
        if StrLen(Package."No.") > 5 then begin
            CopyFromPosition := StrLen(Package."No.") - 5;
        end;

        PackageJsonObject.Add('PackageIdentifier', CopyStr(Package."No.", CopyFromPosition));
    end;

    local procedure GetShipmentRequest_Shipment_Package_PackageServiceOptions_HazMat(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var

        PackageADRLines: Record "ESNPackage ADR ContentShip";
        ADRPackageMgt: Codeunit "ESNADR Package ManagementShip";
        ChemicalRecordIdentifier: Integer;
        HazMatJsonArray: JsonArray;
        NotMoreThe2DangerousGoodsPositionsLbl: Label 'Maximum of three dangerous goods materials allowed per package.', Comment = 'Maximal drei Gefahrgutstoffe pro Paket erlaubt.';
    begin
        if ADRPackageMgt.GetPackageADRLines(Package, PackageADRLines) then begin
            if PackageADRLines.Count > 3 then
                Error(NotMoreThe2DangerousGoodsPositionsLbl);
            repeat
                HazMatJsonArray.Add(GetShipmentRequest_Shipment_Package_PackageServiceOptions_HazMat_Entry(Package, PackageADRLines, ChemicalRecordIdentifier));
            until PackageADRLines.Next() = 0;

            if HazMatJsonArray.Count > 0 then
                PackageJsonObject.Add('HazMat', HazMatJsonArray);
        end;
    end;

    local procedure GetShipmentRequest_Shipment_Package_PackageServiceOptions_HazMat_Entry(Package: Record "ETI-Package-NC"; PackageADRLines: Record "ESNPackage ADR ContentShip"; var ChemicalRecordIdentifier: Integer) HazMat: JsonObject
    var
        ADR: Record ESNADRShip;
        ADRInstruction: Record "ESNADR InstructionShip";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentFnc: Codeunit "ESNShipping Agent FncUPS";
        HazardLabelRequired, PackagingInstructionCode : Text;
    begin
        // Gefahrgut 
        // API Version Check.        
        ShippingAgent := Package.GetShippingAgent();
        case PackageADRLines."Regulated Level" of
            PackageADRLines."Regulated Level"::LR,
               PackageADRLines."Regulated Level"::EQ:
                begin
                    if ShippingAgent."ESNREST VersionUPS".AsInteger() < ShippingAgent."ESNREST VersionUPS"::v1701.AsInteger() then
                        ShippingAgent.TestField("ESNREST VersionUPS", ShippingAgent."ESNREST VersionUPS"::v1701);
                end;
            PackageADRLines."Regulated Level"::FR,
            PackageADRLines."Regulated Level"::LQ:
                begin
                    if ShippingAgent."ESNREST VersionUPS".AsInteger() < ShippingAgent."ESNREST VersionUPS"::v1807.AsInteger() then
                        ShippingAgent.TestField("ESNREST VersionUPS", ShippingAgent."ESNREST VersionUPS"::v1807);
                end;
        end;
        PackageADRLines.TestField("Total ADR Package Quantity");
        PackageADRLines.TestField("Regulated Level");
        HazMat.Add('CommodityRegulatedLevelCode', ShippingAgentFnc.GetEnumValueName(PackageADRLines."Regulated Level"));
        if ADR.get(PackageADRLines."ADR No.") then begin
            // SubRiskClass ToDo
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::lq,
                PackageADRLines."Regulated Level"::fr:
                    begin

                    end;
            end;
            // aDRPackingGroupLetter
            HazMat.Add('aDRPackingGroupLetter', CopyStr(ShippingAgentFnc.GetEnumValueName(ADR."Packing Group"), 1, 5));
            // TechnicalName
            HazMat.Add('TechnicalName', CopyStr(ADR.GetTranslatedDescription(Package."Language Code"), 1, 200));
            // HazardLabelRequired
            if not (PackageADRLines."Regulated Level" in [PackageADRLines."Regulated Level"::lq, PackageADRLines."Regulated Level"::EQ]) then begin
                ADRInstruction.SetRange("ADR No.", ADR."No.");
                ADRInstruction.SetRange(Groupe, ADRInstruction.Groupe::Lable);
                if not ADRInstruction.IsEmpty then
                    if ADRInstruction.Find('-') then
                        repeat
                            if HazardLabelRequired = '' then begin
                                HazardLabelRequired := Format(ADRInstruction.Lable)
                            end else begin
                                HazardLabelRequired += ' ' + Format(ADRInstruction.Lable);
                            end;
                        until ADRInstruction.Next() = 0;
                if HazardLabelRequired <> '' then begin
                    HazMat.Add('HazardLabelRequired', CopyStr(HazardLabelRequired, 1, 50));
                end;
            end;
            // ClassDivisionNumber
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::EQ,
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        HazMat.Add('ClassDivisionNumber', CopyStr(ShippingAgentFnc.GetEnumValueName(adr.Class), 1, 7));
                    end;
            end;
            //Quantity, UOM
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::EQ,
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        HazMat.Add('Quantity', CopyStr(Format(round(PackageADRLines."Total ADR Package Quantity", 0.1), 0, 9), 1, 5));
                        HazMat.Add('UOM', CopyStr(ShippingAgentFnc.GetEnumValueName(PackageADRLines."ADR Content Unit of Measure"), 1, 110));
                    end;
            end;
            // PackagingType, PackagingTypeQuantity 
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        HazMat.Add('PackagingType', CopyStr(ShippingAgentFnc.GetEnumValueName(PackageADRLines."Packaging Type"), 1, 255));
                        PackageADRLines.CalcFields("Total Packaging Type Count");
                        if PackageADRLines."Total Packaging Type Count" > 0 then
                            HazMat.Add('PackagingTypeQuantity', CopyStr(Format(round(PackageADRLines."Total Packaging Type Count", 1), 0, 9), 1, 255));
                    end;
            end;
            // IDNumber
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        HazMat.Add('IDNumber', CopyStr(ADR."No.", 1, 6));
                        HazMat.Add('ProperShippingName', CopyStr(ADR.GetTranslatedDescription(Package."Language Code"), 1, 150));
                    end;
            end;
            // AdditionalDescription
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        ADR.TestField("ESNAdditional DescriptionUPS");
                        HazMat.Add('AdditionalDescription', CopyStr(ADR."ESNAdditional DescriptionUPS", 1, 150));
                    end;
            end;
            //PackagingGroupType
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        HazMat.Add('PackagingGroupType', CopyStr(ShippingAgentFnc.GetEnumValueName(ADR."Packing Group"), 1, 5));
                    end;
            end;
            //PackagingInstructionCode
            case PackageADRLines."Regulated Level" of
                PackageADRLines."Regulated Level"::fr,
                PackageADRLines."Regulated Level"::lq:
                    begin
                        ADRInstruction.Reset();
                        ADRInstruction.SetRange("ADR No.", ADR."No.");
                        ADRInstruction.SetRange(Groupe, ADRInstruction.Groupe::"Packing instructions");
                        ADRInstruction.SetFilter("ESNCode (UPS)UPS", '<>%1', '');
                        if not ADRInstruction.IsEmpty then begin
                            if ADRInstruction.FindFirst() then begin
                                PackagingInstructionCode := ADRInstruction."ESNCode (UPS)UPS";
                            end;
                        end else begin
                            ADRInstruction.SetRange("ESNCode (UPS)UPS");
                            if not ADRInstruction.IsEmpty then begin
                                if ADRInstruction.FindFirst() then begin
                                    PackagingInstructionCode := CopyStr(ADRInstruction.Code, 1, 4);
                                end;
                            end;
                        end;
                        if PackagingInstructionCode <> '' then begin
                            HazMat.Add('PackagingInstructionCode', CopyStr(PackagingInstructionCode, 1, 4));
                        end;
                    end;
            end;
            //EmergencyPhone
            Package.TestField("ESNADR Emerg. Phone No.Ship");
            HazMat.Add('EmergencyPhone', CopyStr(Package."ESNADR Emerg. Phone No.Ship", 1, 25));
            // ReportableQuantity
            // Recommended if CommodityRegulatedLevelCode = LQ or FR and if the field applies to the material by regulation. 
            // If reportable quantity is met, 'RQ' should be entered
            // Keine Anhung was hier gemeint ist

            // RegulationSet
            Package.TestField("ESNRegulation SetShip");
            HazMat.Add('RegulationSet', CopyStr(ShippingAgentFnc.GetEnumValueName(Package."ESNRegulation SetShip"), 1, 5));

            //TransportationMode
            Package.TestField("ESNTransportation ModeShip");
            HazMat.Add('TransportationMode', CopyStr(ShippingAgentFnc.GetEnumValueName(Package."ESNTransportation ModeShip"), 1, 30));

            // TransportCategory
            ADRInstruction.Reset();
            ADRInstruction.SetRange("ADR No.", ADR."No.");
            ADRInstruction.SetRange(Groupe, ADRInstruction.Groupe::"Transport category");
            if not ADRInstruction.IsEmpty then
                if ADRInstruction.FindFirst() then begin
                    HazMat.Add('TransportCategory', CopyStr(ADRInstruction.Code, 1, 4));
                end;

            // TunnelRestrictionCode:
            ADRInstruction.Reset();
            ADRInstruction.SetRange("ADR No.", ADR."No.");
            ADRInstruction.SetRange(Groupe, ADRInstruction.Groupe::"Transport category (Tunnel Restriction code)");
            if not ADRInstruction.IsEmpty then
                if ADRInstruction.FindFirst() then begin
                    HazMat.Add('TunnelRestrictionCode', CopyStr(ADRInstruction.Code, 1, 4));
                end;

            // ChemicalRecordIdentifier
            ChemicalRecordIdentifier += 1;
            HazMat.Add('ChemicalRecordIdentifier', CopyStr(Format(ChemicalRecordIdentifier, 0, 9), 1, 3));


            // LocalTechnicalName
            HazMat.Add('LocalTechnicalName', CopyStr(ADR.Description, 1, 200));
            HazMat.Add('LocalProperShippingName', CopyStr(ADR.CombineDescriptions(ADR.Description, ADR."Description 2"), 1, 200));

        end;
    end;

    local procedure GetShipmentRequest_Shipment_Package_HazMatPackageInformation(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        HazMatPackageInformation: JsonObject;
    begin
        // Gefahrgut todo !!    
        //GetShipmentRequest_Shipment_Package_HazMatPackageInformation...(Package, PackageServiceOptions);
        //HazMatPackageInformation

        if HazMatPackageInformation.Keys.Count > 0 then
            PackageJsonObject.Add('HazMatPackageInformation', HazMatPackageInformation);
    end;


    local procedure GetShipmentRequest_Shipment_Package_SimpleRate(Package: Record "ETI-Package-NC"; PackageJsonObject: JsonObject)
    var
        SimpleRate: JsonObject;
    begin
        if Package."ESNUPS Simple RateUPS" <> Package."ESNUPS Simple RateUPS"::" " then begin

            SimpleRate.Add('Code', GetUPSSimpleRateCode(Package."ESNUPS Simple RateUPS"));
            SimpleRate.Add('Description', Format(Package."ESNUPS Simple RateUPS"));

            if SimpleRate.Keys.Count > 0 then
                PackageJsonObject.Add('SimpleRate', SimpleRate);
        end;
    end;

    local procedure GetShipmentRequest_LabelSpecification(Package: Record "ETI-Package-NC") LabelSpecificationContent: JsonObject
    var
        LabelImageFormat: JsonObject;
        LabelStockSize: JsonObject;
    begin
        // Default Lable Format PNG
        if Package."ESNLabel Image FormatUPS" = Package."ESNLabel Image FormatUPS"::" " then
            Package."ESNLabel Image FormatUPS" := Package."ESNLabel Image FormatUPS"::PNG;

        LabelImageFormat.Add('Code', Format(Package."ESNLabel Image FormatUPS"));
        LabelSpecificationContent.Add('LabelImageFormat', LabelImageFormat);

        if Package."ESNLabel Image FormatUPS" = Package."ESNLabel Image FormatUPS"::GIF then begin
            LabelSpecificationContent.Add('HTTPUserAgent', 'Mozilla/4.5');
        end;

        if Package."ESNLabel Image FormatUPS" IN [Enum::"ESNLabel Image FormatUPS"::EPL, Enum::"ESNLabel Image FormatUPS"::ZPL, Enum::"ESNLabel Image FormatUPS"::SPL] then begin
            LabelStockSize.Add('Width', Format(4));
            LabelStockSize.Add('Height', Format(6));
            LabelSpecificationContent.Add('LabelStockSize', LabelStockSize);
        end;

    end;
    // -->

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
        Package.TestField("ESNShip-from Coun/Reg CodeShip");
        CountryRegion.get(Package."ESNShip-from Coun/Reg CodeShip");
        CountryRegion.TestField("ISO Code");
        ShipperAddress.Add('CountryCode', CopyStr(CountryRegion."ISO Code", 1, 2));
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
        Package.TestField("Ship-to Country/Region Code");
        CountryRegion.get(Package."Ship-to Country/Region Code");
        CountryRegion.TestField("ISO Code");
        ShipToAddress.Add('CountryCode', CopyStr(CountryRegion."ISO Code", 1, 2));
    end;

    local procedure GetUPSFormatedShipperPhoneNo(ShipperPhoneNo: Text) UPSFormatedShipperPhoneNo: Text
    begin
        // TODO
        UPSFormatedShipperPhoneNo := CopyStr(ShipperPhoneNo, 1, 15);
    end;

    local procedure GetUPSFormated2CharType(GivenValue: Integer) UPSFormated2CharType: code[2]
    begin
        UPSFormated2CharType := Format(GivenValue);
        if StrLen(UPSFormated2CharType) = 1 then begin
            UPSFormated2CharType := '0' + UPSFormated2CharType;
        end;
        exit(UPSFormated2CharType);
    end;

    local procedure GetUPSFormated3CharType(GivenValue: Integer) UPSFormated2CharType: code[3]
    begin
        UPSFormated2CharType := Format(GivenValue);
        if StrLen(UPSFormated2CharType) = 1 then begin
            UPSFormated2CharType := '0' + UPSFormated2CharType;
        end;
        if StrLen(UPSFormated2CharType) = 2 then begin
            UPSFormated2CharType := '0' + UPSFormated2CharType;
        end;
        exit(UPSFormated2CharType);
    end;

    local procedure GetUPSSimpleRateCode(GivenValue: Enum "ESNUPS Simple RateUPS") UPSSimpleRateCode: code[2]
    begin
        case GivenValue of
            GivenValue::XS:
                begin
                    UPSSimpleRateCode := 'XS';
                end;
            GivenValue::S:
                begin
                    UPSSimpleRateCode := 'S';
                end;
            GivenValue::M:
                begin
                    UPSSimpleRateCode := 'M';
                end;
            GivenValue::L:
                begin
                    UPSSimpleRateCode := 'L';
                end;
            GivenValue::XL:
                begin
                    UPSSimpleRateCode := 'XL';
                end;
        end;

        exit(UPSSimpleRateCode);
    end;

    local procedure GetUPSFormated2CharType(GivenValue: Code[2]) UPSFormated2CharType: code[2]
    begin
        UPSFormated2CharType := GivenValue;
        if StrLen(UPSFormated2CharType) = 1 then begin
            UPSFormated2CharType := '0' + UPSFormated2CharType;
        end;
        exit(UPSFormated2CharType);
    end;

    local procedure GetUPSFormatedCredCardExpDate(CredCardExpDate: Date) UPSFormatedCredCardExpDate: Code[6]
    begin
        UPSFormatedCredCardExpDate := Format(CredCardExpDate, 6, '<Month,2><Year4>');
    end;

    local procedure SwitchDimensToMakeLengthLongestDimension(var Package: Record "ETI-Package-NC")
    begin
        if Package.Width > Package.Length then
            SwitchValues(Package.Width, Package.Length);

        if Package.Height > Package.Length then
            SwitchValues(Package.Height, Package.Length);
    end;

    local procedure SwitchValues(Var ValueA: Decimal; var ValueB: Decimal)
    var
        ValueC: Decimal;
    begin
        ValueC := ValueA;
        ValueA := ValueB;
        ValueB := ValueC
    end;
    #endregion

}