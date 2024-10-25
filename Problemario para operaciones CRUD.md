# Problemario para operaciones CRUD

## CREACION DE LA BASE DE DATOS

```sql
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email LIKE '%_@_%._%'),
    telefono VARCHAR(15) CHECK (LENGTH(telefono) >= 10),
    direccion VARCHAR(255) NOT NULL
);
```

## Ejercicios CREATE

1. Inserta un cliente válido en la tabla.
   
   ```sql
   INSERT INTO clientes (nombre, email, telefono, direccion)
   VALUES ('Juan Pérez', 'juan.perez@gmail.com', '5551234567', 'Calle Falsa 123');
   ```

2. Inserta un cliente sin especificar el campo `id_cliente`.
   
   ```sql
   INSERT INTO clientes (nombre, email, telefono, direccion)
   VALUES ('Ana García', 'ana.garcia@gmail.com', '5559876543', 'Av. Siempre Viva 742');
   ```

3. Intenta insertar un cliente con un formato de correo incorrecto (debería fallar).
   
   ```sql
   INSERT INTO clientes (nombre, email, telefono, direccion)
   VALUES ('Pedro Martínez', 'pedro.martinez@malformato', '5551234567', 'Calle Falsa 456');
   ```

4. Inserta múltiples clientes en una sola consulta.sql
   
   ```sql
   INSERT INTO clientes (nombre, email, telefono, direccion)
   VALUES
   ('Luis López', 'luis.lopez@example.com', '5558765432', 'Calle Verde 88'),
   ('Maria Fernanda', 'maria.fernanda@example.com', '5552345678', 'Av. Central 456');
   ```

5. Inserta un cliente con un número de teléfono de menos de 10 caracteres (debería fallar).
   
   ```sql
   INSERT INTO clientes (nombre, email, telefono, direccion)
   VALUES ('Carlos Méndez', 'carlos.mendez@example.com', '55512345', 'Calle Azul 789');
   ```

## Ejercicios READ

1. Consulta todos los registros de la tabla `clientes`.
   
   ```sql
   SELECT * FROM clientes;
   ```

2. Consulta el `nombre` y `email` de todos los clientes.
   
   ```sql
   SELECT nombre, email FROM clientes;
   ```

3. Consulta los clientes cuyo número de teléfono empiece con "555".
   
   ```sql
   SELECT * FROM clientes WHERE telefono LIKE '555%';
   ```

4. Consulta los clientes cuyo nombre contenga "López".
   
   ```sql
   SELECT * FROM clientes WHERE nombre LIKE '%López%';
   ```

5. Consulta los clientes ordenados por `nombre` en orden ascendente.
   
   ```sql
   SELECT * FROM clientes ORDER BY nombre ASC;
   ```

6. Consulta el `email` de los clientes cuyo id sea par.
   
   ```sql
   SELECT email FROM clientes WHERE MOD(id_cliente, 2) = 0;
   ```

7. Consulta los clientes con direcciones que contengan más de 10 caracteres.
   
   ```sql
   SELECT * FROM clientes WHERE LENGTH(direccion) > 10;
   ```

## Ejercicios UPDATE

1. Actualiza el número de teléfono de un cliente específico.
   
   ```sql
   UPDATE clientes SET telefono = '5557654321' WHERE id_cliente = 1;
   ```

2. Cambia el `email` de un cliente con un `id_cliente` específico.
   
   ```sql
   UPDATE clientes SET email = 'nuevo.email@example.com' WHERE id_cliente = 2;
   ```

3. Intenta actualizar el correo de un cliente a un email que ya existe (debería fallar).
   
   ```sql
   UPDATE clientes SET email = 'juan.perez@example.com' WHERE id_cliente = 3;
   ```

4. Actualiza la dirección de todos los clientes cuyos nombres contengan "López".
   
   ```sql
   UPDATE clientes SET direccion = 'Nueva Dirección 123' WHERE nombre LIKE '%López%';
   ```

5. Incrementa los `id_cliente` de todos los clientes en 10 (esto es solo un ejercicio teórico).
   
   ```sql
   UPDATE clientes SET id_cliente = id_cliente + 10;
   ```

## Ejercicios DELETE

1. Elimina un cliente específico con un `id_cliente` dado.
   
   ```sql
   DELETE FROM clientes WHERE id_cliente = 1;
   ```

2. Elimina todos los clientes que tengan un número de teléfono que empiece con "555".
   
   ```sql
   DELETE FROM clientes WHERE telefono LIKE '555%';
   ```

3. Elimina todos los clientes cuyo nombre contenga "Gómez".
   
   ```sql
   DELETE FROM clientes WHERE nombre LIKE '%Gómez%';
   ```

4. Elimina todos los clientes con direcciones que contengan menos de 10 caracteres.
   
   ```sql
   DELETE FROM clientes WHERE LENGTH(direccion) < 10;
   ```

5. Elimina todos los registros de la tabla `clientes` (¡CUIDADO!).
   
   ```sql
   DELETE FROM clientes;
   ```
