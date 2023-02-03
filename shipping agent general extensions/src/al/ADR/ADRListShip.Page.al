page 70869752 "ESNADR ListShip"
{
    Caption = 'ADR List', Comment = 'ADR Übersicht';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ESNADRShip";
    CardPageId = "ESNADR Instructions CardShip";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DelayedInsert = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
                field(Class; rec.Class) { ApplicationArea = All; }
                field("Classification Code"; rec."Classification Code") { ApplicationArea = All; }
                field("Packing Group"; rec."Packing Group") { ApplicationArea = All; }
                field(Lable; rec.Lable) { ApplicationArea = All; }
                field("Special Provisions"; rec."Special Provisions") { ApplicationArea = All; }
                field("Excepted Quantities"; rec."Excepted Quantities") { ApplicationArea = All; }
                field("Hazard identification No."; rec."Hazard identification No.") { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            part(Packinginstructions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Packing Instructions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Packing instructions");
            }
            part(SpecialPackingProvisions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Special packing provisions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Special packing provisions");
            }
            part(MixedPpackingProvisions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Mixed packing provisions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Mixed packing provisions");
            }
            part(PortableTanksInstructions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Portable Tanks Instructions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Portable tanks instructions");
            }
            part(PortableTankSpecialProvisions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Portable Tank Special Provisions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Portable tank special provisions");
            }
            part(ADRTankCode; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'ADR Tank Code';
                SubPageLink = "ADR No." = field("No."), Groupe = const("ADR Tank Code");
            }
            part(ADRTankSpecialProvisions; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'ADR Tank Special Provisions';
                SubPageLink = "ADR No." = field("No."), Groupe = const("ADR Tank Special Provisions");
            }
            part(VehicleForTankCarriage; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Vehicle For Tank Carriage';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Vehicle for tank carriage");
            }

            part(TransportCategory; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Transport category';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Transport category");
            }
            part(TransportCategoryTunnel; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Transport category (Tunnel Restriction code)';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Transport category (Tunnel Restriction code)");
            }
            part(SpecialProvisionsForCarriagePackagess; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Special provisions for carriage - Packages';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Special provisions for carriage - Packages");
            }
            part(SpecialProvisionsForCarriageBulk; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Special provisions for carriage - Bulk';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Special provisions for carriage - Bulk");
            }
            part(SpecialProvisionsForCarriageLoadingAndUnloading; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Special provisions for carriage - Loading and unloading';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Special provisions for carriage - Loading and unloading");
            }
            part(SpecialProvisionsForCarriageOperation; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Special provisions for carriage - Operation';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Special provisions for carriage - Operation");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Translations)
            {
                ApplicationArea = Suite;
                Caption = 'Translations', Comment = 'Übersetzungen';
                Image = Translations;
                RunObject = Page "ESNADR TranslationsShip";
                RunPageLink = "ADR No." = field("No.");
                Scope = Repeater;
            }
        }
    }
}