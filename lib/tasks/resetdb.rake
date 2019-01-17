 desc "Drops the database, creates the new database, migrates the database and seeds from the seed file"
 task :resetdb do 
 Rake::Task["db:drop"].invoke
 Rake::Task["db:create"].invoke
 Rake::Task["db:migrate"].invoke
 Rake::Task["db:seed"].invoke
end