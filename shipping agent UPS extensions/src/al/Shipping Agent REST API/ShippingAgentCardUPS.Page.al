page 70869800 "ESNShipping Agent CardUPS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Shipping Agent";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'Allgemein';
                field("Code"; rec.Code) { Editable = false; ApplicationArea = All; }
                field(Name; rec.Name) { ApplicationArea = All; }
                field("ESNDefault ServiceUPS"; rec."ESNDefault ServiceShip")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("ESNDefault Ship-from TypeUPS"; rec."ESNDefault Ship-from TypeShip") { ApplicationArea = All; }
                field("ESNDef. Ship-from ContactUPS"; rec."ESNDef. Ship-from ContactShip") { ApplicationArea = All; }
            }
            group("UPS Account Information")
            {
                Caption = 'UPS Account Information', Comment = 'UPS Zugangsdaten';
                field("ESNUPS Account NumberUPS"; rec."ESNAccount NumberUPS") { ApplicationArea = All; }
                field("ESNUPS User NameUPS"; rec."ESNUser NameUPS") { ApplicationArea = All; }
                field("ESNUPS User PasswordUPS"; rec."ESNUser PasswordUPS") { ApplicationArea = All; }
                field("ESNAccess KeyUPS"; rec."ESNAccess KeyUPS") { ApplicationArea = All; }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                group("Transportation")
                {
                    Caption = 'Transportation';
                    field("ESNTransportation PaymentUPS"; rec."ESNTransportation PaymentUPS")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }

                    group(TransportationPaymentBillShipper)
                    {
                        ShowCaption = false;
                        Visible = ShowTransportationPaymentBillShipper;
                        field("ESNTrans. Payment TypeUPS"; rec."ESNBillShip Payment TypeUPS")
                        {
                            ApplicationArea = All;
                            trigger OnValidate()
                            begin
                                CurrPage.Update();
                            end;
                        }
                        group(TransportationPaymentBillShipperCredCard)
                        {
                            ShowCaption = false;
                            Visible = ShowTransportationPaymentBillShipperCredCard;
                            field("ESNCredit Card TypeUPS"; rec."ESNTransBillShipCredit CardUPS") { ApplicationArea = All; }
                            field("ESNCredit Card NumberUPS"; rec."ESNTransBillShipCard NumberUPS") { ApplicationArea = All; }
                            field("ESNCard Exp. DateUPS”:"; rec."ESNTransBillShipCard Exp. UPS") { ApplicationArea = All; }
                            field("ESNCard Sec. CodeUPS”:"; rec."ESNTransBillShipCard Sec. UPS") { ApplicationArea = All; }
                        }
                    }
                    group(TransportationPaymentBillReceiver)
                    {
                        ShowCaption = false;
                        Visible = ShowTransportationPaymentBillReceiver;
                        field("ESNTrans. Bill Receiver AccUPS"; rec."ESNTransBillReceiver AccUPS") { ApplicationArea = All; }
                    }
                    group(TransportationPaymentBillThirdParty)
                    {
                        ShowCaption = false;
                        Visible = ShowTransportationPaymentBillThirdParty;
                        field("ESNTrans. Bill Third AccUPS"; rec."ESNTransBillThird AccUPS") { ApplicationArea = All; }
                    }
                }
                group("Duties and Taxes")
                {
                    Caption = 'Duties and Taxes';
                    field("ESNDuty PaymentUPS"; rec."ESNDuty PaymentUPS")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    group(DutiesTaxesPaymentBillShipper)
                    {
                        ShowCaption = false;
                        Visible = ShowDutiesTaxesPaymentBillShipper;
                        field("ESNDutyBillShip Pay. TypeUPS"; rec."ESNDutyBillShip Pay. TypeUPS")
                        {
                            ApplicationArea = All;
                            trigger OnValidate()
                            begin
                                CurrPage.Update();
                            end;
                        }
                        group(DutiesTaxesPaymentBillShipperCredCard)
                        {
                            ShowCaption = false;
                            Visible = ShowDutiesTaxesPaymentBillShipperCredCard;
                            field("ESNDutyBillShipCredit CardUPS"; rec."ESNDutyBillShipCredit CardUPS") { ApplicationArea = All; }
                            field("ESNDutyBillShipCard NumberUPS"; rec."ESNDutyBillShipCard NumberUPS") { ApplicationArea = All; }
                            field("ESNDutyBillShipCard Exp. UPS"; rec."ESNDutyBillShipCard Exp. UPS") { ApplicationArea = All; }
                            field("ESNDutyBillShipCard Sec. UPS"; rec."ESNDutyBillShipCard Sec. UPS") { ApplicationArea = All; }
                        }
                    }
                    group(DutiesTaxesPaymentBillReceiver)
                    {
                        ShowCaption = false;
                        Visible = ShowDutiesTaxesPaymentBillReceiver;
                        field("ESNDutyBillReceiver AccUPS"; rec."ESNDutyBillReceiver AccUPS") { ApplicationArea = All; }
                    }
                    group(DutiesTaxesPaymentBillThirdParty)
                    {
                        ShowCaption = false;
                        Visible = ShowDutiesTaxesPaymentBillThirdParty;
                        field("ESNDutyBillThird AccUPS"; rec."ESNDutyBillThird AccUPS") { ApplicationArea = All; }
                    }
                }
            }
            group("UPS REST API")
            {
                Caption = 'UPS REST API', Comment = 'UPS REST API';
                field("ESNREST API EndpointUPS"; rec."ESNREST API EndpointUPS") { ApplicationArea = All; }
                field("ESNREST VersionUPS"; rec."ESNREST VersionUPS") { ApplicationArea = All; }
                field("Shipping REST URL"; rec.GetShippingURL())
                {
                    Caption = 'Shipping REST URL', Comment = 'Shipping REST URL';
                    ApplicationArea = All;
                }
                field("Cancel Shipping REST URL"; rec.GetShippingCancelURL())
                {
                    Caption = 'Cancel Shipping REST URL', Comment = 'Cancel Shipping REST URL';
                    ApplicationArea = All;
                }
                field("Shipping Label Recovery REST URL"; rec.GetShippingLabelRecoveryURL())
                {
                    Caption = 'Shipping Label Recovery REST URL', Comment = 'Shipping Label Recovery REST URL';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowTransportationPaymentBillShipper := rec."ESNTransportation PaymentUPS" = rec."ESNTransportation PaymentUPS"::"Bill Shipper";
        ShowTransportationPaymentBillShipperCredCard := ShowTransportationPaymentBillShipper and (rec."ESNBillShip Payment TypeUPS" = rec."ESNBillShip Payment TypeUPS"::"Credit Card");
        ShowTransportationPaymentBillReceiver := rec."ESNTransportation PaymentUPS" = rec."ESNTransportation PaymentUPS"::"Bill Receiver";
        ShowTransportationPaymentBillThirdParty := rec."ESNTransportation PaymentUPS" = rec."ESNTransportation PaymentUPS"::"Bill Third Party";

        ShowDutiesTaxesPaymentBillShipper := rec."ESNDuty PaymentUPS" = rec."ESNDuty PaymentUPS"::"Bill Shipper";
        ShowDutiesTaxesPaymentBillShipperCredCard := ShowDutiesTaxesPaymentBillShipper and (rec."ESNDutyBillShip Pay. TypeUPS" = rec."ESNDutyBillShip Pay. TypeUPS"::"Credit Card");
        ShowDutiesTaxesPaymentBillReceiver := rec."ESNDuty PaymentUPS" = rec."ESNDuty PaymentUPS"::"Bill Receiver";
        ShowDutiesTaxesPaymentBillThirdParty := rec."ESNDuty PaymentUPS" = rec."ESNDuty PaymentUPS"::"Bill Third Party";

    end;

    var
        [InDataSet]
        ShowTransportationPaymentBillShipper: Boolean;
        ShowTransportationPaymentBillShipperCredCard: Boolean;
        ShowTransportationPaymentBillReceiver: Boolean;
        ShowTransportationPaymentBillThirdParty: Boolean;

        ShowDutiesTaxesPaymentBillShipper: Boolean;
        ShowDutiesTaxesPaymentBillShipperCredCard: Boolean;
        ShowDutiesTaxesPaymentBillReceiver: Boolean;
        ShowDutiesTaxesPaymentBillThirdParty: Boolean;


}