package com.example.nov14;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController 
@CrossOrigin(origins = "*")
public class MyController 
{
    @Autowired 
    EmployeeRepo repo;

    @PostMapping("/add")
    public ResponseEntity add(@RequestBody Employee employee)
    {
        try
        {
            repo.save(employee);
            return ResponseEntity.status(200).body("Employee Added!");
        }
        catch(Exception e)
        {
            return ResponseEntity.status(500).body(e.getMessage());
        }
    }

    @RequestMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable("id")int id)
    {
        try
        {
            repo.deleteById(id);
            return ResponseEntity.status(200).body("Employee Removed!");
        }
        catch(Exception e)
        {
            return ResponseEntity.status(500).body(e.getMessage());
        }
    }

    @GetMapping("/getById/{id}")
    public Employee getbyid(@PathVariable("id")int id)
    {
        return repo.findById(id).orElse(null);
    }

    @GetMapping("/employees")
    public List<Employee> getEmployee()
    {
        return repo.findAll();
    }
}
