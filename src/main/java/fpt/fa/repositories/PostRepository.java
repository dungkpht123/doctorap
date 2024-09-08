package fpt.fa.repositories;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import fpt.fa.entity.Post;

@Repository
public interface PostRepository extends JpaRepository<Post, Integer> {
	 Post findByUrl(String url); 
	  Page<Post> findByStatus(int status, Pageable pageable);
}
