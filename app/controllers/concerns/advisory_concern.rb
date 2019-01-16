module AdvisoryConcern
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

  def check_heading(ud_id)
    return 'time_date' if [3, 5].include?(ud_id)
    'primary_reason'
  end

  def check_remarks_ids(ud_id)
    return [15] if ud_id == 3
    return [1,2,3,4] if ud_id == 6
    return [2,3,5,6,7,8,9,10,11,12,13,14] if ud_id == 7
    return [16,17] if ud_id == 2
    return [18..29] if ud_id == 9
    return [30] if ud_id == 5
    return [26,27,30,31,32,33] if ud_id == 8
  end

  def check_reason_ids(ud_id)
    return [1,2,3,4,5] if [6,7].include?(ud_id)
    return [1,2,3,4] if [2].include?(ud_id)
    return [1,2,4,5] if [4,9].include?(ud_id)
    return [1..6] if [8].include?(ud_id)
  end
end
