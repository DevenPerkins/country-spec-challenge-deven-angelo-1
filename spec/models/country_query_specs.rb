require 'rails_helper'

RSpec.describe Country, type: :model do
  describe "practice with Active Record using WHERE syntax" do
    it "can find records and attributes (class)" do
      # What is the population of the US?
      us = Country.where(code: 'USA').first
      # This test passes!
      expect(us.population).to eq(278357000)
    end

    it "can find records and attributes" do
      # What is the area of the US?
      expect(us.surfacearea).to eq(9363520.0)
    end

    it "can find records and attributes" do
      # What is the population of Canada?
      canada = Country.where(code: 'CAN').first
      # This test passes!
      expect(canada.population).to eq(31147000)
    end

    it "can find records and attributes" do
      # What is the area of Canada?
      expect(canada.surfacearea).to eq(9970610.0)
    end

    it "can find records via equality comparison (class)" do
      # How many countries in Europe have a surface area greater than 200,000sqkm?
      area = 200_000
      countries = Country
        .where(continent: 'Europe')
        .where("surfacearea > ????")
      expect(countries.count).to eq(13)
    end

    it "can find records via equality comparison" do
      # How many countries in Europe have a life expectancy of more than 78?
      expect(countries.count).to eq(15)
    end

    it "can find records via equality comparison" do
      # How many countries in Europe have a life expectancy of less than 77?
      expect(countries.count).to eq(22)
    end

    it "can combine comparisons" do
      # How many countries in Europe have a life expectancy of less than 77 and surface area less than 50,000sqkm?
      expect(countries.count).to eq(7)
    end

    it "can find records via equality comparison" do
      # How many countries have a population larger than 30,000,000 and a life expectancy of more than 45?
      expect(countries.count).to eq(35)
    end

    it "can find records via multiple equality comparisons" do
      # How many countries in Africa have a population smaller than 30,000,000 and a life expectancy of more than 45?
      expect(countries.count).to eq(8)
   end

    it "can find records using wildcards" do
      # Which countries are something like a republic?
      expect(countries.count).to eq(143)
    end

    it "can have multiple selects" do
      # Which countries are some kind of republic and achieved independence after 1945?
      expect(countries.count).to eq(92)
    end
  end


  describe "practice with Active Record using ORDER syntax" do
    it "can use order (class)" do
      # Which country has the shortest (non-null) life expectancy?
      country = Country
        .where.not(lifeexpectancy: nil)
        .order(:lifeexpectancy)
        .limit(1)
        .first
      # This test passes!
      expect(country.code).to eq('ZMB')
    end

    it "can use order" do
      # Which country has the highest life expectancy?
      expect(country.code).to eq('FLK')
    end

    it "can use order" do
      # Which country is the smallest by surface area?
      expect(country.code).to eq('VAT')
    end

    it "can use order" do
      # Which country is the biggest by surface area?
      expect(country.code).to eq('RUS')
    end

    it "can use order" do
      # Which country is the smallest by population?
      expect(country.code).to eq('ATA')
    end

    it "can use order" do
      # Which country is the biggest by population?
      expect(country.code).to eq('CHN')
    end

    it "can combine order and limit (class)" do
      # Which 10 countries have the lowest life expectancy?
      # Hint: Use .pluck
      countries = Country
      .order(:lifeexpectancy)
      .limit(10)
      .pluck(:name)
      expected = ["Zambia", "Mozambique", "Malawi", "Zimbabwe", "Angola", "Botswana", "Rwanda", "Swaziland", "Niger", "Namibia"]
      # This test passes!
      expected.map do |country|
        expect(countries).to include(country)
      end
    end

    it "can combine order and limit" do
      # Which five countries have the lowest population density?
      country_names = countries.map{|c| c.name }
      expected = ["South Georgia and the South Sandwich Islands", "Bouvet Island", "Antarctica", "British Indian Ocean Territory", "Heard Island and McDonald Islands"]
      expected.map do |country|
        expect(country_names).to include(country)
      end
    end

    it "can combine order and limit" do
      # Which five countries have the highest population density?
      country_names = countries.map{|c| c.name }
      expected = ["Macao", "Monaco", "Hong Kong", "Singapore", "Gibraltar"]
      expected.map do |country|
        expect(country_names).to include(country)
      end
    end

    it "can combine order and limit" do
      # Which 10 countries are smallest by surface area?
      expected = ["Holy See (Vatican City State)", "Monaco", "Gibraltar", "Tokelau", "Cocos (Keeling) Islands", "United States Minor Outlying Islands", "Macao", "Nauru", "Tuvalu", "Norfolk Island"]
      expected.map do |country|
        expect(countries).to include(country)
      end
    end
  end


  describe "combining Active Record and Plain Old Ruby (POR) (class)" do
    it "can simplify 'with' queries" do
      # Of the 10 smallest countries by population, which has the biggest GNP?
      countries = Country
        .order(:population)
        .limit(10)
      smallest_biggest = countries.min{|a, b| b.gnp <=> a.gnp}
      # This test passes!
      expect(smallest_biggest.name).to eq("Holy See (Vatican City State)")
    end

    it "can simplify 'with' queries" do
      # Of the 10 largest countries by surface area, which has the smallest GNP?
      smallest_biggest = countries.min{|a,b| a.gnp <=> b.gnp}
      expect(smallest_biggest.name).to eq("Antarctica")
    end

    it "can simplify 'with' queries" do
      # Of the 10 biggest countries by population, which has the biggest GNP?
      expect(biggest_biggest.name).to eq("United States")
    end

    it "can simplify 'aggregate' operations (class)" do
      # What is the sum of the surface area of the 10 biggest countries in the world?
      expect(sum_total).to eq(84183616.0)
    end

    it "can simplify 'aggregate' operations" do
      # What is the sum of surface area of the 10 least populated countries in the world?
      expect(sum_total).to eq(13132258.4)
    end
  end
end
