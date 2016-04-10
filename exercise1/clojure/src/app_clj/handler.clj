(ns app-clj.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [clojure.data.json :as json]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(defn load-data [path]
  (-> path
      slurp
      (json/read-str)))

(defn hit [m k]
  (update-in m [k "count"] inc))

(defn hit! [state k]
  (-> state
      (swap! hit k)
      (get k)
      json/write-str))

(def state (atom {:file1 (load-data "file1")
                  :file2 (load-data "file2")}))

(defroutes app-routes
  (GET "/" [] "Hello World")
  (GET "/file1" [] (hit! state :file1))
  (GET "/file2" [] (hit! state :file2))
  (route/not-found "Not Found"))

(def app
  (wrap-defaults app-routes site-defaults))
