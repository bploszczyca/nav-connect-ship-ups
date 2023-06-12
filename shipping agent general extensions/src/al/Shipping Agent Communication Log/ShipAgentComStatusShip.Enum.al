enum 70869763 "ESNShip. Agent Com. StatusShip"
{
    Caption = 'Shipping Agent Communication Status';
    Extensible = true;

    value(0; " ") { Caption = ' '; }
    value(1000; "Prepared") { Caption = 'Prepared'; }
    value(50000; "Processing (Send)") { Caption = 'Processing (Send)'; }
    value(90000; "Error") { Caption = 'Error'; }
    value(100000; "Finished") { Caption = 'Finished'; }
}