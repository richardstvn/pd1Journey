public class PreferredContactMethodBatch implements Database.Batchable<SObject> {
    
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('SELECT Id, Preferred_Contact_Method__c FROM Contact');
  }

  public void execute(Database.BatchableContext bc, List<Contact> contactList) {
    List<Contact> cntMethodList = new List<Contact>();
    for (Contact c : contactList) {
      c.Preferred_Contact_Method__c = 'Mobile';
      cntMethodList.add(c);
    }

    if (cntMethodList.size() > 0) update contactList;
  }

  public void finish(Database.BatchableContext bc) {

  }

}