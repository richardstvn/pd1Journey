@IsTest
private class NewContactStateBatch_Test {
  
  @IsTest
  static void testAddingContact4SpecificStateAccountsSingle(){
    List<Account> acctList = addAccounts4Testing(1, 'CA');

    Test.startTest();
    NewContactStateBatch nc = new NewContactStateBatch('CA');
    Id batchId = Database.executeBatch(nc);
    Test.stopTest();
    
    List<Contact> cntListDB = [SELECT Id, AccountId FROM Contact]; 
    System.assertEquals(1, cntListDB.size());
    System.assertEquals(acctList[0].Id, cntListDB[0].AccountId);
  }

  @IsTest
  static void testAddingContact4SpecificStateAccountsBulk(){
    List<Account> acctList = addAccounts4Testing(200, 'CA');
    Map<Id, Account> acctMap = new Map<Id, Account>(acctList);

    Test.startTest();
    NewContactStateBatch nc = new NewContactStateBatch('CA');
    Id batchId = Database.executeBatch(nc);
    Test.stopTest();
    
    List<Contact> cntListDB = [SELECT Id, AccountId FROM Contact];
    System.assertEquals(200, cntListDB.size());
    for (Contact c : cntListDB) {
      System.assert(acctMap.get(c.AccountId) != null);
    }
  }

  private static List<Account> addAccounts4Testing(Integer numOfAccounts, String state) {
    List<Account> acctList = new List<Account>();
    for (Integer i = 0; i < numOfAccounts; i++) {
      acctList.add(new Account(
        Name = 'Test Account #' + i
        , BillingState = state
      ));
    }

    if (acctList.size() > 0) insert acctList;

    return acctList;
  }

}