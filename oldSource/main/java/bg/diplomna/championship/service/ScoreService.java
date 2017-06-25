package bg.diplomna.championship.service;

import bg.diplomna.championship.dao.Score;

public interface ScoreService {

	Score loadScore(Long id);

	void saveOrUpdateScore(Score participant);

	void deleteScore(Long id);
}
