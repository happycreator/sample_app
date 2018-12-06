class AttendancesController < ApplicationController
  def index
    @attendances = current_user.attendances
    
    #出社登録モーダルで使う変数
    @arriving_attendance = Attendance.new
    
    #退社登録モーダルで使う変数
    @leaving_attendance = Attendance.new
  end
  
  def show
    @attendance = Attendance.find(params[:id])
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
  
  def edit
  end
 
  def update
    # 渡ってきたデータをDateTimeオブジェクト型に変更する
    leaving_datetime = DateTime.parse(params[:leaving_at].split('=>')[1].chop)
    # params で渡ってきたデータで検索する
    # :id の 1 はダミーなので使わないこと
    if current_user.attendances.where(arriving_at: leaving_datetime.beginning_of_day...leaving_datetime.end_of_day).present?
      attendance = current_user.attendances.where(arriving_at: leaving_datetime.beginning_of_day...leaving_datetime.end_of_day).first
     
      if attendance.update(leaving_at: leaving_datetime)
        flash[:success] = "退社時刻を更新しました"
        redirect_to attendances_path
      else
        flash[:danger] = "出社時刻の登録に失敗しました"
        redirect_to attendances_path
      end
    else
      # 出社時刻が存在しないとき
      flash[:danger] = "まだ出社時刻が登録されていません"
      redirect_to attendances_path
    end
  end
  
  def destroy
    attendance = Attendance.find(params[:id]) 
    attendance.destroy
    flash[:success] = "データを削除しました"
    redirect_to attendances_path
  end
  
  # 一括編集画面
  def month_edit
    @attendance_collection = Form::AttendanceCollection.new
  end
  
  # 一括編集処理
  def month_update
    # 一ヶ月分のパラメータを受け取って更新
    @form = Form::AttendanceCollection.new(attendance_collection_params, current_user)
    if @form.attendances.present? && @form.save
      redirect_to :attendances, notice: "勤怠を登録しました。"
    else
      redirect_to month_edit_attendances_path, notice: "勤怠の登録に失敗しました。"
    end
  end
  
  private
  
  def attendance_collection_params
    params
      .require(:form_attendance_collection)
      .permit(attendances_attributes: Form::Attendance::REGISTRABLE_ATTRIBUTES)
  end

  def attendance_params
    # 許可するパラメータのリスト
    params.require(:attendance).permit(:arriving_at, :leaving_at, :note)
  end
end