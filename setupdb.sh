echo "Setting Up DB"
export PSQL="postgresql://localhost:26257/postgres"
cat <<EOF  > dbsetup.sql
CREATE DATABASE cg;
EOF
echo "Creating Database"
./cockroach.sh sql --insecure < dbsetup.sql
rm -f dbsetup.sql
export PSQL="postgresql://localhost:26257/postgres/cg"
cat <<EOF  > dbsetup.sql
CREATE TABLE cg.project(
   id             SERIAL  PRIMARY KEY     NOT NULL,
   name           TEXT NOT NULL,
   cloudid        TEXT NOT NULL,
   classid        TEXT NOT NULL
);
CREATE UNIQUE INDEX name_idx ON cg.project ( name );
CREATE UNIQUE INDEX cloudid_idx ON cg.project ( cloudid );
CREATE UNIQUE INDEX classid_idx ON cg.project ( classid );
CREATE TABLE cg.class_title(
   id             INT PRIMARY KEY     NOT NULL,
   name           TEXT NOT NULL,
   description    TEXT NOT NULL,
   max_usage	  INT NOT NULL
);
CREATE TABLE cg.class_recipes(
   id		  INT PRIMARY KEY    NOT NULL,
   class_title_id INT NOT NULL,
   recipe_id      INT NOT NULL
);
CREATE TABLE cg.class_instance(
   id		  INT PRIMARY KEY    NOT NULL,
   class_title_id INT NOT NULL,
   user_id        INT NOT NULL,
   name           TEXT NOT NULL,
   state          TEXT NOT NULL,
   project_name   TEXT NOT NULL,
   domain         TEXT,
   cost_center    TEXT,
   start_time     TIMESTAMP,
   end_time       TIMESTAMP
);
CREATE TABLE cg.class_machine(
   id		 	INT PRIMARY KEY NOT NULL,
   class_instance_id    INT,
   user_id		INT,
   host_name		TEXT,
   machine_type         TEXT,
   state		TEXT,
   ip			TEXT
);
CREATE TABLE cg.user(
   id			INT PRIMARY KEY NOT NULL,
   name			TEXT NOT NULL,
   email                TEXT NOT NULL,
   email_verified       BOOLEAN,
   ssh_public_key       TEXT NOT NULL,
   active		BOOLEAN,
   date_created         TIMESTAMP,
   date_modified        TIMESTAMP
);
CREATE TABLE cg.recipe(
   id		  INT PRIMARY KEY    NOT NULL,
   name           TEXT NOT NULL,
   description    TEXT NOT NULL,
   ansible_git    TEXT 
);
CREATE UNIQUE INDEX name_idx ON cg.recipe ( name );
CREATE TABLE cg.recipe_items(
   id		  INT PRIMARY KEY   NOT NULL,
   recipe_id      INT NOT NULL,
   name           TEXT NOT NULL,
   hostname       TEXT NOT NULL,
   cnt            INT,
   ansible_type   TEXT,
   machine_type   TEXT NOT NULL
);
CREATE TABLE cg.machine_types(
   id		  INT PRIMARY KEY  NOT NULL,
   name           TEXT NOT NULL,
   machine_type   TEXT NOT NULL
);
EOF
echo "Running PSQL"
./cockroach.sh sql --insecure < dbsetup.sql
rm -f dbsetup.sql
echo "Setup Complete"
