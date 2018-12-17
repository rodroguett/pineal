class ChartsController < ApplicationController

  def records_data
    filter = params[:filter]
    roles = if filter
      Record.where('rol IN (?)', params[:filter]).pluck(:rol).uniq
    else
      Record.pluck(:rol).uniq
    end
    vps = Record.pluck(:vp).uniq
    everything = []
    records = {}

    vps.each do |vp|
      records[vp] = Record.where(vp: vp).group(:rol).count
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