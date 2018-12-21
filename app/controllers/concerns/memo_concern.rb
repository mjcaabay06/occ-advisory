module MemoConcern
  def param_clean(_params)
    _params.delete_if do |k, v|
      if v.instance_of? ActionController::Parameters
        param_clean(v)
      end
      # if v.instance_of? ActionDispatch::Http::UploadedFile
      #   false
      # else
      #   v.empty?
      # end
    end
  end

  def clean_date(date)
    ds = date.split('/')
    "#{ds[2]}-#{ds[0]}-#{ds[1]}"
  end

  def clean_time(time)
    "#{time.to_time.strftime('%H:%M:%S')}"
  end
end
