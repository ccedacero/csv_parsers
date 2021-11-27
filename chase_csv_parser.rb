# frozen_string_literal: true

require 'csv'

csv_headers = nil
category_totals = {}
dirname = File.basename(Dir.getwd)

puts "*** Combining csv files on folder #{dirname} ***"

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

    # Payments on chase csv exports currenyly don't have a category value
    row['Category'] = 'Payment' if row['Category'].nil? && row['Type'] == 'Payment'

    if category_totals[row['Category']]
      category_totals[row['Category']] += row['Amount'].to_f.round(2)
    else
      category_totals[row['Category']] =
        row['Amount'].to_f.round(2)
    end

    mapped_row = row.headers.map { |col| row[col] }
    combined_csv_file << mapped_row
  end
end

results_arr_row_filler = [*1..csv_headers.length - 1].map { |_v| '' }
result_headers = results_arr_row_filler + ['Category', 'Total', 'Total Expenses', 'Total Payments']
combined_csv_file << result_headers
total = 0
last_key = category_totals.keys.last

category_totals.each do |key, value|
  total += value unless value.positive?
  combined_csv_file << results_arr_row_filler + [key, value.round(2)]
  if last_key == key
    combined_csv_file << results_arr_row_filler + ['', '', total.round(2),
                                                   category_totals['Payment'].round(2)]
  end
end

combined_csv_file.close

puts "*** Done combining and adding csv files on #{dirname} ***"
