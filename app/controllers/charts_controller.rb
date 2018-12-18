class ChartsController < ApplicationController

  def records_data
    filter = params[:filter]

    filtered_records = if filter
      Record.where('status IN (?)', filter)
    else
      Record.all
    end

    roles = filtered_records.pluck(:rol).uniq
    vps = filtered_records.pluck(:vp).uniq
    everything = []
    records = {}

    vps.each do |vp|
      records[vp] = filtered_records.where(vp: vp).group(:rol).count
    end

    roles.each do |rol|
      data = []
      vps.each do |vp|
        if records[vp][rol].present?
          data << [vp, records[vp][rol]]
        else
          data << [vp, 0]
        end
      end
      everything  << {name: rol, data: data, stack: rol}
    end
    render json: everything
  end
end