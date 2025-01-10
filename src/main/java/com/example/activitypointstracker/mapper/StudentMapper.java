package com.example.activitypointstracker.mapper;

import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Student;

public class StudentMapper {
    public static StudentDto mapToStudentDto(Student student){
        return new StudentDto(
                student.getId(),
                student.getTkmId(),
                student.getYear(),
                student.getFirstName(),
                student.getLastName(),
                student.getEmail(),
                student.getRollNo(),
                student.getActpts()

        );
    }

    public static Student mapToStudent(StudentDto studentdto){
        return new Student(
                studentdto.getId(),
                studentdto.getTkmId(),
                studentdto.getYear(),
                studentdto.getFirstName(),
                studentdto.getLastName(),
                studentdto.getEmail(),
                studentdto.getRollNo(),
                studentdto.getActpts()

        );
    }
}
