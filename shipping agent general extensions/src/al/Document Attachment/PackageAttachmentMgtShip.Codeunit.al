codeunit 70869755 "ESNPackage Doc. Att. Mgt.Ship"
{

    // Move Package Attachment on Register/Unregister Package
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Record Link Management", 'OnAfterCopyLinks', '', true, false)]
    local procedure RecordLinkMgt_CopyLinks(FromRecord: Variant; ToRecord: Variant)
    var
        RecRefFrom, RecRefTo : RecordRef;
        DocumentAttachment, NewDocumentAttachment : Record "Document Attachment";
        Package: Record "ETI-Package-NC";
        RegPackage: Record "ETI-Reg. Package-NC";
    begin
        RecRefFrom.GETTABLE(FromRecord);
        RecRefTo.GETTABLE(ToRecord);

        case RecRefFrom.RecordId.TableNo of
            database::"ETI-Package-NC":
                begin
                    if Package.get(RecRefFrom.RecordId) then begin
                        case RecRefTo.RecordId.TableNo of
                            database::"ETI-Reg. Package-NC":
                                begin
                                    if RegPackage.get(RecRefTo.RecordId) then begin
                                        DocumentAttachment.SetRange("Table ID", database::"ETI-Package-NC");
                                        DocumentAttachment.SetRange("No.", Package."No.");
                                        if not DocumentAttachment.IsEmpty then
                                            if DocumentAttachment.Find('-') then
                                                repeat
                                                    if DocumentAttachment."Document Reference ID".HasValue then begin
                                                        NewDocumentAttachment.Init();
                                                        NewDocumentAttachment.TransferFields(DocumentAttachment);
                                                        NewDocumentAttachment.Validate("Table ID", Database::"ETI-Reg. Package-NC");
                                                        NewDocumentAttachment.Validate("No.", RegPackage."No.");
                                                        if NewDocumentAttachment.Insert() then
                                                            DocumentAttachment.Delete();
                                                    end;
                                                until DocumentAttachment.Next() = 0;
                                    end;
                                end;
                        end;
                    end;
                end;
            database::"ETI-Reg. Package-NC":
                begin
                    if RegPackage.get(RecRefFrom.RecordId) then begin
                        case RecRefTo.RecordId.TableNo of
                            database::"ETI-Package-NC":
                                begin
                                    if Package.get(RecRefTo.RecordId) then begin
                                        DocumentAttachment.SetRange("Table ID", database::"ETI-Reg. Package-NC");
                                        DocumentAttachment.SetRange("No.", RegPackage."No.");
                                        if not DocumentAttachment.IsEmpty then
                                            if DocumentAttachment.Find('-') then
                                                repeat
                                                    if DocumentAttachment."Document Reference ID".HasValue then begin
                                                        NewDocumentAttachment.Init();
                                                        NewDocumentAttachment.TransferFields(DocumentAttachment);
                                                        NewDocumentAttachment.Validate("Table ID", Database::"ETI-Package-NC");
                                                        NewDocumentAttachment.Validate("No.", Package."No.");
                                                        if NewDocumentAttachment.Insert() then
                                                            DocumentAttachment.Delete();
                                                    end;
                                                until DocumentAttachment.Next() = 0;
                                    end;
                                end;
                        end;
                    end;
                end
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"ETI-Package-NC", 'OnAfterDeleteEvent', '', true, false)]
    local procedure Package_OnAfterDeleteEvent(var Rec: Record "ETI-Package-NC")
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        if not Rec.IsTemporary then begin
            DocumentAttachment.SetRange("Table ID", Rec.RecordId.TableNo);
            DocumentAttachment.SetRange("No.", Rec."No.");
            if not DocumentAttachment.IsEmpty then
                DocumentAttachment.DeleteAll(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"ETI-Reg. Package-NC", 'OnAfterDeleteEvent', '', true, false)]
    local procedure RecPackage_OnAfterDeleteEvent(var Rec: Record "ETI-Reg. Package-NC")
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        if not Rec.IsTemporary then begin
            DocumentAttachment.SetRange("Table ID", Rec.RecordId.TableNo);
            DocumentAttachment.SetRange("No.", Rec."No.");
            if not DocumentAttachment.IsEmpty then
                DocumentAttachment.DeleteAll(true);
        end;
    end;

    [EventSubscriber(ObjectType::Page, page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"ETI-Package-NC",
            DATABASE::"ETI-Reg. Package-NC":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Package: Record "ETI-Package-NC";
        RegPackage: Record "ETI-Reg. Package-NC";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"ETI-Package-NC":
                begin
                    RecRef.Open(DATABASE::"ETI-Package-NC");
                    if Package.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Package);
                end;
            Database::"ETI-Reg. Package-NC":
                begin
                    RecRef.Open(DATABASE::"ETI-Reg. Package-NC");
                    if RegPackage.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(RegPackage);
                end;
        end;
    end;


    procedure AddAttachment(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob")
    var
        DocStream: InStream;
    begin
        TempBlob.CreateInStream(DocStream);
        AddAttachment(DocStream, RecRef, FileName);
    end;

    procedure AddAttachment(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.SaveAttachmentFromStream(DocStream, RecRef, FileName);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', true, false)]
    local procedure DocumentAttachment_OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"ETI-Package-NC",
            DATABASE::"ETI-Reg. Package-NC":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

}
