package com.example.activitypointstracker.controller;

import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Student;
import com.example.activitypointstracker.service.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/api/student")
public class StudentController {

    private StudentService studentservice;

    //Build Add Student REST API
    @PostMapping
    public ResponseEntity<StudentDto> createStudent(@RequestBody StudentDto studentDto){
        StudentDto savedStud = studentservice.createStudent(studentDto);
        return new ResponseEntity<>(savedStud, HttpStatus.CREATED);
        //return ResponseEntity.ok("Student saved");
    }

    //Build Get Student REST API
    @GetMapping("{id}")
    public ResponseEntity<StudentDto> getEmployeebyRegId(@PathVariable("id") Long studid){
        StudentDto studentDto = studentservice.getStudentById(studid);
        return ResponseEntity.ok(studentDto);
    }

    //Build Get All Students REST API
    @GetMapping
    public ResponseEntity<List<StudentDto>> getAllEmployees(){
        List<StudentDto> students = studentservice.getAllStudents();
        return ResponseEntity.ok(students);
    }

    //Build Update Student REST API
    @PutMapping("/updateprofile/{id}")
    public ResponseEntity<StudentDto> updateStudent(@PathVariable("id") Long regID,
                                                    @RequestBody StudentDto updatednew){
        StudentDto updstud = studentservice.updateStudent(regID,updatednew);
        return ResponseEntity.ok(updstud);
    }

    //Build Delete Student REST API
    @DeleteMapping("delete/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable("id") Long regId){
        studentservice.deleteStudent(regId);
        return ResponseEntity.ok("Student Data Deleted successfully");
    }
}
