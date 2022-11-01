import { Controller } from "@hotwired/stimulus"

// コントローラークラスを定義する
export default class extends Controller {
  // ターゲット（操作対象のDOM）のプロパティを作成
  static targets = [ "content" ]

  // アクション（イベントに紐づく処理）を定義する
  copy() {
    // xxxxTargetでターゲットとなるDOMにアクセスできる
    // ターゲット（今回であれば<input>）のvalueをログ吐き
    navigator.clipboard.writeText(this.contentTarget.innerText)
        .then(() => {
          console.log("Text copied to clipboard...")
        })
        .catch(err => {
          console.log('Something went wrong', err);
        })
  }
}