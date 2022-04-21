# == Schema Information
#
# Table name: job_mappings
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  job_id     :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_job_mappings_on_deleted_at  (deleted_at)
#  index_job_mappings_on_job_id      (job_id)
#  index_job_mappings_on_user_id     (user_id)
#
class JobMapping < ApplicationRecord

end
