public with sharing class ExchangeRateController {

  @AuraEnabled(cacheable=true)
  public static BaseExchangeRateService.ExRate getExchangeRateList(String base) {
    if (String.isBlank(base)) return null;

    try {
      // Start TODO
      /* ExchangeRateService.ExRate exRate = new ExchangeRateService.ExRate();

      String testStr = '{"success":true,"timestamp":1632872365,"base":"EUR","date":"2021-09-29","rates":{"USD":1.164575,"GBP":0.864249,"INR":86.460789,"AUD":1.611095,"CAD":1.478278,"SGD":1.581990}}';
      Map<String, Object> exRateRes = (Map<String, Object>) JSON.deserializeUntyped(testStr);
      exRate.base = (String) exRateRes.get('base');
      exRate.baseDate = (String) exRateRes.get('date');
      Map<String, Object> targetRate = (Map<String, Object>) exRateRes.get('rates');
      for (String k : targetRate.keyset()) {
        exRate.targetRates.add(new ExchangeRateService.CurrencyCode2Rate(k, (Decimal) targetRate.get(k)));
      }

      System.debug('exRate: ' + exRate);
      return exRate; */
      // End TODO

      
      BaseExchangeRateService rateService = new FixerIOService();
      return rateService.getLatestRates(base); 
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

}