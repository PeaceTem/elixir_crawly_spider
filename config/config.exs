# General application configuration
import Config


config :hound, driver: "chrome",
    driver_opts: [binary: "/Chrome/"]




config :crawly,
   closespider_timeout: 10,
   concurrent_requests_per_domain: 1,
   closespider_itemcount: 100,
   middlewares: [
     Crawly.Middlewares.DomainFilter,
     Crawly.Middlewares.UniqueRequest,
     {Crawly.Middlewares.UserAgent, user_agents: ["Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"]}
   ],
   pipelines: [
     {Crawly.Pipelines.Validate, fields: [:url, :title, :price]},
     {Crawly.Pipelines.DuplicatesFilter, item_id: :title},
     Crawly.Pipelines.JSONEncoder,
     {Crawly.Pipelines.WriteToFile, extension: "jl", folder: "/Users/USER/Desktop/school/elixir_tutorial/price_spider"}
   ]
