package com.example.activitypointstracker.mapper;

import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Student;

public class StudentMapper {

    // Maps Student entity to StudentDto
    public static StudentDto mapToStudentDto(Student student) {
        return new StudentDto(
                student.getTkmId(),
                student.getYear(),
                student.getFirstName(),
                student.getLastName(),
                student.getEmail(),
                student.getRollNo(),
                student.getActpts() // This will include the value for `actpts`, defaulting to 0 if null
        );
    }

    // Maps StudentDto to Student entity
    public static Student mapToStudent(StudentDto studentDto) {
        return Student.builder()
                .tkmId(studentDto.getTkmId())
                .year(studentDto.getYear())
                .firstName(studentDto.getFirstName())
                .lastName(studentDto.getLastName())
                .email(studentDto.getEmail())
                .rollNo(studentDto.getRollNo())
                .actpts(null) // Default to 0 as `actpts` is not provided from the frontend
                .build();
    }
    public static void updateStudentFromDto(StudentDto studentDto, Student student) {
        student.setTkmId(studentDto.getTkmId());
        student.setYear(studentDto.getYear());
        student.setFirstName(studentDto.getFirstName());
        student.setLastName(studentDto.getLastName());
        student.setEmail(studentDto.getEmail());
        student.setRollNo(studentDto.getRollNo());
        // Note: actpts should not be updated unless explicitly required.
    }

}
