class AttendancesController < ApplicationController
  def index
    @attendances = Attendance.all
  end
  
  def new
    @attendance = Attendance.new
  end
  
  def create
    if current_user.attendances.where(arriving_at: Time.zone.today.beginning_of_day...Time.zone.today.end_of_day).present?
        # すでに同じ日付のデータが存在した時
        # もういちど :new をレンダリング
        flash[:danger] = "既にデータが登録されています"
        @attendance = current_user.attendances.build(attendance_params)
        render :new
    else
      # パラメータを受け取る
      @attendance = current_user.attendances.build(attendance_params)
    
      # 受け取ったデータをDBに保存
      # 保存に成功したとき、失敗したときの分岐
      if @attendance.save
        # 成功したとき
        flash[:success] = "登録しました"
        # 次に遷移するURLを生成
        redirect_to attendances_path
      else
        # 失敗したとき
        # もういちど :new をレンダリング
        flash[:danger] = "登録に失敗しました"
        render :new
      end
    end
  end
  
  private
  
  def attendance_params
    # 許可するパラメータのリスト
    params.require(:attendance).permit(:arriving_at, :leaving_at, :note)
  end
end
