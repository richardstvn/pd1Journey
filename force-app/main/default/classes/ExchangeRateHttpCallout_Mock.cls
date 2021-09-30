@IsTest
public class ExchangeRateHttpCallout_Mock implements HttpCalloutMock {
  
  public HttpResponse respond(HttpRequest req) {
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');
    res.setBody('{"success":true,"timestamp":1632872365,"base":"EUR","date":"2021-09-29","rates":{"USD":1.164575,"GBP":0.864249,"INR":86.460789,"AUD":1.611095,"CAD":1.478278,"SGD":1.581990}}');
    res.setStatusCode(200);

    return res;
  }
  
}
