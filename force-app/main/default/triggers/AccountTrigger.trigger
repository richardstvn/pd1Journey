trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

  switch on Trigger.operationType {
    when BEFORE_INSERT {
      // AccountHandler.addCounter(Trigger.new, 'Insert');
    } 
    when BEFORE_UPDATE {
      // AccountHandler.addCounter(Trigger.new, 'Update');
    }
  }

  if (Trigger.isBefore && Trigger.isInsert) {
    // AccountTriggerHandler.CreateAccounts(Trigger.New);
    // AccountHandler.matchBillingAndShipping(Trigger.New);
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    // AccountHandler.createNewOpportunity(Trigger.New);
  }

  if (Trigger.isBefore && Trigger.isDelete) {
    // AccountHandler.preventDeletion(Trigger.Old);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    /* List<Account> a2 = new List<Account>();
    for (Account a : Trigger.new) {
      Account aa = a.clone(true);
      aa.test2__c = a.test1__c + 'after';
      a2.add(aa);
    }
    upsert a2; */
  }

}