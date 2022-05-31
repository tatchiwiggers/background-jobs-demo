namespace :user do
  desc "Enriching all users with Clearbit (async)"
  task update_all: :environment do
    puts "Enqueuing update of users..."
    # aqui vamos colocar na fila um job pra cada user
    # aqui vamos realizar o update de todos os users ao rodar nosso rake task
    User.all.each do |user|
      UpdateUserJob.perform_later(user)
    end
  end
    
  # dessa forma que permitimos passar argumentos no terminal
  # podemos passar um ou mais argumentos:
  # task :update, [:user_id, :user_email] => :environment do |t, args|
  desc "Enriching a given user with Clearbit (sync)"
  task :update, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    puts "Enriching #{user.email}..."
    UpdateUserJob.perform_later(user)
  end
end

# rails user:update[999] 
# rails user:update[999, 'tatchi@lewagon.com']