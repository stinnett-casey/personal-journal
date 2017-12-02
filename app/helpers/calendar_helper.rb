module CalendarHelper
  class Calendar
    def self.create(year, month)
      calendar_array = []
      date = Date.new year, month

      daysInWeek = 7
      startDay = date.wday
      daysInMonth = date.end_of_month.day
      numRows = (startDay+daysInMonth - 1)/daysInWeek

      if ((startDay+daysInMonth) % daysInWeek != 0)
          numRows += 1
      end

      # an attempt to speed things up with a single DB call rather than one for each day
      # month_entries = Entry.where('extract(month from created_at) = ?', date.month) # for not sqlite
      month_entries = Entry.where("cast(strftime('%m', entry_date) as int) = ?", date.month) # for sqlite

      for i in 0...numRows # loop through weeks
        calendar_array[i] = []
        for j in 0...daysInWeek # will loop 7 times for 7 days
          if j == date.wday
            day_entries = month_entries.select { |entry| entry.entry_date.to_date.day == date.day && entry.entry_date.to_date.month == date.month }
            calendar_array[i] << {date: date, entry_ids: day_entries.map { |entry| entry.id }}
            date += 1
          else
            # fill from previous month
            prev_date = date - (date.wday - j)
            day_entries = Entry.on_date(prev_date)
            calendar_array[i] << {date: prev_date, entry_ids: day_entries.map { |entry| entry.id }}
          end
        end
      end
      p calendar_array
      calendar_array
    end
  end

  def calendar(date)
    html = '<calendar>'
    html << "<h5>#{date.strftime("%B")}</h5>"
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
    cal_arr = Calendar.create(date.year, date.month)
    cal_arr.each do |week|
      html << '<week>'
      week.each do |day|
        extra_class = ''
        if day[:date].month < date.month
          extra_class = 'prev-month'
        elsif day[:date].month > date.month
          extra_class = 'next-month'
        end
        html << %(<day class="#{extra_class} #{(!day[:entry_ids].blank? ? 'entry' : '')}"><a href="/entry?date=#{day[:date]}">#{day[:date].day}</a></day>)
      end
      html << '</week>'
    end
    html << '</calendar>'
    html.html_safe
  end
end