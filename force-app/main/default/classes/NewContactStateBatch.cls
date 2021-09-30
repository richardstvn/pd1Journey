public class NewContactStateBatch implements Database.Batchable<SObject> {
    
  private String stateNewPoint;

  public NewContactStateBatch(String state) {
    this.stateNewPoint = String.escapeSingleQuotes(state);
  }

  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('SELECT Id FROM Account WHERE BillingState = \'' + this.stateNewPoint + '\'');
  }

  public void execute(Database.BatchableContext bc, List<Account> accountList) {
    List<Contact> contactList = new List<Contact>();
    Integer index = 1;
    for (Account acct : accountList) {
      contactList.add(new Contact(
        LastName = 'New point of Contact #' + index
        , AccountId = acct.Id
      ));
      index++;
    }

    if (contactList.size() > 0) insert contactList;
  }

  public void finish(Database.BatchableContext bc) {

  }

}