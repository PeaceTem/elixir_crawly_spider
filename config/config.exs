# General application configuration
import Config

# config :crawly,
#     middlewares: [
#         {Crawly.Middlewares.UserAgent, user_agents: [
#             "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
#         ]},
#         {Crawly.Pipelines.WriteToFile, folder: "/tmp", extension: "jl"}
#     ]


config :crawly,
   closespider_timeout: 10,
   concurrent_requests_per_domain: 8,
   closespider_itemcount: 100,
   middlewares: [
     Crawly.Middlewares.DomainFilter,
     Crawly.Middlewares.UniqueRequest,
     {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot"]}
   ],
   pipelines: [
     {Crawly.Pipelines.Validate, fields: [:url, :title, :price]},
     {Crawly.Pipelines.DuplicatesFilter, item_id: :title},
     Crawly.Pipelines.JSONEncoder,
     {Crawly.Pipelines.WriteToFile, extension: "jl", folder: "/Users/USER/Desktop/school/elixir_tutorial/price_spider"}
   ]
