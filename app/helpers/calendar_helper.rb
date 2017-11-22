module CalendarHelper
  class Calendar
    def self.create(year, month)
      calendar_array = []

      date = Date.new(year, month)
      daysInWeek = 7
      startDay = date.wday # 6
      daysInMonth = date.next_month.prev_day.day # 31
      numRows = (startDay+daysInMonth - 1)/daysInWeek

      if ((startDay+daysInMonth) % daysInWeek != 0)
          numRows += 1
      end

      for i in 0...numRows # loop through weeks
        calendar_array[i] = []
        for j in 0...daysInWeek # will loop 7 times for 7 days
          if j == date.wday
            calendar_array[i] << {date: date, id: 1}
            date += 1
          else
            # fill from previous month
            calendar_array[i] << {date: (date - (date.wday - j)), id: 1}
          end
        end
      end

      calendar_array
    end
  end

  def calendar(year, month)
    html = '<calendar>'
    html << "<h5>#{Date.new(year, month).strftime("%B")}</h5>"
    html << %(<week-headers>
      <day-header>S</day-header>
      <day-header>M</day-header>
      <day-header>T</day-header>
      <day-header>W</day-header>
      <day-header>Th</day-header>
      <day-header>F</day-header>
      <day-header>S</day-header>
    </week-headers>
    )
    cal_arr = Calendar.create(year, month)
    cal_arr.each do |week|
      html << '<week>'
      week.each do |day|
        extra_class = ''
        if day[:date].to_date.month < month
          extra_class = 'prev-month'
        elsif day[:date].to_date.month > month
          extra_class = 'next-month'
        end
        html << %(<day class="#{extra_class}" data-entry-id="#{day[:entry_id]}">#{day[:date].day}</day>)
      end
      html << '</week>'
    end
    html << '</calendar>'
    html.html_safe
  end
end