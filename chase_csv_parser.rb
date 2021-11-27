# frozen_string_literal: true

require 'csv'
require 'byebug'

csv_headers = nil
category_totals = {}

combined_csv_file = CSV.open('combined_files.csv',
                             'w+')

budget_csvs = Dir.glob('*.csv')

budget_csvs.each do |budget_file|
  current_csv = CSV.read(budget_file,
                         headers: true)
  if csv_headers.nil?
    csv_headers = current_csv.headers
    combined_csv_file << csv_headers
  end
  current_csv.each do |row|
    next if row == csv_headers

    if category_totals[row['Category']]
      category_totals[row['Category']] += row['Amount'].to_f.round(2)
    else
      category_totals[row['Category']] =
        row['Amount'].to_f.round(2)
    end
    combined_csv_file << [row['Transaction Date'],
                          row['Post Date'],
                          row['Description'],
                          row['Category'],
                          row['Type'],
                          row['Amount'],
                          row['Memo']]
  end
end

combined_csv_file << ['', '', '', '', '', 'Category', 'Total']

category_totals.each do |k, v|
  combined_csv_file << ['', '', '', '', '', k, v.round(2)]
end

combined_csv_file.close

puts 'Done combining csv files'
