(ns hello
  (:require [libpython-clj.require :refer [require-python]]
            [libpython-clj.python :as py :refer [py. py.. py.- $a]]))

(require-python 'torch)
(require-python 'transformers)

(def tokenizer ($a transformers/GPT2Tokenizer from_pretrained "gpt2"))
(def model ($a transformers/GPT2LMHeadModel from_pretrained "gpt2"))

(defn generate-sequence-step [{:keys [generated-tokens context past]}]
  (let [[output past] (model context :past past)
        token (-> (torch/argmax (first output)))
        new-generated  (conj generated-tokens ($a token tolist))]
    {:generated-tokens new-generated
     :context ($a token unsqueeze 0)
     :past past
     :token token}))

(defn generate-text [starting-text num-of-words-to-predict]
  (let [tokens (into [] ($a tokenizer encode starting-text))
        context (torch/tensor [tokens])
        result (reduce
                (fn [r i]
                  (println i)
                  (generate-sequence-step r))

                {:generated-tokens tokens
                 :context context
                 :past nil}

                (range num-of-words-to-predict))
        text (decode-sequence result)]
    (println text)
    text))

(defn -main [_]
  (generate-text "Potato is a " 20))
