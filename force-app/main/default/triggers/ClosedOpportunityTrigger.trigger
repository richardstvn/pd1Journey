trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

  if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
    // OpportunityHandler.addTask(Trigger.new);
  }

}