class FakeJob < ApplicationJob
  queue_as :default

  # não alterar o nome desse metodo
  # aqui criamos um job que não é um background job
  def perform
    puts "I'm starting the fake job"
    sleep 3
    puts "OK I'm done now"
  end
end

# rails c
# FakeJob.perform_now => vai executar na fila principal do servidor do rails 
# FakeJob.perform_later => vai utilizar ActiveJob para executar depois, com um 
# background job