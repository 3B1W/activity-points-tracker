package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Student;
import com.example.activitypointstracker.exception.ResourceNotFoundException;
import com.example.activitypointstracker.mapper.StudentMapper;
import com.example.activitypointstracker.repository.StudentRepository;
import com.example.activitypointstracker.service.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class StudentServiceImpl implements StudentService {

    private StudentRepository studentRepository;

    @Override
    public StudentDto createStudent(StudentDto studentdto) {
        Student student = StudentMapper.mapToStudent(studentdto);
        Student savedStud = studentRepository.save(student);
        return StudentMapper.mapToStudentDto(savedStud);
    }

    @Override
    public StudentDto getStudentById(Long regid) {
        Student student = studentRepository.findById(regid)
                .orElseThrow(()-> new ResourceNotFoundException("Student with Id not found"));

        return StudentMapper.mapToStudentDto(student);
    }

    @Override
    public List<StudentDto> getAllStudents() {
        List<Student> students = studentRepository.findAll();
        return students.stream().map((student) -> StudentMapper.mapToStudentDto(student))
                .collect(Collectors.toList());
    }

    @Override
    public StudentDto updateStudent(Long regId, StudentDto updatedDet) {
        Student student = studentRepository.findById(regId).orElseThrow(
                () -> new ResourceNotFoundException("Student with Id not found:"+regId)
        );

        student.setFirstName(updatedDet.getFirstName());
        student.setLastName(updatedDet.getLastName());
        student.setEmail(updatedDet.getEmail());
        student.setYear(updatedDet.getYear());
        student.setRollNo(updatedDet.getRollNo());
        student.setActpts(updatedDet.getActpts());

        Student updatedStud = studentRepository.save(student);
        return StudentMapper.mapToStudentDto(updatedStud);
    }

    @Override
    public void deleteStudent(Long regId) {
        Student student = studentRepository.findById(regId).orElseThrow(
                () -> new ResourceNotFoundException("Student with Id not found:"+regId)
        );
        studentRepository.deleteById(regId);
    }
}
