permissionset 70869750 "ESNProcADRShip"
{
    Caption = 'Process ADR Shipment';
    Assignable = true;
    Permissions = tabledata "ESNADR ClassificationShip" = R,
        tabledata "ESNADR InstructionShip" = R,
        tabledata "ESNADR TranslationShip" = R,
        tabledata ESNADRShip = R,
        tabledata "ESNItem ADR QuantityShip" = R,
        tabledata "ESNPackage ADR ContentShip" = RIMD,
        tabledata "ESNReg. Package ADR ContShip" = RIMD,
        table "ESNADR ClassificationShip" = X,
        table "ESNADR InstructionShip" = X,
        table "ESNADR TranslationShip" = X,
        table ESNADRShip = X,
        table "ESNItem ADR QuantityShip" = X,
        table "ESNPackage ADR ContentShip" = X,
        table "ESNReg. Package ADR ContShip" = X,
        codeunit "ESNADR ManagementShip" = X,
        codeunit "ESNADR Package ManagementShip" = X,
        codeunit "ESNShipment Mgt.Ship" = X,
        codeunit "ESNShipping Agent APIShip" = X;
}