require 'csv'

module Dummy
  class << self
    def import_dummy_users_csv
      CSV.foreach('db/seeds/dummy_users_data.csv', headers: true) do |row|
        user = User.new(
          email: row['email'],
          name: row['name'],
          password: 'password',
          gender: convert_gender(row['gender']),
          age: row['age'],
          employment_type: convert_employment_type(row['employment_type']),
          prefecture: row['prefecture'],
          available_work_time: row['available_work_time'],
          qualification: row['qualification'],
          hobby: row['hobby'],
          special_skill: row['special_skill'],
          want_talk: row['want_talk'],
          not_want_talk: row['not_want_talk'],
          free_area: row['free_area'],
          facebook_url: row['facebook_url'],
          insta_url: row['insta_url'],
          twitter_url: row['twitter_url'],
          github_url: row['github_url'],
          port_url: row['port_url'],
          zasetsu_count: 0
        )
        add_skills_to(user, row)
        user.save
      end

      puts 'Import was successful.'
    end

    def convert_gender(resource)
      case resource
      when '未回答'
        :not_known
      when '男性'
        :male
      when '女性'
        :female
      when 'その他'
        :other
      end
    end

    def convert_employment_type(resource)
      case resource
      when '正社員'
        :full_time
      when '正社員(異業種)'
        :diff_full_time
      when '副業'
        :side_biz
      when 'フリーランス'
        :freelance
      when 'インターン'
        :internship
      when '求職中'
        :job_seeker
      end
    end

    def add_skills_to(user, resource)
      unless resource['Web開発'].nil?
        web_kaihatsu = SkillCategory.find_by(name: 'Web開発')
        user.skill_categories << SkillCategory.find_by(name: 'Web開発')
        resource['Web開発'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: web_kaihatsu)
          user.skill_sets << skill_set
        end
      end
      unless resource['Web制作'].nil?
        web_seisaku = SkillCategory.find_by(name: 'Web制作')
        user.skill_categories << SkillCategory.find_by(name: 'Web制作')
        resource['Web制作'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: web_seisaku)
          user.skill_sets << skill_set
        end
      end
      unless resource['デザイン'].nil?
        web_design = SkillCategory.find_by(name: 'デザイン')
        user.skill_categories << SkillCategory.find_by(name: 'デザイン')
        resource['デザイン'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: web_design)
          user.skill_sets << skill_set
        end
      end
      unless resource['動画編集'].nil?
        video_edit = SkillCategory.find_by(name: '動画編集')
        user.skill_categories << SkillCategory.find_by(name: '動画編集')
        resource['動画編集'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: video_edit)
          user.skill_sets << skill_set
        end
      end
      unless resource['ライティング'].nil?
        writing = SkillCategory.find_by(name: 'ライティング')
        user.skill_categories << SkillCategory.find_by(name: 'ライティング')
        resource['ライティング'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: writing)
          user.skill_sets << skill_set
        end
      end
      unless resource['マーケティング'].nil?
        marketing = SkillCategory.find_by(name: 'マーケティング')
        user.skill_categories << SkillCategory.find_by(name: 'マーケティング')
        resource['マーケティング'].split(", ").each do |skill_name|
          skill_set = SkillSet.find_by(name: skill_name, skill_category: marketing)
          user.skill_sets << skill_set
        end
      end
    end
  end
end

Dummy.import_dummy_users_csv

