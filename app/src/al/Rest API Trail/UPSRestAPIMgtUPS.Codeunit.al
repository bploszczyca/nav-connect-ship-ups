codeunit 70869799 "ESNRest API Teach CU UPS"
{

    trigger OnRun()
    begin
        HttpClientGetByURI();
    end;

    // Von innen auf REST-Services in Dynamics 365 Business Central zugreifen
    // https://learn.microsoft.com/de-de/training/modules/access-rest-services/

    var
        MyHttpClient: HttpClient;
        MyHttpContent: HttpContent;
        MyHttpHeaders: HttpHeaders;

        MyHttpRequestMessage: HttpRequestMessage;
        MyHttpResponseMessage: HttpResponseMessage;

    procedure HttpClientGetByBaseAddress()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
    begin
        Client.SetBaseAddress('https://jsonplaceholder.typicode.com/posts');
        Client.get('posts', ResponseMessage);
    end;

    procedure HttpClientGetByURI()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseHttpHeaders: HttpHeaders;
        ResponseHttpContent: HttpContent;
        ResponseHttpStatusCode: Integer;
        ResponseContent: Text;
    begin
        Client.get('https://jsonplaceholder.typicode.com/posts', ResponseMessage);
        ResponseHttpHeaders := ResponseMessage.Headers;
        ResponseHttpContent := ResponseMessage.Content;
        ResponseHttpStatusCode := ResponseMessage.HttpStatusCode;
        if ResponseMessage.IsBlockedByEnvironment then begin
            Error('IsBlockedByEnvironment');
        end;
        if not ResponseMessage.IsSuccessStatusCode then begin
            Error(ResponseMessage.ReasonPhrase);
        end;

        ResponseHttpContent.ReadAs(ResponseContent);
        Message('ResponseContent: %1', ResponseContent);
    end;

    procedure HttpClientGetByRequestMessage()
    var
        RequestMessage: HttpRequestMessage;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseHttpHeaders: HttpHeaders;
        ResponseHttpContent: HttpContent;
        ResponseHttpStatusCode: Integer;
        ResponseContent: Text;
    begin
        // Die folgenden Verben sind die am häufigsten verwendeten Verben in REST-Services:
        // GET (zum Lesen von Daten)
        // POST (zum Erstellen von Daten)
        // PUT (zum Aktualisieren/Ersetzen von Daten)
        // PATCH (zum Aktualisieren/Ändern von Daten)
        // DELETE (zum Löschen von Daten)
        RequestMessage.Method('GET');
        RequestMessage.SetRequestUri('https://jsonplaceholder.typicode.com/posts');

        Client.Send(RequestMessage, ResponseMessage);

        ResponseHttpHeaders := ResponseMessage.Headers;
        ResponseHttpContent := ResponseMessage.Content;
        ResponseHttpStatusCode := ResponseMessage.HttpStatusCode;
        if ResponseMessage.IsBlockedByEnvironment then begin
            Error('IsBlockedByEnvironment');
        end;
        if not ResponseMessage.IsSuccessStatusCode then begin
            Error(ResponseMessage.ReasonPhrase);
        end;

        ResponseHttpContent.ReadAs(ResponseContent);
        Message('ResponseContent: %1', ResponseContent);
    end;


    procedure GetUserInformation(UserNumber: Integer)
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseString: Text;
    begin
        if not Client.Get(StrSubstNo('https://jsonplaceholder.typicode.com/users/%1', UserNumber), ResponseMessage) then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\' +
                    'Status code: ' + Format(ResponseMessage.HttpStatusCode()) +
                    'Description: ' + ResponseMessage.ReasonPhrase());

        ResponseMessage.Content().ReadAs(ResponseString);
        Message('ResponseContent: %1', ResponseString);
    end;

    procedure CreatePostUserInformation()
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
        ResponseString: Text;
        JObject: JsonObject;
        JsonText: Text;
    begin

        JObject.Add('userId', 2);
        JObject.Add('id', 101);
        JObject.Add('title', 'Microsoft Dynamics 365 Business Central Post Test');
        JObject.Add('body', 'This is a MS Dynamics 365 Business Central Post Test');
        JObject.WriteTo(JsonText);

        Content.WriteFrom(JsonText);

        if not Client.Post('https://jsonplaceholder.typicode.com/posts', Content, ResponseMessage) then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\' +
                    'Status code: ' + Format(ResponseMessage.HttpStatusCode()) +
                    'Description: ' + ResponseMessage.ReasonPhrase());

        ResponseMessage.Content().ReadAs(ResponseString);

        Message('ResponseString: %1', ResponseString);
    end;
}