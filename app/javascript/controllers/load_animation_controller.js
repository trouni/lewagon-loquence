import { Controller } from "stimulus"
import Vue from 'vue/dist/vue.esm'
import AnimatedNumber from 'animated-number-vue'

export default class extends Controller {
  static targets = [ "number" ]

  connect() {
    this.numberTargets.forEach((number) => {
      const app = new Vue({
        components: { AnimatedNumber },
        data() {
          return {
            defaultDuration: 1000 + Math.random() * 1500
          };
        },
        methods: {
          JPY(value) {
            return `¥${Math.round(value).toLocaleString('ja')}`;
          },
          localIntegerJP(value) {
            return Math.round(value).toLocaleString('ja');
          },
          localFloat1JP(value) {
            return value.toFixed(1).toLocaleString('ja');
          },
          localFloat2JP(value) {
            return value.toFixed(2).toLocaleString('ja');
          },
          localFloatJP(value) {
            return this.localFloat2JP(value);
          },
          localJP(value) {
            return value.toLocaleString('ja');
          },
          percent(value) {
            return `${value.toFixed(2)}%`;
          },
          float1(value) {
            return this.localFloat1JP(value);
          },
          float2(value) {
            return this.localFloat2JP(value);
          },
          float(value) {
            return this.float2(value);
          },
          integer(value) {
            return this.localIntegerJP(value);
          }
        }
      }).$mount(number)
    })
  }
}
