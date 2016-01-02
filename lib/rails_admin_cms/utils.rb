module CMS
  extend self

  def rb_all_names(dirname)
    Dir["#{RailsAdminCMS::Engine.root}/#{dirname}/*.rb"].map do |name|
      File.basename(name).sub(/\.rb$/, '')
    end
    + rb_names(dirname)
  end

  def rb_names(dirname)
    Dir["#{Rails.root}/#{dirname}/*.rb"].map do |name|
      File.basename(name).sub(/\.rb$/, '')
    end
  end

  def html_names(dirname)
    Dir["#{Rails.root}/#{dirname}/*.html.*"].map do |name|
      File.basename(name).sub(/\.html\..+$/, '').sub(/^_/, '')
    end
  end

  def dir_names(dirname)
    Dir["#{Rails.root}/#{dirname}/*"].select{ |name|
      File.directory? name
    }.map{ |name|
      name.split('/').last
    }
  end
end
