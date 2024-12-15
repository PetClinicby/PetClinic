# Documentation for Deploying Spring Petclinic Application

## Deploying the Application Without Containerization

1. **Install Maven and Java 17:**
    ```bash
    sudo apt update
    sudo apt install maven openjdk-17-jdk
    ```

2. **Verify Installation:**
    ```bash
    mvn -version
    java -version
    ```

3. **Build the Application:**
    ```bash
    git clone https://github.com/spring-projects/spring-petclinic.git
    cd spring-petclinic
    mvn package
    ```

4. **Run the Application:**
    ```bash
    java -jar target/*.jar
    ```

## Deploying the Application with Containerized Database and Application

1. **Install Docker:**
    ```bash
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker $USER
    ```

2. **Run PostgreSQL Container:**
    ```bash
    docker run --name petclinic-postgres -e POSTGRES_DB=petclinic -e POSTGRES_USER=petclinic -e POSTGRES_PASSWORD=petclinic -p 5432:5432 -d postgres
    ```

3. **Configure Application to Use PostgreSQL:**
    ```bash
    echo "" > src/main/resources/application-postgres.properties
    vim src/main/resources/application-postgres.properties
    ```

4. **Run the Application with PostgreSQL Profile:**
    ```bash
    mvn spring-boot:run -Dspring-boot.run.profiles=postgres
    ```

5. **Create Dockerfile for the Application:**
    ```bash
    vim dockerfile
    ```

6. **Build Docker Image for the Application:**
    ```bash
    docker build -t petclinic .
    ```

7. **Create Docker Compose File:**
    ```bash
    vim docker-compose-with-DB.yml
    ```

8. **Run the Application and Database Using Docker Compose:**
    ```bash
    docker compose -f docker-compose-with-DB.yml up -d
    ```

9. **Verify Running Containers:**
    ```bash
    docker ps
    ```