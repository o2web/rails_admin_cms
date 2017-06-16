namespace :redirector do
  desc "Add 301 redirects in database"
  task :import => :environment do
    require 'csv'
    require 'fileutils'

    FileUtils.mkdir_p 'db/redirects/imported'

    Dir.glob("db/redirects/*.csv") do |csv_file|
      csv_text = File.read(csv_file)
      csv = CSV.parse(csv_text, :headers => true)
      ActiveRecord::Base.transaction do
        csv.each do |row|
          Redirector::Rule.create!(:source => row[0].to_s,
                                   :destination => row[1].to_s,
                                   :source_is_regex => false,
                                   :source_is_case_sensitive => false,
                                   :active => true)
        end
      end
      filename = File.basename(csv_file)
      puts filename
      FileUtils.move(csv_file, "db/redirects/imported/#{filename}")
    end
  end
end