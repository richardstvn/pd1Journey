public abstract with sharing class BaseExchangeRateService {
  
  public class CurrencyCode2Rate {
    @AuraEnabled
    public String CurrencyCode { get; set; }
    @AuraEnabled
    public Decimal Rate { get; set; }

    public CurrencyCode2Rate(String CurrencyCode, Decimal Rate) {
      this.CurrencyCode = CurrencyCode;
      this.Rate = Rate;
    }
  }
  
  public class ExRate {
    @AuraEnabled
    public String base { get; set; }
    @AuraEnabled
    public String baseDate { get; set; }
    @AuraEnabled
    public List<CurrencyCode2Rate> targetRates {
      get{
        if (this.targetRates == null) {
          this.targetRates = new List<CurrencyCode2Rate>();
        }

        return targetRates;
      } 
    set; }
  }

  public abstract ExRate getLatestRates(String base);

}