codeunit 70869804 "ESNShipping Agent FncUPS"
{

    #region Regulated Level    
    // "ESNADR Package ManagementShip"
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ESNADR Package ManagementShip", 'OnAfterCalcRegulatedLevel', '', true, false)]
    local procedure OnAfterCalcRegulatedLevel(var PackageADRContent: Record "ESNPackage ADR ContentShip")
    var
        ADR: Record "ESNADRShip";
    begin
        if ADR.Get(PackageADRContent."ADR No.") and ADR."ESNLightly RegulatedUPS" then begin
            if PackageADRContent."Regulated Level" = PackageADRContent."Regulated Level"::FR then begin
                PackageADRContent.Validate("Regulated Level", PackageADRContent."Regulated Level"::LR);
            end;
        end;
    end;
    #endregion

    #region
    [EventSubscriber(ObjectType::Table, database::"ESNADR InstructionShip", 'OnBeforInsertGeneralADRInstructionRecord', '', true, false)]
    local procedure OnBeforInsertGeneralADRInstructionRecord(ADRInstructionRecord: Record "ESNADR InstructionShip"; var GeneralADRInstructionRecord: Record "ESNADR InstructionShip")
    begin
        GeneralADRInstructionRecord."ESNCode (UPS)UPS" := ADRInstructionRecord."ESNCode (UPS)UPS";
    end;
    #endregion

    #region Enum Values
    procedure GetEnumValueName(e: enum "ESNRegulated LevelShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNADR Quantities UoMShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNPackaging TypeShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNADR Packing GroupShip") EnumValueName: Text;
    begin
        if e.AsInteger() > e::" ".AsInteger() then begin
            e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        end;
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNADR ClassShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNRegulation SetShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNTransportation ModeShip") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNLabel Image FormatUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNNotification CodeUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNPackaging CodeUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNReturn ServiceUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNShip. NotificationUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNUPS Dimensions UoMUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNUPS Pre. Handl. Instr.UPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNUPS Premier CategoryUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNUPS Simple RateUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNUPS Weight Dimensions UPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNCredit Card TypeUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNShipping Agent REST URLUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNTransAndDuties PaymentUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;

    procedure GetEnumValueName(e: enum "ESNTrans. Payment TypeUPS") EnumValueName: Text;
    begin
        e.Names.Get(e.Ordinals.IndexOf(e.AsInteger()), EnumValueName);
        exit(EnumValueName);
    end;
    #endregion
}