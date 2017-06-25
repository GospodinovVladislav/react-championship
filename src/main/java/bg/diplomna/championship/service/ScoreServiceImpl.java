package bg.diplomna.championship.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bg.diplomna.championship.dao.Score;
import bg.diplomna.championship.dao.ScoreDao;


@Service
@Transactional
public class ScoreServiceImpl implements ScoreService{

	
	@Autowired
	private ScoreDao scoreDao;
	
	@Override
	public Score loadScore(Long id) {
		return scoreDao.load(id);
	}

	@Override
	public void saveOrUpdateScore(Score score) {
		scoreDao.saveOrUpdate(score);
	}

	@Override
	public void deleteScore(Long id) {
		scoreDao.deleteScore(id);
	}

}
