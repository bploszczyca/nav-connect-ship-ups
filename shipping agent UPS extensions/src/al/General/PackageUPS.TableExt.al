tableextension 70869802 "ESNPackageUPS" extends "ETI-Package-NC"
{
    fields
    {
        field(70869800; "ESNReturn ServiceUPS"; Enum "ESNReturn ServiceUPS")
        {
            Caption = 'Return Service';
            DataClassification = CustomerContent;
        }
        field(70869801; "ESNNotification CodeUPS"; Enum "ESNNotification CodeUPS")
        {
            Caption = 'UPS Notification Type';
            DataClassification = CustomerContent;
        }
        field(70869802; "ESNUPS Packaging CodeUPS"; Enum "ESNPackaging TypeUPS")
        {
            Caption = 'UPS Packaging Code', Comment = 'UPS Verpackuntsart';
            DataClassification = CustomerContent;
            InitValue = "02";
        }
        modify("Packing Material Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if item.get("Packing Material Item No.") then begin
                    if item."ESNUPS Packaging CodeUPS" <> item."ESNUPS Packaging CodeUPS"::" " then begin
                        Validate("ESNUPS Packaging CodeUPS", item."ESNUPS Packaging CodeUPS");
                    end else begin
                        Validate("ESNUPS Packaging CodeUPS", "ESNUPS Packaging CodeUPS"::"02");
                    end;
                    Validate("ESNUPS Simple RateUPS", item."ESNUPS Simple RateUPS");
                end else begin
                    Validate("ESNUPS Packaging CodeUPS", "ESNUPS Packaging CodeUPS"::"02");
                    Validate("ESNUPS Simple RateUPS", "ESNUPS Simple RateUPS"::" ");
                end;
            end;
        }

        field(70869803; "ESNUPS Premier CategoryUPS"; Enum "ESNUPS Premier CategoryUPS")
        {
            Caption = 'UPS Premier Category';
            DataClassification = CustomerContent;
        }
        field(70869804; "ESNUPS Premier SensorIDUPS"; Text[50])
        {
            Caption = 'UPS Premier SensorID';
            DataClassification = CustomerContent;
        }
        field(70869805; "ESNUPS Simple RateUPS"; Enum "ESNUPS Simple RateUPS")
        {
            Caption = 'UPS Simple Rate';
            DataClassification = CustomerContent;
        }
        field(70869806; "ESNLabel Image FormatUPS"; Enum "ESNLabel Image FormatUPS")
        {
            Caption = 'Label Image Format';
            DataClassification = CustomerContent;
        }
        modify("Shipping Agent Code")
        {
            trigger OnAfterValidate()
            var
                ShippingAgent: Record "Shipping Agent";
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then begin
                    if ShippingAgent.get("Shipping Agent Code") then begin
                        Validate("ESNLabel Image FormatUPS", ShippingAgent."ESNLabel Image FormatUPS");
                    end else begin
                        Validate("ESNLabel Image FormatUPS", "ESNLabel Image FormatUPS"::PNG);
                    end;
                end;
            end;
        }
        modify("Shipping Agent Service Code")
        {
            trigger OnAfterValidate()
            var
                ShippingAgentServices: Record "Shipping Agent Services";
            begin
                if "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" then begin
                    if ShippingAgentServices.get("Shipping Agent Code", "Shipping Agent Service Code") and (ShippingAgentServices."ESNLabel Image FormatUPS" <> ShippingAgentServices."ESNLabel Image FormatUPS"::" ") then begin
                        Validate("ESNLabel Image FormatUPS", ShippingAgentServices."ESNLabel Image FormatUPS");
                    end else begin
                        Validate("ESNLabel Image FormatUPS", "ESNLabel Image FormatUPS"::PNG);
                    end;
                end;
            end;
        }
        field(70869807; "ESNUPS Pre. Handl. Instr 1.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction';
            DataClassification = CustomerContent;
        }
        field(70869808; "ESNUPS Pre. Handl. Instr 2.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 2';
            DataClassification = CustomerContent;
        }
        field(70869809; "ESNUPS Pre. Handl. Instr 3.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 3';
            DataClassification = CustomerContent;
        }
        field(70869810; "ESNUPS Pre. Handl. Instr 4.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 4';
            DataClassification = CustomerContent;
        }
        field(70869811; "ESNUPS Pre. Handl. Instr 5.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 5';
            DataClassification = CustomerContent;
        }
        field(70869812; "ESNUPS Pre. Handl. Instr 6.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 6';
            DataClassification = CustomerContent;
        }
        field(70869813; "ESNUPS Pre. Handl. Instr 7.UPS"; Enum "ESNUPS Pre. Handl. Instr.UPS")
        {
            Caption = 'Handling Instruction 7';
            DataClassification = CustomerContent;
        }
    }
}