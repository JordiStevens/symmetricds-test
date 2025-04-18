package org.example.mainapp.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity(name = "Test_table")
@Data
public class TestEntity {

    @Id
    private Integer id;

    private Integer data1;

    private Integer data2;

    private Integer data3;
}
