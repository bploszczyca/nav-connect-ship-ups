enum 70869762 "ESNPackaging TypeShip"
{
    Caption = 'Packaging Type', Comment = 'Verpackungsart';
    Extensible = true;

    value(0; "OTHER") { Caption = 'OTHER', comment = 'sonstige'; }

    value(100; "ALUMINUM BOX") { Caption = 'ALUMINUM BOX', comment = 'Aluminium Box'; }
    value(110; "ALUMINUM CYLINDERS") { Caption = 'ALUMINUM CYLINDERS', comment = 'Aluminium Zylinder'; }
    value(120; "ALUMINUM DRUM") { Caption = 'ALUMINUM DRUM', comment = 'Aluminium Trommel'; }
    value(130; "ALUMINUM JERRICAN") { Caption = 'ALUMINUM JERRICAN', comment = 'Aluminium Kanister'; }

    value(200; "CARTON") { Caption = 'CARTON', comment = 'Karton'; }
    value(210; "CYLINDERS") { Caption = 'CYLINDERS', comment = 'Zylinder'; }
    value(220; "ENVIROTAINER") { Caption = 'ENVIROTAINER', comment = 'Frachtcontainer'; }
    value(230; "FIBER DRUM") { Caption = 'FIBER DRUM', comment = 'Faser Trommel'; }
    value(240; "FIBERBOARD BOX") { Caption = 'FIBERBOARD BOX', comment = 'Faser Box'; }

    value(300; "PLASTIC BOX") { Caption = 'PLASTIC BOX', comment = 'Kunststoff'; }
    value(310; "PLASTIC DRUM") { Caption = 'PLASTIC DRUM', comment = 'Kunststoff Trommel'; }
    value(320; "PLASTIC JERRICAN") { Caption = 'PLASTIC JERRICAN', comment = 'Kunststoff Kanister'; }
    value(330; "PLASTIC PAIL") { Caption = 'PLASTIC PAIL', comment = 'Kunststoff Eimer'; }

    value(400; "WOOD(EN) BOX") { Caption = 'WOOD(EN) BOX', comment = 'Holz Box'; }
    value(410; "PLYWOOD BOX") { Caption = 'PLYWOOD BOX', comment = 'Sperrholz Kisten'; }
    value(420; "PLYWOOD DRUM") { Caption = 'PLYWOOD DRUM', comment = 'Sperrholz Trommel'; }

    value(500; "METAL BOX") { Caption = 'METAL BOX', comment = 'Metall Box'; }
    value(510; "STEEL BOX") { Caption = 'STEEL BOX', comment = 'Stahl Box'; }
    value(520; "STEEL DRUM") { Caption = 'STEEL DRUM', comment = 'Stahl Trommel'; }
    value(530; "STEEL JERRICAN") { Caption = 'STEEL JERRICAN', comment = 'Stahl Kanister'; }

    value(600; "STYROFOAM BOX") { Caption = 'STYROFOAM BOX', comment = 'Styropor Box'; }

}