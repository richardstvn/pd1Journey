trigger OrderEventTrigger on Order_Event__e (after insert) {

  List<Task> taskList;
  for (Order_Event__e oe : Trigger.new) {
    if (oe.Has_Shipped__c) {
      taskList = (taskList == null) ? new List<Task>() : taskList;
      taskList.add(new Task(
        Priority = 'Medium'
        , Subject = 'Follow up on shipped order ' + oe.Order_Number__c
        , OwnerId = oe.CreatedById
      ));
    }
  }

  if (taskList != null && taskList.size() > 0) {
    insert taskList;
  }

}