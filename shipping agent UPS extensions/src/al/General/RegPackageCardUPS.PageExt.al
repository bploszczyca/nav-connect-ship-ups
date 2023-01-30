pageextension 70869803 "ESNReg. Package CardUPS" extends "ETI-Reg. Package Card-NC"
{
    layout
    {
        addafter("Packing Material Item No.")
        {
            field("ESNUPS Packaging CodeUPS"; rec."ESNUPS Packaging CodeUPS") { ApplicationArea = All; Importance = Additional; }
            field("ESNUPS Simple RateUPS"; rec."ESNUPS Simple RateUPS") { ApplicationArea = All; Importance = Additional; }
        }
        addafter("ESNPackage CoutUPSshipShip")
        {
            field("ESNReturn ServiceUPS"; rec."ESNReturn ServiceUPS") { ApplicationArea = All; Importance = Additional; }
        }
        addlast("Packstück")
        {
            group("UPS Premier")
            {
                Caption = 'UPS Premier';
                field("ESNUPS Premier CategoryUPS"; rec."ESNUPS Premier CategoryUPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Premier SensorIDUPS"; rec."ESNUPS Premier SensorIDUPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 1.UPS"; rec."ESNUPS Pre. Handl. Instr 1.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 2.UPS"; rec."ESNUPS Pre. Handl. Instr 2.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 3.UPS"; rec."ESNUPS Pre. Handl. Instr 3.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 4.UPS"; rec."ESNUPS Pre. Handl. Instr 4.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 5.UPS"; rec."ESNUPS Pre. Handl. Instr 5.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 6.UPS"; rec."ESNUPS Pre. Handl. Instr 6.UPS") { ApplicationArea = All; Importance = Additional; }
                field("ESNUPS Pre. Handl. Instr 7.UPS"; rec."ESNUPS Pre. Handl. Instr 7.UPS") { ApplicationArea = All; Importance = Additional; }
            }
        }
    }
}