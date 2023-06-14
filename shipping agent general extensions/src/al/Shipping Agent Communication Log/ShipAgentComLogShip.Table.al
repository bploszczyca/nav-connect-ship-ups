table 70869757 "ESNShip. Agent Com. LogShip"
{
    Caption = 'Shipping Agent Communication Log';
    DataClassification = CustomerContent;
    CompressionType = Page;
    LookupPageId = "ESNShip. Agent Com. LogShip";
    DrillDownPageId = "ESNShip. Agent Com. LogShip";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Time; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            Editable = false;
        }
        field(20; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(21; "Source Subtype"; Integer)
        {
            Caption = 'Source Subtype';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(22; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(23; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(24; "Source Subline No."; Integer)
        {
            Caption = 'Source Subline No.';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(25; "Source Batch Name"; Code[20])
        {
            Caption = 'Source Batch Name';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(26; "Source Doc. No. Occurrence"; Integer)
        {
            Caption = 'Source Doc. No. Occurrence';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(27; "Source Version No."; Integer)
        {
            Caption = 'Source Version No.';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }
        field(29; "Source RecordId"; RecordId)
        {
            Caption = 'Source RecordId';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            var
                ShipAgComLogMgt: Codeunit "ESNShip. Ag. Com. Log Mgt.Ship";
            begin
                ShipAgComLogMgt.SetDocEntryLinkSrcFieldsByRecordID("Source RecordId", Rec);
            end;

            trigger OnLookup()
            begin
                OnLookupSourceRecord();
            end;
        }

        field(30; "Shipping Agent Code"; Code[10])
        {
            DataClassification = CustomerContent;
            AccessByPermission = TableData 5790 = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(31; "Shipping Agent Service Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            Editable = false;
        }

        field(35; "Shipping Agent API"; Enum "ESNShipping AgentShip")
        {
            Caption = 'Shipping Agent API';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(40; "Send Data"; Blob)
        {
            Caption = 'Send Data';
            DataClassification = CustomerContent;
            Compressed = true;
        }
        field(41; "Received Data"; Blob)
        {
            Caption = 'Received Data';
            DataClassification = CustomerContent;
            Compressed = true;
        }

        field(50; "Status"; Enum "ESNShip. Agent Com. StatusShip")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                if xRec.Status <> Status then begin
                    "Status Text" := '';
                end;
            end;
        }
        field(51; "Status Text"; Text[250])
        {
            Caption = 'Status Text';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "HTTP Status Code"; Integer)
        {
            Caption = 'HTTP Status Code';
            DataClassification = CustomerContent;
            Editable = false;
            BlankZero = true;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(SourceFields; "Source No.", "Source Line No.", "Source Subline No.", "Source Type", "Source Subtype") { }
    }


    trigger OnInsert()
    begin
        SetUserIDAndDateTime();
    end;

    trigger OnModify()
    begin
        SetUserIDAndDateTime();
    end;

    local procedure SetUserIDAndDateTime()
    begin
        "User ID" := UserId;
        Time := Time;
        "Date and Time" := CurrentDateTime;
    end;

    local procedure OnLookupSourceRecord()
    var
        AllRecs: RecordRef;
        AllRecsVariatn: Variant;
    begin
        if AllRecs.get("Source RecordId") then begin
            AllRecs.SetRecFilter();
            AllRecsVariatn := AllRecs;
            page.Run(0, AllRecsVariatn);
        end;
    end;

    procedure GetSendData() SendData: Text
    var
        SendDataIoS: InStream;
    begin
        if "Send Data".HasValue then begin
            CalcFields("Send Data");

            "Send Data".CreateInStream(SendDataIoS);
            SendDataIoS.ReadText(SendData);
        end;
    end;

    procedure GetReceivedData() ReceivedData: Text
    var
        ReceivedDataIoS: InStream;
    begin
        if "Received Data".HasValue then begin
            CalcFields("Received Data");

            "Received Data".CreateInStream(ReceivedDataIoS);
            ReceivedDataIoS.ReadText(ReceivedData);
        end;
    end;

}