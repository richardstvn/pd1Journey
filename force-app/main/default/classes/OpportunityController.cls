public with sharing class OpportunityController {

  @AuraEnabled(cacheable=true)
  public static List<Opportunity> getOpportunityListByStage(String searchKey) {
    if (String.isBlank(searchKey)) return new List<Opportunity>();

    return getOpportunityListByField('StageName', searchKey);
  }

  public static List<Opportunity> getOpportunityListByField(String fieldName, String fieldValue) {
    fieldName = String.escapeSingleQuotes(fieldName);
    fieldValue = String.escapeSingleQuotes(fieldValue);

    if (String.isBlank(fieldName) || String.isBlank(fieldValue)) return new List<Opportunity>();

    String whereCondition = '';
    if (fieldValue != 'All') whereCondition += ' WHERE ' + fieldName + ' = \'' + fieldValue + '\'';

    return Database.query('SELECT Id, Name, Description, StageName, Amount, CloseDate, Type'
      + ' FROM Opportunity'
      + whereCondition
      + ' WITH SECURITY_ENFORCED'
    );
  }

}