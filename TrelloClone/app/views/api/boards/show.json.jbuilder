# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

# json.content format_content(@board.title)
json.(@board, :title, :created_at)

json.user do
  json.email @board.user.email
end

json.lists @board.lists, :title, :ord
