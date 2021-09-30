public with sharing class FixerIOService extends BaseExchangeRateService {

  private static final String ACCESS_KEY;
  private static final String ENDPOINT;

  static {
    Finance__mdt fs = (Finance__mdt) Finance__mdt.getInstance('Fixer_io');
    if (fs != null) {
      ACCESS_KEY = fs.Access_Key__c;
      ENDPOINT = fs.Endpoint__c;
    }
  }

  public override BaseExchangeRateService.ExRate getLatestRates(String base) {
    if (String.isEmpty(base)) return null;

    if (String.isEmpty(ACCESS_KEY) || String.isEmpty(ENDPOINT)) throw new CalloutException('Access key and Endpoint are required to consume fixer.io API.');

    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(ENDPOINT + ACCESS_KEY);
    req.setMethod('GET');

    BaseExchangeRateService.ExRate exRate;
    try {
      HttpResponse res = http.send(req);
      if (res.getStatusCode() != 200) throw new CalloutException('Callout failed with status code: ' + res.getStatusCode());

      exRate = new BaseExchangeRateService.ExRate();
      System.debug(res.getBody());
      Map<String, Object> exRateRes = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
      exRate.base = (String) exRateRes.get('base');
      exRate.baseDate = (String) exRateRes.get('date');
      Map<String, Object> targetRate = (Map<String, Object>) exRateRes.get('rates');
      for (String k : targetRate.keyset()) {
          exRate.targetRates.add(new BaseExchangeRateService.CurrencyCode2Rate(k, (Decimal) targetRate.get(k)));
      }
    } catch (Exception e) {
      // System.debug('Error occured when consuming endpoint: ' + ENDPOINT + '. ' + e.getMessage());
      throw new CalloutException('Error occured when consuming endpoint: ' + ENDPOINT + '. ' + e.getMessage(), e);
    }

    return exRate;
  }

}