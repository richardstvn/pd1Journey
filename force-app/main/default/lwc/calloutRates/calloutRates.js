import { LightningElement, track } from 'lwc';
import getExchangeRateList from '@salesforce/apex/ExchangeRateController.getExchangeRateList';

export default class CalloutRates extends LightningElement {

  baseSearchKey;
  targetSearchKey;
  exRateInit;
  @track exRate;
  error;

  get allBaseRates() {
    return [
      {label: 'AUD - Australian Dollar', value: 'AUD'}
      , {label: 'EUR - Euro', value: 'Euro'}
      , {label: 'USD - US Dollar', value: 'USD'}
    ];
  }

  get allTargetRates() {
    return [
      {label: '--All--', value: '--All--'}
      ,{label: 'USD - US Dollar', value: 'USD'}
      , {label: 'EUR - Euro', value: 'Euro'}
      , {label: 'AUD - Australian Dollar', value: 'AUD'}
      , {label: 'GBP - British Pound', value: 'GBP'}
      , {label: 'INR - Indian Rupee', value: 'INR'}
      , {label: 'CAD - Canadian Dollar', value: 'CAD'}
      , {label: 'SGD - Singapore Dollar', value: 'SGD'}
    ];
  }

  handleRateChange(event) {
    switch(event.target.name) {
      case 'base':
        this.baseSearchKey = event.detail.value;
        break;
      case 'target':
        this.targetSearchKey = event.detail.value;
        break;
      default:
    }
  }

  handleRateClick() {
    if (this.exRateInit) {
      this.filterTargetRate();
    } else {
      getExchangeRateList({base: this.baseSearchKey})
      .then(result => {
        this.exRateInit = result;
        this.filterTargetRate();
        this.error = undefined;
      })
      .catch(error => {
        this.exRate = undefined;
        this.error = error;
      });
    }
  }

  filterTargetRate() {
    this.exRate = {...this.exRateInit};
    if (this.targetSearchKey != '--All--') {
      this.exRate.targetRates = this.exRate.targetRates.filter(targetRate => this.targetSearchKey == targetRate.CurrencyCode);
    }
  }

}