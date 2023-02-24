codeunit 70869753 "ESNADR Package ManagementShip"
{

    procedure GetPackageContentADRLines("PackageContent": Record "ETI-Package Content-NC"; var PackageADRContent: Record "ESNPackage ADR ContentShip") PackageADRContentFound: Boolean
    begin
        PackageADRContent.SetRange("Package No.", PackageContent."Package No.");
        PackageADRContent.SetRange("Line Type", PackageContent."Line Type");
        PackageADRContent.SetRange("Template Type", PackageContent."Template Type");
        PackageADRContent.SetRange("Template Subtype", PackageContent."Template Subtype");
        PackageADRContent.SetRange("Template No.", PackageContent."Template No.");
        PackageADRContent.SetRange("Template Line No.", PackageContent."Template Line No.");
        PackageADRContent.SetRange("Template Sub Line No.", PackageContent."Template Sub Line No.");
        PackageADRContent.SetRange("Line No.", PackageContent."Line No.");
        if not PackageADRContent.IsEmpty then
            PackageADRContentFound := PackageADRContent.Find('-');
    end;

    procedure GetPackageContentADRLines(RegPackageContent: Record "ETI-Reg. Package Content-NC"; var RegPackageADRContent: Record "ESNReg. Package ADR ContShip") PackageADRContentFound: Boolean
    begin
        RegPackageADRContent.SetRange("Package No.", RegPackageContent."Package No.");
        RegPackageADRContent.SetRange("Line Type", RegPackageContent."Line Type");
        RegPackageADRContent.SetRange("Template Type", RegPackageContent."Template Type");
        RegPackageADRContent.SetRange("Template Subtype", RegPackageContent."Template Subtype");
        RegPackageADRContent.SetRange("Template No.", RegPackageContent."Template No.");
        RegPackageADRContent.SetRange("Template Line No.", RegPackageContent."Template Line No.");
        RegPackageADRContent.SetRange("Template Sub Line No.", RegPackageContent."Template Sub Line No.");
        RegPackageADRContent.SetRange("Line No.", RegPackageContent."Line No.");
        if not RegPackageADRContent.IsEmpty then
            PackageADRContentFound := RegPackageADRContent.Find('-');
    end;

    #region Adding/Removing "Package Content"
    local procedure InitPackageADRContent(Rec: Record "ETI-Package Content-NC"; var PackageADRContent: Record "ESNPackage ADR ContentShip")
    begin
        PackageADRContent.Init();
        PackageADRContent."Package No." := Rec."Package No.";
        PackageADRContent."Line Type" := Rec."Line Type";
        PackageADRContent."Template Type" := Rec."Template Type";
        PackageADRContent."Template Subtype" := rec."Template Subtype";
        PackageADRContent."Template No." := Rec."Template No.";
        PackageADRContent."Template Line No." := Rec."Template Line No.";
        PackageADRContent."Template Sub Line No." := Rec."Template Sub Line No.";
        PackageADRContent."Line No." := Rec."Line No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package Content-NC", 'OnAfterInsertEvent', '', true, false)]
    local procedure PackageContent_OnAfterInsertEvent(var Rec: Record "ETI-Package Content-NC")
    var
        ItemADRQuantityShip: Record "ESNItem ADR QuantityShip";
        PackageADRContent: Record "ESNPackage ADR ContentShip";
        PackageADRContent2: Record "ESNPackage ADR ContentShip";
        RegPackageADRContent: Record "ESNReg. Package ADR ContShip";
    begin
        case rec.Type of
            rec.Type::Item:
                begin
                    case Rec."Line Type" of
                        Rec."Line Type"::Content:
                            begin
                                ItemADRQuantityShip.SetCurrentKey("Item No.", "ADR No.", "Variant Code");
                                ItemADRQuantityShip.SetRange("Item No.", rec."No.");
                                ItemADRQuantityShip.SetFilter("Variant Code", '%1|%2', Rec."Variant Code", '');
                                if not ItemADRQuantityShip.IsEmpty then
                                    if ItemADRQuantityShip.Find('-') then
                                        repeat
                                            // Search for variant-specific ADR data
                                            if Rec."Variant Code" <> '' then begin
                                                ItemADRQuantityShip.SetRange("ADR No.", ItemADRQuantityShip."ADR No.");
                                                ItemADRQuantityShip.FindLast();
                                                ItemADRQuantityShip.SetRange("ADR No.");
                                            end;
                                            ItemADRQuantityShip.TestField("Quantity per Item Base UoM");

                                            InitPackageADRContent(rec, PackageADRContent);
                                            PackageADRContent."ADR No." := ItemADRQuantityShip."ADR No.";
                                            PackageADRContent."Quantity per Item Base UoM" := ItemADRQuantityShip."Quantity per Item Base UoM";
                                            PackageADRContent.Validate("ADR Unit of Measure", ItemADRQuantityShip."ADR Unit of Measure");
                                            PackageADRContent.Validate("Quantity (Base)", Rec."Pack Quantity (Base)");
                                            if PackageADRContent.Insert(true) then; // possible created by UndoRegisterPackage
                                        until ItemADRQuantityShip.Next() = 0;
                            end;
                    end;
                end;
            rec.Type::Package:
                begin
                    PackageADRContent2.SetRange("Package No.", rec."No.");
                    PackageADRContent2.SetRange("Line Type", PackageADRContent2."Line Type"::ADR);
                    if not PackageADRContent2.IsEmpty then
                        if PackageADRContent2.Find('-') then
                            repeat
                                PackageADRContent2.CalcPackageQuantityGrMl();
                                InitPackageADRContent(rec, PackageADRContent);
                                PackageADRContent."ADR No." := PackageADRContent2."ADR No.";
                                PackageADRContent."Quantity per Item Base UoM" := PackageADRContent2."ADR Content Quantity";
                                PackageADRContent.Validate("ADR Unit of Measure", PackageADRContent2."ADR Content Unit of Measure");
                                PackageADRContent.Validate("Quantity (Base)", Rec."Pack Quantity (Base)");
                                if PackageADRContent.Insert(true) then; // possible created by UndoRegisterPackage
                            until PackageADRContent2.Next() = 0;
                end;
            rec.Type::"Reg. Package":
                begin
                    RegPackageADRContent.SetRange("Package No.", rec."No.");
                    RegPackageADRContent.SetRange("Line Type", RegPackageADRContent."Line Type"::ADR);
                    if not RegPackageADRContent.IsEmpty then
                        if RegPackageADRContent.Find('-') then
                            repeat
                                InitPackageADRContent(rec, PackageADRContent);
                                PackageADRContent."ADR No." := RegPackageADRContent."ADR No.";
                                PackageADRContent."Quantity per Item Base UoM" := RegPackageADRContent."ADR Content Quantity";
                                PackageADRContent.Validate("ADR Unit of Measure", RegPackageADRContent."ADR Content Unit of Measure");
                                PackageADRContent.Validate("Quantity (Base)", Rec."Pack Quantity (Base)");
                                if PackageADRContent.Insert(true) then; // possible created by UndoRegisterPackage
                            until RegPackageADRContent.Next() = 0;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package-NC", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure Package_OnBeforeDeleteEvent(var Rec: Record "ETI-Package-NC")
    var
        PackageADRContent: Record "ESNPackage ADR ContentShip";
    begin
        PackageADRContent.SetRange("Package No.", Rec."No.");
        if not PackageADRContent.IsEmpty then
            PackageADRContent.DeleteAll(true);
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package Content-NC", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure PackageContent_OnBeforeDeleteEvent(var Rec: Record "ETI-Package Content-NC")
    var
        PackageADRContent: Record "ESNPackage ADR ContentShip";
    begin
        if GetPackageContentADRLines(Rec, PackageADRContent) then
            repeat
                PackageADRContent.Delete(true);
            until PackageADRContent.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Package Content-NC", 'OnAfterModifyEvent', '', true, false)]
    local procedure PackageContent_OnAfterModifyEvent(var Rec: Record "ETI-Package Content-NC")
    var
        PackageADRContent: Record "ESNPackage ADR ContentShip";
    begin
        if GetPackageContentADRLines(Rec, PackageADRContent) then
            repeat
                if rec."Pack Quantity (Base)" <> PackageADRContent."Quantity (Base)" then begin
                    PackageADRContent.Validate("Quantity (Base)", Rec."Pack Quantity (Base)");
                    PackageADRContent.Modify(true);
                end;
            until PackageADRContent.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, database::"ETI-Reg. Package-NC", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure RegPackage_OnBeforeDeleteEvent(var Rec: Record "ETI-Reg. Package-NC")
    var
        RegPackageADRContent: Record "ESNReg. Package ADR ContShip";
    begin
        RegPackageADRContent.SetRange("Package No.", Rec."No.");
        if not RegPackageADRContent.IsEmpty then
            RegPackageADRContent.DeleteAll(true);
    end;
    #endregion

    #region Adding/Removing "Package ADR Lines"
    procedure GetPackageADRLines(Package: Record "ETI-Package-NC"; var PackageADRLines: Record "ESNPackage ADR ContentShip") PackageADRLinesFound: Boolean
    begin
        PackageADRLines.SetRange("Package No.", Package."No.");
        PackageADRLines.SetRange("Line Type", PackageADRLines."Line Type"::ADR);
        PackageADRLines.SetRange("Template Type", 0);
        PackageADRLines.SetRange("Template Subtype", 0);
        PackageADRLines.SetRange("Template No.", '');
        PackageADRLines.SetRange("Template Line No.", 0);
        PackageADRLines.SetRange("Template Sub Line No.", 0);
        PackageADRLines.SetRange("Line No.", 0);
        if not PackageADRLines.IsEmpty then
            PackageADRLinesFound := PackageADRLines.Find('-');
    end;

    procedure GetPackageADRLines("PackageContent": Record "ETI-Package Content-NC"; var PackageADRLines: Record "ESNPackage ADR ContentShip") PackageADRLinesFound: Boolean
    begin
        PackageADRLines.SetRange("Package No.", PackageContent."Package No.");
        PackageADRLines.SetRange("Line Type", PackageADRLines."Line Type"::ADR);
        PackageADRLines.SetRange("Template Type", 0);
        PackageADRLines.SetRange("Template Subtype", 0);
        PackageADRLines.SetRange("Template No.", '');
        PackageADRLines.SetRange("Template Line No.", 0);
        PackageADRLines.SetRange("Template Sub Line No.", 0);
        PackageADRLines.SetRange("Line No.", 0);
        if not PackageADRLines.IsEmpty then
            PackageADRLinesFound := PackageADRLines.Find('-');
    end;

    procedure GetPackageADRLines(PackageADRContent: Record "ESNPackage ADR ContentShip"; var PackageADRLines: Record "ESNPackage ADR ContentShip") PackageADRLinesFound: Boolean
    begin
        PackageADRLines.SetRange("Package No.", PackageADRContent."Package No.");
        PackageADRLines.SetRange("Line Type", PackageADRContent."Line Type"::ADR);
        PackageADRLines.SetRange("Template Type", 0);
        PackageADRLines.SetRange("Template Subtype", 0);
        PackageADRLines.SetRange("Template No.", '');
        PackageADRLines.SetRange("Template Line No.", 0);
        PackageADRLines.SetRange("Template Sub Line No.", 0);
        PackageADRLines.SetRange("Line No.", 0);
        if not PackageADRLines.IsEmpty then
            PackageADRLinesFound := PackageADRLines.Find('-');
    end;

    [EventSubscriber(ObjectType::Table, database::"ESNPackage ADR ContentShip", 'OnAfterInsertEvent', '', true, false)]
    local procedure PackageADRContent_OnAfterInsertEvent(var Rec: Record "ESNPackage ADR ContentShip")
    var
        ADR: Record ESNADRShip;
        PackageADRLine: Record "ESNPackage ADR ContentShip";
    begin
        case Rec."Line Type" of
            Rec."Line Type"::Content:
                begin
                    Rec.TestField("ADR No.");
                    PackageADRLine.SetRange("ADR No.", Rec."ADR No.");
                    if not GetPackageADRLines(Rec, PackageADRLine) then begin
                        PackageADRLine."Package No." := Rec."Package No.";
                        PackageADRLine."Line Type" := Rec."Line Type"::ADR;
                        PackageADRLine."ADR No." := Rec."ADR No.";
                        if ADR.get(Rec."ADR No.") then
                            if ADR."Limited Quantities" = 0 then begin
                                PackageADRLine.Validate("ADR Content Unit of Measure", Rec."ADR Unit of Measure");
                            end else begin
                                PackageADRLine.Validate("ADR Content Unit of Measure", ADR."Limited Quantity Unit");
                            end;
                        PackageADRLine.CalcPackageQuantityGrMl();
                        PackageADRLine.Insert(true);
                    end else begin
                        PackageADRLine.CalcPackageQuantityGrMl();
                        PackageADRLine.Modify(true);
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"ESNPackage ADR ContentShip", 'OnAfterDeleteEvent', '', true, false)]
    local procedure PackageADRContent_OnAfterDeleteEvent(var Rec: Record "ESNPackage ADR ContentShip")
    var
        PackageADRLines: Record "ESNPackage ADR ContentShip";
    begin
        case rec."Line Type" of
            rec."Line Type"::Content:
                begin
                    PackageADRLines.SetRange("ADR No.", rec."ADR No.");
                    if GetPackageADRLines(Rec, PackageADRLines) then
                        repeat
                            PackageADRLines.CalcPackageQuantityGrMl();
                            PackageADRLines.Modify(true);
                            if PackageADRLines."ADR Content Quantity" <= 0 then
                                PackageADRLines.Delete(true);
                        until PackageADRLines.Next() = 0;
                end;
        end;
    end;
    #endregion

    #region RegisterPackage / UnRegisterPackage 
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnRegisterPackageContentSetrange', '', true, false)]
    local procedure OnRegisterPackageContentSetrange(Package: Record "ETI-Package-NC")
    var
        PackageADRLines: Record "ESNPackage ADR ContentShip";
        RegPackageADRLines: Record "ESNReg. Package ADR ContShip";
    begin
        // Transfer ADR Lines to Reg. Package
        PackageADRLines.SetRange("Package No.", Package."No.");
        PackageADRLines.SetRange("Line Type", PackageADRLines."Line Type"::ADR);
        if not PackageADRLines.IsEmpty then
            if PackageADRLines.Find('-') then
                repeat
                    RegPackageADRLines.TransferFields(PackageADRLines, true);
                    RegPackageADRLines.Insert(true);
                until PackageADRLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnBeforInsertRegPackageContent', '', true, false)]
    local procedure OnBeforInsertRegPackageContent(Package: Record "ETI-Package-NC"; PackageContent: Record "ETI-Package Content-NC")
    var
        PackageADRLines: Record "ESNPackage ADR ContentShip";
        RegPackageADRLines: Record "ESNReg. Package ADR ContShip";
    begin
        // Transfer Content ADR Lines to Reg. Package
        if GetPackageContentADRLines(PackageContent, PackageADRLines) then
            repeat
                RegPackageADRLines.TransferFields(PackageADRLines, true);
                RegPackageADRLines.Insert(true);
            until PackageADRLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnUndoRegisterPackageContentSetrange', '', true, false)]
    local procedure OnUndoRegisterPackageContentSetrange(RegPackage: Record "ETI-Reg. Package-NC")
    var
        PackageADRLines: Record "ESNPackage ADR ContentShip";
        RegPackageADRLines: Record "ESNReg. Package ADR ContShip";
    begin
        // Transfer ADR Lines to Reg. Package
        RegPackageADRLines.SetRange("Package No.", regPackage."No.");
        RegPackageADRLines.SetRange("Line Type", RegPackageADRLines."Line Type"::ADR);
        if not RegPackageADRLines.IsEmpty then
            if RegPackageADRLines.Find('-') then
                repeat
                    PackageADRLines.TransferFields(RegPackageADRLines, true);
                    if PackageADRLines.Insert(true) then;
                until RegPackageADRLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ETI-Package Mgt-NC", 'OnBeforInsertPackageContent', '', true, false)]
    local procedure OnBeforInsertPackageContent(RegPackageContent: Record "ETI-Reg. Package Content-NC")
    var
        PackageADRLines: Record "ESNPackage ADR ContentShip";
        RegPackageADRLines: Record "ESNReg. Package ADR ContShip";
    begin
        // Transfer Content ADR Lines to Reg. Package
        if GetPackageContentADRLines(RegPackageContent, RegPackageADRLines) then
            repeat
                PackageADRLines.TransferFields(RegPackageADRLines, true);
                if PackageADRLines.Insert(true) then;
            until RegPackageADRLines.Next() = 0;
    end;
    #endregion
}