@IsTest
private class PreferredContactMethodBatch_Test {
  
  @IsTest
  static void testUpdateContactMethodSingle(){
    List<Contact> acctList = AddContacts4Testing(1);

    Test.startTest();
    PreferredContactMethodBatch pc = new PreferredContactMethodBatch();
    Id batchId = Database.executeBatch(pc);
    Test.stopTest();
    
    List<Contact> cntListDB = [SELECT Id, Preferred_Contact_Method__c FROM Contact]; 
    System.assertEquals(1, cntListDB.size());
    System.assertEquals('Mobile', cntListDB[0].Preferred_Contact_Method__c);
  }

  @IsTest
  static void testUpdateContactMethodBulk(){
    List<Contact> acctList = AddContacts4Testing(200);

    Test.startTest();
    PreferredContactMethodBatch pc = new PreferredContactMethodBatch();
    Id batchId = Database.executeBatch(pc);
    Test.stopTest();
    
    List<Contact> cntListDB = [SELECT Id, Preferred_Contact_Method__c FROM Contact];
    System.assertEquals(200, cntListDB.size());
    for (Contact c : cntListDB) {
      System.assertEquals('Mobile', c.Preferred_Contact_Method__c);
    }
  }

  private static List<Contact> AddContacts4Testing(Integer numOfContacts) {
    List<Contact> cntList = new List<Contact>();
    for (Integer i = 0; i < numOfContacts; i++) {
      cntList.add(new Contact(
        LastName = 'Test Contact #' + i
      ));
    }

    if (cntList.size() > 0) insert cntList;

    return cntList;
  }

}