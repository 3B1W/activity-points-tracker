package com.example.activitypointstracker.service;

import com.example.activitypointstracker.dto.StudentDto;

import java.util.List;

public interface StudentService {
    StudentDto createStudent(StudentDto studentdto);
    StudentDto getStudentById(Long regid);
    List<StudentDto> getAllStudents();
    StudentDto updateStudent(Long regId,StudentDto updatedDet);
    void deleteStudent(Long regNo);
}
