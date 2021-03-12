class Language < ApplicationRecord
  self.table_name = 'countrylanguage'
  belongs_to :country, foreign_key: 'countrycode'
end
