require 'sqlite3'
require 'singleton'

module Saveable
  def save
    table_name = self.class.to_s.downcase + "s"
    table_name.gsub!('ys', 'ies')
    if self.instance_variable_get(:@id).nil?
      save_new(table_name)
    else
      update(table_name)
    end
  end

  def save_new(table_name)
    columns = self.instance_variables[1..-1]
    column_string = columns.join(', ').gsub(/[\:\@]/, '')
    data = columns.map do |iv|
      self.instance_variable_get(iv)
    end.to_s.gsub(/\"/, "'").gsub(/[\[\]]/,'')
    $qd.execute(<<-SQL)
    INSERT INTO
      #{table_name} (#{column_string})
    VALUES
      (#{data})
    SQL
    self.id = $qd.last_insert_row_id
  end

  def update(table_name)
    id = self.instance_variable_get(:@id)
    columns = self.instance_variables[1..-1]
    set_values = columns.map do |iv|
      value = self.instance_variable_get(iv)
      value = "'" + value + "'" if value.is_a? String
      iv.to_s.gsub(/[\:\@]/, '') + "=" + value.to_s
    end.join(", ")
    $qd.execute(<<-SQL)
    UPDATE
      #{table_name}
    SET
      #{set_values}
    WHERE
      id = #{id}
    SQL
  end
end

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

$qd = QuestionsDatabase.instance

class User
  attr_accessor :id, :fname, :lname

  include Saveable

  def initialize(user_data)
    @id = user_data['id']
    @fname = user_data['fname']
    @lname = user_data['lname']
  end

  def self.find_by_id(id)
    user_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL
    User.new(user_data[0])
  end

  def self.find_by_name(fname, lname)
    user_data = $qd.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      users.fname = ? AND users.lname = ?
    SQL
    User.new(user_data[0])
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_author_id(id)
  end

  def followed_questions
    QuestionFollow.find_by_follower_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    data = $qd.execute(<<-SQL, uid: id)
    SELECT
      AVG(ql.likes) AS a
    FROM
      question_likes
    JOIN
      (
        SELECT
          COUNT(*) AS likes
        FROM
          question_likes
        JOIN
          questions ON questions.id = question_likes.question_id
        GROUP BY
          question_id
        HAVING
          questions.author_id = :uid
      ) AS ql
    SQL
    data[0]['a']
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  include Saveable

  def initialize(question_data)
    @id = question_data['id']
    @author_id = question_data['author_id']
    @title = question_data['title']
    @body = question_data['body']
  end

  def self.find_by_id(id)
    question_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL
    Question.new(question_data[0])
  end

  def self.find_by_author_id(author_id)
    question_data = $qd.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.author_id = ?
    SQL
    question_data.map do |qd|
      Question.new(qd)
    end
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end
end

class QuestionFollow
  attr_accessor :id, :follower_id, :question_id

  include Saveable

  def initialize(question_follows_data)
    @id = question_follows_data['id']
    @follower_id = question_follows_data['follower_id']
    @question_id = question_follows_data['question_id']
  end

  def self.find_by_id(id)
    question_follows_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      question_follows.id = ?
    SQL
    QuestionFollow.new(question_follows_data[0])
  end

  def self.find_by_follower_id(user_id)
    question_data = $qd.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      questions
    JOIN
      question_follows ON questions.id = question_follows.question_id
    WHERE
      question_follows.follower_id = ?
    SQL
    question_data.map do |ud|
      Question.new(ud)
    end
  end

  def self.followers_for_question_id(question_id)
    user_data = $qd.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users
    JOIN
      question_follows ON users.id = question_follows.follower_id
    WHERE
      question_follows.question_id = ?
    SQL
    user_data.map do |ud|
      User.new(ud)
    end
  end

  def self.most_followed_questions(n)
    data = $qd.execute(<<-SQL, n)
    SELECT DISTINCT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      questions
    JOIN
      (
        SELECT
          question_id, COUNT(*) as num_follows
        FROM
          question_follows
        GROUP BY
          question_id
      ) AS qf_sum
    ORDER BY
      qf_sum.num_follows DESC
    LIMIT
      ?
    SQL
    data.map { |d| Question.new(d) }
  end
end

class Reply
  attr_accessor :id, :question_id, :body, :author_id, :parent_id

  include Saveable

  def initialize(reply_data)
    @id = reply_data['id']
    @author_id = reply_data['author_id']
    @question_id = reply_data['question_id']
    @body = reply_data['body']
    @parent_id = reply_data['parent_id']
  end

  def self.find_by_id(id)
    reply_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = ?
    SQL
    Reply.new(reply_data[0])
  end

  def self.find_by_author_id(id)
    reply_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.author_id = ?
    SQL
    reply_data.map do |rd|
      Reply.new(rd)
    end
  end

  def self.find_by_question_id(id)
    reply_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.question_id = ?
    SQL
    reply_data.map do |rd|
      Reply.new(rd)
    end
  end

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    reply_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.parent_id = ?
    SQL
    reply_data.map do |rd|
      Reply.new(rd)
    end
  end
end

class QuestionLike
  attr_accessor :id, :liker_id, :question_id

  include Saveable

  def initialize(question_likes_data)
    @id = question_likes_data['id']
    @liker_id = question_likes_data['liker_id']
    @question_id = question_likes_data['question_id']
  end

  def self.find_by_id(id)
    question_likes_data = $qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      question_likes.id = ?
    SQL
    QuestionLike.new(question_likes_data[0])
  end

  def self.likers_by_question_id(id)
    data = $qd.execute(<<-SQL, id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL
    data.map do |rd|
      User.new(rd)
    end
  end

  def self.num_likes_for_question_id(id)
    data = $qd.execute(<<-SQL, :qid => id)
    SELECT
      COUNT(*) AS c
    FROM
      question_likes
    WHERE
      question_id = :qid
    SQL
    data[0]['c']
  end

  def self.liked_questions_for_user_id(id)
    data = $qd.execute(<<-SQL, :uid => id)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
      question_likes.user_id = :uid
    SQL
    data.map do |rd|
      Question.new(rd)
    end
  end

  def self.most_liked_questions(n)
    data = $qd.execute(<<-SQL, :num => n)
    SELECT DISTINCT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      questions
    JOIN
      (
        SELECT
          question_id, COUNT(*) as num_likes
        FROM
          question_likes
        GROUP BY
          question_id
      ) AS ql_sum
    ORDER BY
      ql_sum.num_likes DESC
    LIMIT
      :num
    SQL
    data.map { |d| Question.new(d) }
  end
end
