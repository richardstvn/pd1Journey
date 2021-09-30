trigger CloudNewsTrigger on Cloud_News__e (after insert) {

  List<Case> caseList;
  Id queueId;
  for (Cloud_News__e cn : Trigger.new) {
    if (cn.Urgent__c) {
      caseList = (caseList == null) ? new List<Case>() : caseList;
      queueId = (queueId == null) ? [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Regional Dispatch'][0].Id : queueId;

      caseList.add(new Case(
        Priority = 'High'
        , Status = 'New'
        , OwnerId = queueId
        , Subject = 'New dispatched to ' + cn.Location__c
        , Description = 'CreatedBy: ' + cn.CreatedBy + ', CreatedDate: ' + cn.CreatedDate + ', EventUuid: ' + cn.EventUuid + ', ReplayId: ' + cn.ReplayId
      ));
    }
  }

  if (caseList != null && caseList.size() > 0) {
    insert caseList;
  }

}