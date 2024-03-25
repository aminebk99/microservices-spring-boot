package com.homerenewer.postservice;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@AllArgsConstructor
public class PostController {
    private final PostRepository postsRepository;
    @PostMapping("/posts")
    public List<Post> getAllPosts(){
        return postsRepository.findAll();
    }
    @PostMapping("/posts")
    public Post SavePosts(@RequestBody Post post){
        post.setCreate_at(LocalDate.now());
        return postsRepository.save(post);
    }
}
