## App Prototype Generator - uses AI to generate working code mockups of any application you want [Generate App with GPT3 Codex]

GPT3 Generate App generates a working app for you based on your specifications defined in a simple `config.yml`.

Let's generate a sample weather application:

config.yml:
```rb
  app_prototypes:
    weather_proto_1: weather application with one api endpoint that uses openmeteo dot com
```


This project uses OpenAI GPT3 Codex API to generate the various parts of the applications such as main application file, model files, controller / routes, haml layout and view templates and css  

### rake

generates an app
