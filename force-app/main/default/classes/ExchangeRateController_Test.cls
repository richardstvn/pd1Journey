@IsTest
private class ExchangeRateController_Test {
  
  @IsTest
  static void testBaseNull() {
    System.assertEquals(null, ExchangeRateController.getExchangeRateList(null));
  }

  @IsTest
  static void testBase() {
    Test.setMock(HttpCalloutMock.class, new HttpCalloutFactory_Mock.ExchangeRateHttpCallout_Mock());

    BaseExchangeRateService.ExRate exRate = ExchangeRateController.getExchangeRateList('EUR');
    System.assertEquals('EUR', exRate.base);
    System.assertEquals('2021-09-29', exRate.baseDate);
    System.assertEquals(6, exRate.targetRates.size());
  }

  @IsTest
  static void testBaseException() {
    Test.setMock(HttpCalloutMock.class, new HttpCalloutFactory_Mock.ExchangeRateHttpCalloutException_Mock());

    try {
      BaseExchangeRateService.ExRate exRate = ExchangeRateController.getExchangeRateList('EUR');
    } catch(Exception e) {
      System.assert(e != null);
    }
  }

}
