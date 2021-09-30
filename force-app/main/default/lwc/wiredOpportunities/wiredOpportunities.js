import { LightningElement, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import Opportunity_OBJECT from '@salesforce/schema/Opportunity';
import StageName_FIELD from '@salesforce/schema/Opportunity.StageName';
import getOpportunityListByStage from '@salesforce/apex/OpportunityController.getOpportunityListByStage';

const STAGE_ALL = 'All';

export default class WiredOpportunities extends LightningElement {
  @wire(getObjectInfo, {objectApiName: Opportunity_OBJECT})
  opptMetadata;

  @wire(getPicklistValues, {
    recordTypeId: '$opptMetadata.data.defaultRecordTypeId'
    , fieldApiName: StageName_FIELD
  })
  opptStagePicklist;

  get allStagePicklist() {
    if (!this.opptStagePicklist.data) return [];

    return [...this.opptStagePicklist.data.values, {label: STAGE_ALL, value: STAGE_ALL}];
  }

  opptStage;
  opptColumns;
  opportunities;
  opptSize;
  error;

  init() {
    this.opptStage = STAGE_ALL;
  }

  handleStageChange(event) {
    this.opptStage = event.detail.value;
  }

  handleSearch() {
    getOpportunityListByStage({searchKey: this.opptStage})
      .then(result => {
        this.opportunities = result;
        this.opptSize = result.length;
        this.opptColumns = [];
        Object.keys(this.opportunities[0]).forEach(prop => this.opptColumns.push({label: prop, fieldName: prop}));

        this.error = undefined;
      })
      .catch(error => {
        this.opportunities = undefined;
        this.opptSize = 0;
        this.opptColumns = [];

        this.error = error;
      });
  }

  connectedCallback() {
    this.init();
    this.handleSearch();
  }

}