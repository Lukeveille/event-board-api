class S3Controller < ApplicationController
  # GET /s3/direct_post
  def direct_post
    data = S3_BUCKET.presigned_post(key: "#{current_user.id}/#{SecureRandom.uuid.split('-')[0]}-${filename}", success_action_status: '201', acl: 'public-read')
    render json: { url: data.url, fields: data.fields }, status: :ok
  end
end
