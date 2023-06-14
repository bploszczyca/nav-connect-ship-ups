codeunit 70869754 "ESNShip. Ag. Com. Log Mgt.Ship"
{

    procedure LogShippingAgentCommunication(SourceRecordID: RecordId;
         ShipAgentCode: code[10]; ShipAgentServiceCode: Code[10]; ShipAgentAPI: Enum "ESNShipping AgentShip";
         RequestHttpHeaders: HttpHeaders; RequestHttpContent: HttpContent; ResponseHttpMessage: HttpResponseMessage) LogShippingAgentCommunicationEntryNo: BigInteger
    begin
        LogShippingAgentCommunicationEntryNo := LogShippingAgentCommunication(SourceRecordID, ShipAgentCode, ShipAgentServiceCode, ShipAgentAPI, Enum::"ESNShip. Agent Com. StatusShip"::" ", 0, '', RequestHttpHeaders, RequestHttpContent, ResponseHttpMessage);
    end;

    procedure LogShippingAgentCommunication(SourceRecordID: RecordId;
        ShipAgentCode: code[10]; ShipAgentServiceCode: Code[10]; ShipAgentAPI: Enum "ESNShipping AgentShip"; Status: Enum "ESNShip. Agent Com. StatusShip"; HttpStatusCode: Integer; StatusText: text;
        RequestHttpHeaders: HttpHeaders; RequestHttpContent: HttpContent; ResponseHttpMessage: HttpResponseMessage) LogShippingAgentCommunicationEntryNo: BigInteger
    var
        ShipAgentComLog: Record "ESNShip. Agent Com. LogShip";
        SendDataOoS, ReceivedDataOoS : OutStream;
        SendData, ReceivedData : JsonObject;
        SendDataTxt, ReceivedDataTxt : Text;
    begin
        ShipAgentComLog.Validate("Source RecordId", SourceRecordID);

        ShipAgentComLog.Validate("Shipping Agent Code", ShipAgentCode);
        ShipAgentComLog.Validate("Shipping Agent Service Code", ShipAgentServiceCode);
        ShipAgentComLog.Validate("Shipping Agent API", ShipAgentAPI);

        ShipAgentComLog.Validate(Status, Status);
        ShipAgentComLog.Validate("Status Text", CopyStr(StatusText, 1, MaxStrLen(ShipAgentComLog."Status Text")));
        ShipAgentComLog.Validate("HTTP Status Code", HttpStatusCode);

        // Process Request
        ShipAgentComLog."Send Data".CreateOutStream(SendDataOoS);
        SendData.Add('RequestHttpHeaders', GetHttpHeaders(RequestHttpHeaders));
        SendData.Add('RequestHttpContent', GetHttpContent(RequestHttpContent));
        SendData.WriteTo(SendDataTxt);
        SendDataOoS.WriteText(SendDataTxt);

        // Process Response
        ShipAgentComLog."Received Data".CreateOutStream(ReceivedDataOoS);
        ReceivedData.Add('IsBlockedByEnvironment', ResponseHttpMessage.IsBlockedByEnvironment);
        ReceivedData.Add('IsSuccessStatusCode', ResponseHttpMessage.IsSuccessStatusCode);
        ReceivedData.Add('ResponseHttpHeaders', GetHttpHeaders(ResponseHttpMessage.Headers));
        ReceivedData.Add('ResponseHttpContent', GetHttpContent(ResponseHttpMessage.Content));
        ReceivedData.WriteTo(ReceivedDataTxt);
        ReceivedDataOoS.WriteText(ReceivedDataTxt);

        ShipAgentComLog.Insert(true);
        LogShippingAgentCommunicationEntryNo := ShipAgentComLog."Entry No.";
    end;

    procedure LogShippingAgentCommunicationSetStatus(LogShippingAgentCommunicationEntryNo: BigInteger; Status: Enum "ESNShip. Agent Com. StatusShip"; HttpStatusCode: Integer; StatusText: text)
    var
        ShipAgentComLog: Record "ESNShip. Agent Com. LogShip";
    begin
        if ShipAgentComLog.get(LogShippingAgentCommunicationEntryNo) then begin
            ShipAgentComLog.Validate(Status, Status);
            ShipAgentComLog.Validate("Status Text", CopyStr(StatusText, 1, MaxStrLen(ShipAgentComLog."Status Text")));
            ShipAgentComLog.Validate("HTTP Status Code", HttpStatusCode);
            ShipAgentComLog.Modify(true);
        end;
    end;


    // -------------------------------------------- HTTP content extraction --------------------------------------------
    local procedure GetHttpHeaders(HttpHeaders: HttpHeaders) Headers: JsonObject;
    var
        HttpHeaderKey: Text;
        HttpHeaderKeyValues: List of [Text];
        HttpHeaderKeyValue: Text;
        HttpHeaderKeyValuesJsonArray: JsonArray;
    begin
        foreach HttpHeaderKey in HttpHeaders.Keys() do begin
            Clear(HttpHeaderKeyValues);
            if HttpHeaders.GetValues(HttpHeaderKey, HttpHeaderKeyValues) then begin
                Clear(HttpHeaderKeyValuesJsonArray);
                foreach HttpHeaderKeyValue in HttpHeaderKeyValues do begin
                    HttpHeaderKeyValuesJsonArray.Add(HttpHeaderKeyValue);
                end;
                Headers.Add(HttpHeaderKey, HttpHeaderKeyValuesJsonArray)
            end else begin
                Headers.Add(HttpHeaderKey, '');
            end;
        end;
        MaskJsonKeys(Headers.AsToken());
    end;

    local procedure GetHttpContent(HttpContent: HttpContent) Content: Text;
    var
        HttpContentJsonToken: JsonToken;
    begin
        HttpContent.ReadAs(Content);
        if HttpContentJsonToken.ReadFrom(Content) then begin
            MaskJsonKeys(HttpContentJsonToken);
        end;
    end;


    // -------------------------------------------- Mask Json Key --------------------------------------------
    local procedure MaskJsonKeys(GivenJsonToken: JsonToken)
    var
        ArrayJsonToken: JsonToken;
        ObjectKey: Text;
        ObjectToken: JsonToken;
    begin
        if SetupKnownJsonKeysToMask then begin
            case true of
                GivenJsonToken.IsArray:
                    begin
                        foreach ArrayJsonToken in GivenJsonToken.AsArray() do begin
                            MaskJsonKeys(ArrayJsonToken)
                        end;
                    end;
                GivenJsonToken.IsObject:
                    begin
                        foreach ObjectKey in GivenJsonToken.AsObject().Keys do begin
                            if KnownJsonKeysToMask.Contains(ObjectKey.ToUpper()) then begin
                                GivenJsonToken.AsObject().Remove(ObjectKey);
                                GivenJsonToken.AsObject().Add(ObjectKey, '***');
                            end else begin
                                if GivenJsonToken.AsObject().Get(ObjectKey, ObjectToken) then
                                    MaskJsonKeys(ObjectToken);
                            end;
                        end;
                    end;
                GivenJsonToken.IsValue:
                    begin
                        // Nothig to do
                    end;
            end;
        end;
    end;

    var
        KnownJsonKeysToMask: List of [TEXT];

    local procedure SetupKnownJsonKeysToMask() MaskJsonKeys: Boolean
    var
        JsonKeysToMask: List of [TEXT];
        JsonKey: Text;
    begin
        if KnownJsonKeysToMask.Count = 0 then begin
            JsonKeysToMask(JsonKeysToMask);
            foreach JsonKey in JsonKeysToMask do begin
                KnownJsonKeysToMask.Add(JsonKey.ToUpper());
            end;
        end;
        MaskJsonKeys := KnownJsonKeysToMask.Count > 0;
    end;

    [IntegrationEvent(true, false)]
    local procedure JsonKeysToMask(var JsonKeysToMask: List of [TEXT])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"ESNShip. Ag. Com. Log Mgt.Ship", 'JsonKeysToMask', '', false, false)]
    local procedure AddJsonKeysToMask(var JsonKeysToMask: List of [Text])
    var
        PasswordKeysToMask: Label 'Password', Locked = true;
    begin
        if not JsonKeysToMask.Contains(PasswordKeysToMask) then
            JsonKeysToMask.Add(PasswordKeysToMask);
    end;


    // -------------------------------------------- Src. Entry Link --------------------------------------------
    procedure SetDocEntryLinkSrcFieldsByRecordID(GivenRecordID: RecordId; var GivenShipAgentComLog: Record "ESNShip. Agent Com. LogShip")
    var
        AllRecs: RecordRef;
    begin
        ClearDocEntryLinkSrcFields(GivenShipAgentComLog);
        AllRecs := GivenRecordID.GetRecord;

        if AllRecs.Get(GivenRecordID) then
            SetDocEntryLinkSrcFieldsByRecRef(AllRecs, GivenShipAgentComLog);
    end;

    local procedure ClearDocEntryLinkSrcFields(var GivenShipAgentComLog: Record "ESNShip. Agent Com. LogShip")
    begin
        GivenShipAgentComLog."Source Type" := 0;
        GivenShipAgentComLog."Source Subtype" := 0;
        GivenShipAgentComLog."Source No." := '';
        GivenShipAgentComLog."Source Batch Name" := '';
        GivenShipAgentComLog."Source Line No." := 0;
        GivenShipAgentComLog."Source Subline No." := 0;
        GivenShipAgentComLog."Source Version No." := 0;
        GivenShipAgentComLog."Source Doc. No. Occurrence" := 0;
    end;

    local procedure SetDocEntryLinkSrcFieldsByRecRef(GivenRecordRef: RecordRef; var GivenShipAgentComLog: Record "ESNShip. Agent Com. LogShip")
    var
        AllKeys: KeyRef;
        AllFields: FieldRef;
        X: Integer;

        CurrSourceFieldNo: Integer;
        CurrSourceFieldFieldRef: FieldRef;
        DocEntryLinkRecordRef: RecordRef;
        SourceFieldFieldFound: Boolean;

        KeyFieldOutOfRange: Label 'Table "%1" Key "%2" Field "%3" out of range.';
    begin
        AllKeys := GivenRecordRef.KeyIndex(1);
        GivenShipAgentComLog."Source Type" := GivenRecordRef.Number;
        CurrSourceFieldNo := GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Type");
        DocEntryLinkRecordRef.GetTable(GivenShipAgentComLog);
        DocEntryLinkRecordRef.SetTable(GivenShipAgentComLog);
        FOR X := 1 to AllKeys.FieldCount do begin
            SourceFieldFieldFound := false;
            AllFields := AllKeys.FieldIndex(X);
            // Get KeyField                
            if (CurrSourceFieldNo + 1) <= GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Version No.") then begin
                repeat
                    case true of
                        (AllFields.Name = 'Entry No.'):
                            begin
                                CurrSourceFieldNo := GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Line No.");
                            end;
                        (AllFields.Name = 'Version No.'):
                            begin
                                CurrSourceFieldNo := GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Version No.");
                            end;
                        (AllFields.Name = 'Doc. No. Occurrence'):
                            begin
                                CurrSourceFieldNo := GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Doc. No. Occurrence");
                            end;
                        else begin
                            CurrSourceFieldNo := CurrSourceFieldNo + 1;
                        end;
                    end;

                    CurrSourceFieldFieldRef := DocEntryLinkRecordRef.Field(CurrSourceFieldNo);
                    SourceFieldFieldFound :=
                        (AllFields.Type = CurrSourceFieldFieldRef.Type) or ((AllFields.Type = AllFields.Type::Option) and (CurrSourceFieldFieldRef.Type = CurrSourceFieldFieldRef.Type::Integer));
                until SourceFieldFieldFound or (CurrSourceFieldNo >= GivenShipAgentComLog.FieldNo(GivenShipAgentComLog."Source Version No."));
            end;
            if SourceFieldFieldFound then begin
                TransferFieldRefValue(AllFields, CurrSourceFieldFieldRef);
            end;
        end;
        // Last KeyField dont Match to Source Field
        if not SourceFieldFieldFound then begin
            // 'Table "%1" Key "%2" Field "%3" out of range.'
            error(KeyFieldOutOfRange, GivenRecordRef.Caption, AllKeys, AllFields.Caption);
        end;
        DocEntryLinkRecordRef.SetTable(GivenShipAgentComLog);
    end;

    local procedure TransferFieldRefValue(var FromFieldRef: FieldRef; var ToFieldRef: FieldRef)
    var
        IntegerValue: Integer;
        BooleanValue: Boolean;
        CurrFieldValue: Text;

    begin
        CurrFieldValue := Format(FromFieldRef.Value, 0, 9);
        case ToFieldRef.Type of
            ToFieldRef.Type::Option:
                begin
                    if Evaluate(IntegerValue, CurrFieldValue, 9) then begin
                        ToFieldRef.Value(IntegerValue)
                    end else begin
                        if MatchOptionMember(ToFieldRef.OptionMembers, CurrFieldValue, IntegerValue) then begin
                            ToFieldRef.Value(IntegerValue);
                        end else
                            if MatchOptionMember(ToFieldRef.OptionCaption, CurrFieldValue, IntegerValue) then begin
                                ToFieldRef.Value(IntegerValue);
                            end else begin
                                Evaluate(ToFieldRef, CurrFieldValue, 9);
                            end;
                    end;
                end;
            else begin
                ToFieldRef.Value(FromFieldRef.Value);
            end;
        end;
    end;

    local procedure MatchOptionMember(GivenOptionMembers: Text; GivanValueToTach: Text; var OptionIntegerValue: Integer) OptionMatched: Boolean
    var
        IntegerValue: Integer;
        OptionMembers: Text;
        OptionMemberText: Text;
        OptionSeparatorPosition: Integer;
        MatchType: Option "FullMatch","Begin With";
    begin
        For MatchType := MatchType::FullMatch to MatchType::"Begin With" do begin
            OptionMembers := GivenOptionMembers;
            if not OptionMatched then begin
                IntegerValue := 0;
            end;
            while (OptionMembers <> '') and (not OptionMatched) do begin
                OptionSeparatorPosition := StrPos(OptionMembers, ',');
                if OptionSeparatorPosition <> 0 then begin
                    OptionMemberText := CopyStr(OptionMembers, 1, OptionSeparatorPosition - 1);
                    OptionMembers := CopyStr(OptionMembers, OptionSeparatorPosition + 1);
                end else begin
                    OptionMemberText := OptionMembers;
                    OptionMembers := '';
                end;
                case MatchType of
                    MatchType::FullMatch:
                        begin
                            OptionMatched := (UpperCase(OptionMemberText) = UpperCase(GivanValueToTach));
                        end;
                    MatchType::"Begin With":
                        begin
                            OptionMatched := (StrPos(UpperCase(OptionMemberText), UpperCase(GivanValueToTach)) = 1);
                        end;
                end;
                if not OptionMatched then begin
                    IntegerValue += 1;
                end;
            end;
        end;

        OptionIntegerValue := IntegerValue;
        exit(OptionMatched);
    end;
}