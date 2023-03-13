tableextension 70869803 "ESNReg. PackageUPS" extends "ETI-Reg. Package-NC"
{
    fields
    {
        field(70869800; "ESNReturn ServiceUPS"; Enum "ESNReturn ServiceUPS")
        {
            Caption = 'Return Service';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869801; "ESNNotification CodeUPS"; Enum "ESNNotification CodeUPS")
        {
            Caption = 'UPS Notification Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869802; "ESNUPS Packaging CodeUPS"; Enum "ESNPackaging CodeUPS")
        {
            Caption = 'UPS Packaging Code', Comment = 'UPS Verpackuntsart';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869803; "ESNUPS Premier CategoryUPS"; Enum "ESNUPS Premier CategoryUPS")
        {
            Caption = 'UPS Premier Category';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869804; "ESNUPS Premier SensorIDUPS"; Text[50])
        {
            Caption = 'UPS Premier SensorID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869806; "ESNLabel Image FormatUPS"; Enum "ESNLabel Image FormatUPS")
        {
            Caption = 'Label Image Format';
            DataClassification = CustomerContent;
        }
        field(70869805; "ESNUPS Simple RateUPS"; Enum "ESNUPS Simple RateUPS")
        {
            Caption = 'UPS Simple Rate';
            DataClassification = CustomerContent;
            Editable = false;
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