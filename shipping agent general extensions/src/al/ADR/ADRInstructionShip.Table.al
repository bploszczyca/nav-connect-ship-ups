table 70869753 "ESNADR InstructionShip"
{
    Caption = 'ADR Instruction', Comment = 'ADR Anweisung';
    DataClassification = ToBeClassified;
    LookupPageId = "ESNADR InstructionsShip";

    fields
    {
        field(1; "ADR No."; Code[10])
        {
            Caption = 'ADR No.', Comment = 'ADR Nr.';
            DataClassification = CustomerContent;
            TableRelation = "ESNADRShip"."No.";
        }
        field(2; Groupe; Enum "ESNADR Instruction GroupShip")
        {
            Caption = 'Groupe';
            DataClassification = ToBeClassified;
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = if ("ADR No." = filter('<>''''')) "ESNADR InstructionShip".Code where(Groupe = field(Groupe));
            ValidateTableRelation = false;
        }
        field(4; Lable; Enum "ESNADR LableShip")
        {
            Caption = 'Lable', Comment = 'Gefahrzette';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "ADR No.", Groupe, Code, Lable) { Clustered = true; }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description) { }
    }

    trigger OnInsert()
    var
        ADRInstruction: Record "ESNADR InstructionShip";
    begin
        if ("ADR No." <> '') then begin
            if not ADRInstruction.get('', Groupe, Code) then begin
                ADRInstruction.Init();
                ADRInstruction."ADR No." := '';
                ADRInstruction.Groupe := Groupe;
                ADRInstruction.Code := Code;
                ADRInstruction.Description := Description;
                OnBeforInsertGeneralADRInstructionRecord(rec, ADRInstruction);
                if ADRInstruction.Insert(true) then;
            end;
        end;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforInsertGeneralADRInstructionRecord(ADRInstructionRecord: Record "ESNADR InstructionShip"; var GeneralADRInstructionRecord: Record "ESNADR InstructionShip")
    begin
    end;
}