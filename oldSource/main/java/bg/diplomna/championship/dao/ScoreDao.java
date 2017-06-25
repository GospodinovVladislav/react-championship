package bg.diplomna.championship.dao;

public interface ScoreDao {

	void saveOrUpdate(Score score);

	Score load(Long id);
	
	void deleteScore(Long id);
	
}
