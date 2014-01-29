json.array!(@solutions) do |solution|
  json.extract! solution, :id, :name
  json.url admin_solution_url(solution, format: :json)
end
