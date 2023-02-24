page 70869755 "ESNADR Instructions CardShip"
{
    Caption = 'ADR Instructions', Comment = 'ADR Anweisungen';
    PageType = Card;
    SourceTable = "ESNADRShip";
    DataCaptionFields = "No.", Description;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
                field(Class; rec.Class) { ApplicationArea = All; }
                field("Classification Code"; rec."Classification Code") { ApplicationArea = All; }
                field("Packing Group"; rec."Packing Group") { ApplicationArea = All; }
                field("Limited Quantities"; rec."Limited Quantities") { ApplicationArea = All; }
                field("Limited Quantity Unit"; rec."Limited Quantity Unit") { ApplicationArea = All; }
                field("Excepted Quantities"; rec."Excepted Quantities") { ApplicationArea = All; }
                field("Hazard identification No."; rec."Hazard identification No.") { ApplicationArea = All; }
            }
            group(GeneralProvisions)
            {
                Caption = 'General Provisions';
                part(Lable; "ESNADR LableInst. SubPageShip")
                {
                    ApplicationArea = all;
                    Caption = 'Lable', Comment = 'Gefahrzette';
                    SubPageLink = "ADR No." = field("No."), Groupe = const("Lable"), Code = const('-');
                }
                part(SpecialProvisions; "ESNADR Instruct. SubPageShip")
                {
                    ApplicationArea = all;
                    Caption = 'Special Provisions', Comment = 'Sondervorschrifte';
                    SubPageLink = "ADR No." = field("No."), Groupe = const("Special Provisions");
                }
            }
            group(Packing)
            {
                Caption = 'Packing';
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
            }
            group(PortableTanks)
            {
                Caption = 'Portable Tanks';
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
            }
            group(ADRTank)
            {
                Caption = 'ADR Tank';
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
            }
            part(VehicleForTankCarriage; "ESNADR Instruct. SubPageShip")
            {
                ApplicationArea = all;
                Caption = 'Vehicle For Tank Carriage';
                SubPageLink = "ADR No." = field("No."), Groupe = const("Vehicle for tank carriage");
            }
            group(Transport)
            {
                Caption = 'Transport category';
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
            }

            group(SpecialProvisionsForCarriage)
            {
                Caption = 'Special provisions for carriage';
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
        area(FactBoxes)
        {
            part(ADRAssiItems; "ESNADR Assi. ItemsShip")
            {
                ApplicationArea = all;
                SubPageLink = "ADR No." = field("No.");
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