package com.homerenewer.userservice;

import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepository userRepo;
    private final PasswordEncoder passwordEncoder;

    public String saveUser(User user) {
        if (userRepo.findByEmail(user.getEmail()).isPresent()){
            throw new IllegalArgumentException("This email is already used");
        }
        String pwd = passwordEncoder.encode(user.getPassword());
        user.setPassword(pwd);
        user.setCreate_at(String.valueOf(LocalDate.now()));
        userRepo.save(user);
        return "User registered successfully";
    }
    public Optional<User> getUserById(Long id){
        return userRepo.findById(id);
    }
    public void deleteUserById(Long id) {
        userRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("This User not Found !"));
        userRepo.deleteById(id);
    }
    public User updateUsers(Long id, User user){
        Optional<User> optionalUser = userRepo.findById(id);
        if (optionalUser.isPresent()){
            User updateUser = optionalUser.get();
            updateUser.setUpdate_at(String.valueOf(LocalDate.now()));
            updateUser.setFirstname(user.getFirstname());
            updateUser.setLastname(user.getLastname());
            updateUser.setPassword(user.getPassword());
            updateUser.setUsername(user.getUsername());
            updateUser.setFirstname(user.getFirstname());
            return userRepo.save(updateUser);
        } else {
            throw new IllegalArgumentException("This User not registered !") ;
        }
    }
    public List<User> getAllUsers(){
        return userRepo.findAll();
    }
    public void deleteAllUsers(){
        userRepo.deleteAll();
    }

}
