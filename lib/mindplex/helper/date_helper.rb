
module Helper
  class DateHelper

    DATE_FORMAT = '%Y-%m-%d' 

    def self.year
      Date.today.year.to_s
    end

    def self.month
      padding Date.today.month.to_s
    end

    def self.day
      padding Date.today.day.to_s
    end

    def self.date
      Date.strptime(Date.today.to_s, DATE_FORMAT).to_s
    end
    
    def self.range(start_date, end_date)
      Date.parse(start_date)..Date.parse(end_date)
    end
    
    private

    def self.padding(element)
      if element.length == 1
        element = '0' + element
      end
      element
    end
  end
end

