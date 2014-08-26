class LearningSession
  state_machine :state, initial: :unstarted do
    event :start do
      transition unstarted: :started
    end

    event :choose_lesson do
      transition started: :choosing_lesson
    end

    event :record_questions do
      transition choosing_lesson: :recording_questions
    end

    event :record_notes do
      transition recording_questions: :recording_notes
    end

    event :mark_questions_as_answered do
      transition recording_notes: :marking_questions_as_answered
    end

    event :finish_session do
      transition marking_questions_as_answered: :finished
    end
  end
end
