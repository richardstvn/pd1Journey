trigger AccountAddressTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

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

}