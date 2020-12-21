require 'roo'

namespace :import do
  desc "Import data from spreadsheet" # update this line
  task data: :environment do
    puts 'Importing Data' # add this line

    data = Roo::Spreadsheet.open

  end
end