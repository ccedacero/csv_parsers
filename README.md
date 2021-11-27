# This is where I'll be housing useful csv parses I use on my daily life. 

## chase_csv_parser
 A csv parser that takes a group of chase credit card csv files you've exported from your account and merges them into one csv while also calculating your total expenses by category, overall expenses, and total payments made accross the csvs. I use this to help me calculate my total credit card expenses per month.
 
 How to use:
- Make sure you have ruby installed on your computer. If you're on mac, you already have ruby installed by default. 
- Download this file `https://github.com/ccedacero/csv_parsers/blob/main/chase_csv_parser.rb`
- Copy the script to the directory where your csv files are
- Open your terminal and navigate to the directory where you have the csv files you'd like to combine
- Run the script with `ruby chase_csv_parser.rb'`
- Upon completion, you will now have a file named `combined_files.csv` on your desktop that you can inspect

