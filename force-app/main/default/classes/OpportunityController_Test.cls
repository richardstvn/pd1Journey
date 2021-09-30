@IsTest
private class OpportunityController_Test {

  @IsTest
  static void testGetOpportunityListByStageNull(){
    System.assertEquals(0, OpportunityController.getOpportunityListByStage('').size()); 
  }

  @IsTest
  static void testGetOpportunityListByStageSingle(){
    String stageName = 'Prospecting';
    addOpportunities(1, stageName);

    System.assertEquals(1, OpportunityController.getOpportunityListByStage(stageName).size()); 
  }

  @IsTest
  static void testGetOpportunityListByStageBulk(){
    String stageName = 'Prospecting';
    addOpportunities(200, stageName);

    System.assertEquals(200, OpportunityController.getOpportunityListByStage(stageName).size()); 
  }

  static void addOpportunities(Integer numOfOpportunitise, String stageName) {
    List<Opportunity> opptList = new List<Opportunity>();

    for (Integer i = 0; i < numOfOpportunitise; i++) {
      opptList.add(new Opportunity(
        Name = 'Test Oppt #' + i
        , CloseDate = System.today() + 30
        , StageName = stageName
      ));
    }

    if (opptList.size() > 0) insert opptList;
  }

}
