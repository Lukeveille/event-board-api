class S3Controller < ApplicationController
  # GET /s3/direct_post
  def direct_post
    data = S3_BUCKET.presigned_post(
      key: "#{current_user.id}/#{SecureRandom.uuid.split('-')[0]}-${filename}",
      success_action_status: '201',
      acl: 'public-read'
    )
    render json: { url: data.url, fields: data.fields }, status: :ok
  end

  def destroy
    s3 = Aws::S3::Client.new.delete_object(
      bucket: ENV['S3_BUCKET'],
      key: "#{current_user.id}/#{params[:filename]}"
    )
    return true

    rescue => e
      Rails.logger.error "Error deleting #{image}. Failure with S3 call. Details: #{e}; #{e.backtrace}"
    return false
  end
end
