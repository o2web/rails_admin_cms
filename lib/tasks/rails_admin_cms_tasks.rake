namespace :cms do
  desc "Adjust custom Forms max size in the Database"
  task :adjust_max_size => :environment do
    columns = ::Form::Row.columns.map(&:name).grep(/^column_\d+/)

    size_was = columns.size
    size = RailsAdminCMS::Config.custom_form_max_size

    if size < size_was
      (size_was - size).times.each.with_index(1) do |_, i|
        ActiveRecord::Base.connection.remove_column :form_rows, :"column_#{size_was - i}"
      end
    elsif size > size_was
      (size - size_was).times.each.with_index(size_was) do |_, i|
        ActiveRecord::Base.connection.add_column :form_rows, :"column_#{i}", :text
      end
    end
  end
end
