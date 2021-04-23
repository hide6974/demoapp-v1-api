require "validator/email_validator"

class User < ApplicationRecord

    # バリデーション直前
    before_validation :downcase_email

    # gem bcrypt
    has_secure_password
    validates :name, presence: true,
    length: { maximum: 30, allow_blank: true }
    # 追加
    validates :email, presence: true,
    email: { allow_blank: true }
    # 追加
    VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
    validates :password, presence: true,
                       length: { minimum: 8 },
                       format: {
                         with: VALID_PASSWORD_REGEX,
                         message: :invalid_password
                       },
                       allow_nil: true

    ## methods
    # class method  ###########################
    class << self
        # emailからアクティブなユーザーを返す
        def find_activated(email)
            find_by(email: email, activated: true)
        end
    end
    # class method end #########################
 
    # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
    def email_activated?
        users = User.where.not(id: id)
        users.find_activated(email).present?
    end
    
    # Userクラスの一番下に追加
    private

    # email小文字化
    def downcase_email
        self.email.downcase! if email
    end
end