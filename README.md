Development
------

Чтобы клиент работал независимо от сервера создаем `./config/application.local.yml`, где прописываем:

    url: 'http://localhost:9292/'              # Текущий адрес на котором запущен клиент
    faye_url: 'http://icrm.icfdev.ru:8809/fay' # Стейджевый faye-сервер, путь он работает
    api_url: 'http://localhost:9292/v1/'       # Загляшка для серверных запросов

Запуск
------

Запускаем клиента (по-умолчанию на порту 9292):

    > rackup

Backbone
--------

* https://docs.google.com/drawings/d/1J0PfEyMDuie3Qw6VtA4R4a7od5lwXHMO6kLj8V-72T4/edit

Design
------

* https://docs.google.com/drawings/d/1rqX9skp1lI35GMzq5DmHfTayfpZr0ldNAL64zU-B9mY/edit


Debugging
---------

Send test notify from the browser console:

   > ICRMSendTestNotify()

Post test message to chat:

   > ICRMSendServerMessage()
   

Links
-----

* http://friendlybit.com/js/lazy-loading-asyncronous-javascript/


Testing on activesite
---------------------

To run convead widget add `?convead_widget=true` to url parameters. For
examples: http://ipelican.com/?convead_widget=true
