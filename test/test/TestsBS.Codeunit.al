codeunit 50190 "ESN Client Request TestsBS"
{
    // Subtype = Test;
    // TestPermissions = Disabled;
    // // TestIsolation = Function;

    // var
    //     GenSingleInstFunc: Codeunit "ESNGen. SingleInst. Func.BS";
    //     BCScanFunctions: Codeunit "ESNWS FunctionsBS";
    //     Assert: Codeunit "Library Assert";
    // // UtilityLib: Codeunit "Library - Utility";

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Init SupressCommit"();
    // begin
    //     GenSingleInstFunc.SetSupressCommit(true);
    //     Assert.AreEqual(true, GenSingleInstFunc.GetSupressCommit(), 'SupressCommit not set.');
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Init RunASSERTERROR"();
    // begin
    //     GenSingleInstFunc.SetRunASSERTERROR(true);
    //     Assert.AreEqual(true, GenSingleInstFunc.GetRunASSERTERROR(), 'RunASSERTERROR not set.');
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on Empty ClientRequest"();
    // begin
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC('');
    //     end else begin
    //         BCScanFunctions.JSONRPC('');
    //     end;
    // end;


    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing 'Version' ClientRequest"();
    // var
    //     ReqJsonObject: JsonObject;
    //     ReqText: Text;
    // begin
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on uknow 'Version' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     ReqText: Text;
    // begin
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), '999');
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing 'ApiLevel' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     ReqText: Text;
    // begin
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on unknown 'ApiLevel' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     ReqText: Text;
    // begin
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 999);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing 'uniqueId' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     ReqText: Text;
    // begin
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on requests[x] is not an JsonObject ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArray.Add('Text');
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing requests[x] 'id' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add('Unknown', 1);
    //     // RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);

    //     RequestsArray.Add(RequestsArrayObject);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing requests[x] 'scope' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);

    //     RequestsArray.Add(RequestsArrayObject);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on unknown requests[x] 'scope' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsScopeToken(), 'test');

    //     RequestsArray.Add(RequestsArrayObject);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on missing requests[x] 'method' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');

    //     RequestsArray.Add(RequestsArrayObject);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on requests[x] 'id' not unique ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     RequestsArrayObject2: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');
    //     RequestsArray.Add(RequestsArrayObject);

    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsIDToken(), 1);
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');

    //     RequestsArray.Add(RequestsArrayObject2);

    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;


    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on requests[x] 'id' not a JsonValue ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     RequestsArrayObject2: JsonObject;

    //     TempJsonObject: JsonObject;
    //     TempJsonObjectText: Text;

    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);


    //     TempJsonObject.Add('Key', 'Value');
    //     TempJsonObject.WriteTo(TempJsonObjectText);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), TempJsonObject);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');
    //     RequestsArray.Add(RequestsArrayObject);

    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsIDToken(), '2');
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');

    //     RequestsArray.Add(RequestsArrayObject2);

    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;

    // [Test]
    // [TransactionModel(TransactionModel::AutoRollback)]
    // procedure "Error on requests[x] unknow 'scope' ClientRequest"();
    // var
    //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    //     ReqJsonObject: JsonObject;
    //     RequestsArray: JsonArray;
    //     RequestsArrayObject: JsonObject;
    //     RequestsArrayObject2: JsonObject;
    //     ReqText: Text;
    //     UniqueId: Guid;
    // begin
    //     UniqueId := CreateGuid();
    //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);

    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsIDToken(), 1);
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');
    //     RequestsArray.Add(RequestsArrayObject);

    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsIDToken(), 2);
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsScopeToken(), 'base');
    //     RequestsArrayObject2.Add(ProcessClientRequest.GetRequestsMethodToken(), 'MethodName');
    //     RequestsArray.Add(RequestsArrayObject2);

    //     ReqJsonObject.add(ProcessClientRequest.GetRequestsToken(), RequestsArray);
    //     ReqJsonObject.WriteTo(ReqText);
    //     if GenSingleInstFunc.GetRunASSERTERROR() then begin
    //         ASSERTERROR BCScanFunctions.JSONRPC(ReqText);
    //     end else begin
    //         BCScanFunctions.JSONRPC(ReqText);
    //     end;
    // end;


    // // [Test]
    // // [TransactionModel(TransactionModel::AutoRollback)]
    // // procedure "Error on Doble use of UniqueId ClientRequest"();
    // // var
    // //     ProcessClientRequest: Codeunit "ESNProcess Client RequestBS";
    // //     ReqJsonObject: JsonObject;
    // //     ReqText: Text;
    // //     UniqueId: Guid;
    // // begin
    // //     UniqueId := CreateGuid();
    // //     ReqJsonObject.Add(ProcessClientRequest.GetRequestVersionToken(), 1);
    // //     ReqJsonObject.add(ProcessClientRequest.GetRequestApiLevelToken(), 1);
    // //     ReqJsonObject.add(ProcessClientRequest.GetRequestUniqueIdToken(), UniqueId);
    // //     ReqJsonObject.WriteTo(ReqText);
    // //     BCScanFunctions.JSONRPC(ReqText);
    // //     BCScanFunctions.JSONRPC(ReqText);
    // // end;
}