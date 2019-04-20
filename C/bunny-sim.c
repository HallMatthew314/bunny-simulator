#define NAMECOUNT 50
#define SEXCOUNT 2
#define COLOURCOUNT 4
#define CHANCE_RMVB 50
#define SEX_FEMALE 0
#define SEX_MALE 1

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct S_Bunny{
	int age;
	int rmvb;
	char* sex;
	char* name;
	char* colour;
	struct S_Bunny* previous;
	struct S_Bunny* next;
} Bunny;

const char* femaleNames[NAMECOUNT] = {
	"Artie",
	"Tobie",
	"Magdalene",
	"Renata",
	"Reina",
	"Celinda",
	"Tona",
	"Louise",
	"Kamala",
	"Aracely",
	"Shawanna",
	"Codi",
	"Anamaria",
	"Teresa",
	"Azalee",
	"Celsa",
	"Nickie",
	"Venice",
	"Kyla",
	"Alta",
	"Alexandra",
	"Georgeann",
	"Maybelle",
	"Natashia",
	"Irina",
	"Lenna",
	"Catarina",
	"Laticia",
	"Corina",
	"Tonita",
	"Racquel",
	"Merri",
	"Donna",
	"Salina",
	"Angelina",
	"Vanda",
	"Lucretia",
	"Katheleen",
	"Daina",
	"Kali",
	"Evette",
	"Bula",
	"Kathey",
	"Tamela",
	"Refugia",
	"Cheryll",
	"Fumiko",
	"Tawny",
	"Gretchen",
	"Monserrate"
};

const char* maleNames[NAMECOUNT] = {
	"Ty",
	"Kareem",
	"Wilfred",
	"Kerry",
	"Randal",
	"Arnold",
	"Jacob",
	"Miquel",
	"Keenan",
	"Carrol",
	"Max",
	"Benjamin",
	"Gustavo",
	"Sandy",
	"Cesar",
	"Rex",
	"Joaquin",
	"Nickolas",
	"Reuben",
	"Bernie",
	"Brice",
	"Humberto",
	"Ken",
	"Isaac",
	"Dana",
	"Erik",
	"Michael",
	"Fabian",
	"Darren",
	"Elmo",
	"Darrell",
	"Cleveland",
	"Jarred",
	"Donovan",
	"Xavier",
	"Emery",
	"Larry",
	"Sylvester",
	"Mark",
	"Orville",
	"Leif",
	"Wilburn",
	"Boyd",
	"Joseph",
	"Forrest",
	"Clayton",
	"Jimmy",
	"Dustin",
	"Sean",
	"Huey"
};

const char* sexes[SEXCOUNT] = {
	"Female",
	"Male"
};

const char* colours[COLOURCOUNT] = {
	"White",
	"Brown",
	"Black",
	"Spotted"
};

char inputBuffer[16];

void* emalloc(Bunny* startPtr, size_t s);
Bunny* newBunny(Bunny* startPtr);
Bunny* addToStart(Bunny* startPtr);
Bunny* addToEnd(Bunny* startPtr);
Bunny* deleteBunny(Bunny* startPtr, Bunny* deleteMe);
Bunny* sortList(Bunny* startPtr);
void makeBunniesGrowOlder(Bunny* startPtr);
int getListSize(Bunny* startPtr);
int countMatureFemales(Bunny* startPtr);
int calcMatureMalePresent(Bunny* startPtr);
void printList(Bunny* start);
void cleanUp(Bunny* start);

int main(){

	srand(time(NULL));
	Bunny* startOfList = NULL;
	int year = 1;

	while(getListSize(startOfList) > 0 || year == 1){
		if(year == 1){
			startOfList = addToStart(startOfList);
			startOfList = addToStart(startOfList);
			startOfList = addToStart(startOfList);
			startOfList = addToStart(startOfList);
			startOfList = addToStart(startOfList);
		}

		printf("Year %d\n\n", year);

		makeBunniesGrowOlder(startOfList);

		printList(startOfList);
		printf("Press enter to continue...");
		fgets(inputBuffer, 15, stdin);
		++year;
	}
	printf("After the loop\n");
	cleanUp(startOfList);
	return 0;
}

//courtesy of Dr. Nathan Rountree (University of Otago)
void* emalloc(Bunny* startPtr, size_t s){
	void* result = malloc(s);
	if(result == NULL){
		fprintf(stderr, "Memory allocation failed!\n");
		cleanUp(startPtr);
		exit(EXIT_FAILURE);
	}
	return result;
}

Bunny* newBunny(Bunny* startPtr){

	Bunny* b = emalloc(startPtr, sizeof(Bunny));

	b->age = 0;
	b->sex = sexes[rand() % SEXCOUNT];
	b->name = (b->sex == sexes[0]) ? femaleNames[rand() % NAMECOUNT] : maleNames[rand() % NAMECOUNT];
	b->colour = colours[rand() % COLOURCOUNT];
	b->rmvb = (rand() % CHANCE_RMVB == 0) ? 1 : 0;

	b->next = NULL;
	b->previous = NULL;

	return b;
}

Bunny* addToStart(Bunny* startPtr){
	
	Bunny* b = newBunny(startPtr);

	if(startPtr != NULL){
		startPtr->previous = b;
		b->next = startPtr;
	}

	return b;
}

Bunny* addToEnd(Bunny* startPtr){

	Bunny* returnPtr = startPtr;
	Bunny* b = NULL;

	if(startPtr == NULL){
		b = addToStart(startPtr);
		returnPtr = b;
	}
	else{
		Bunny* indexBunny = startPtr;
		while(indexBunny->next != NULL){
			indexBunny = indexBunny->next;
		}
		b = newBunny(startPtr);
		indexBunny->next = b;
		b->next = NULL;
		b->previous = indexBunny;
	}

	return returnPtr;
}

Bunny* deleteBunny(Bunny* startPtr, Bunny* deleteMe){

	//if this is the first item in the list
	if(deleteMe->previous == NULL){
		startPtr = deleteMe->next;
		deleteMe->next->previous = NULL;
		free(deleteMe);
	}
	//if this is the last bunny in the list
	else if(deleteMe->next == NULL){
		deleteMe->previous->next = NULL;
		free(deleteMe);
	}
	else{
		deleteMe->previous->next = deleteMe->next;
		deleteMe->next->previous = deleteMe->previous;
		free(deleteMe);
	}

	return startPtr;
}

Bunny* sortList(Bunny* startPtr){

	//create pointer array for every bunny in the list
	int size = getListSize(startPtr);
	Bunny* pointers[size];

	//find highest age in the list (highest)
	Bunny* b = startPtr;
	int highestAge = 0;
	while(b != NULL){
		if(b->age > highestAge){
			highestAge = b->age;
		}
		b = b->next;
	}

	int i = 0;

	//loop through the list highest+1 times
	for(int a = 0; a < highestAge + 1; ++a){
		//if b->age == age, add to next index in pointer array
		b = startPtr;
		while(b != NULL){
			if(b->age == a){
				pointers[i++] = b;
			}
			b = b->next;
		}
	}

	//put array addresses back into list
	pointers[0]->previous = NULL;
	pointers[size-1]->next = NULL;
	for(int i = 0; i < size - 1; ++i){
		pointers[i]->next = pointers[i+1];
		pointers[i+1]->previous = pointers[i];
	}

	return pointers[0];
}

void makeBunniesGrowOlder(Bunny* startPtr){
	Bunny* b = startPtr;

	while(b != NULL){
		b->age++;
		// this printf will be its own function at some point
		printf("%s grew to age %d\n", b->name, b->age);
		b = b->next;
	}
}

int getListSize(Bunny* startPtr){

	int count = 0;
	Bunny* b = startPtr;

	while(b != NULL){
		count++;
		b = b->next;
	}

	return count;
}

int countMatureFemales(Bunny* startPtr){
	int count = 0;
	Bunny* b = startPtr;

	while(b != NULL){
		if(b->sex == sexes[SEX_FEMALE] && b->age > 1){
			count++;
		}
		b = b->next;
	}

	return count;
}

int calcMatureMalePresent(Bunny* startPtr){
	Bunny* b = startPtr;
	while(b != NULL){
		if(b->sex == sexes[SEX_MALE] && b->age > 1){
			return 1;
		}
		b = b->next;
	}
	return 0;
}

void printList(Bunny* start){
	
	Bunny* b = start;

	printf("----------------------------\n");
	while(b != NULL){

		printf("Name:%s Sex:%s Age:%d Colour:%s %s\n",
			b->name,
			b->sex,
			b->age,
			b->colour,
			(b->rmvb) ? "RMVB" : ""
		);

		b = b->next;
	}
	printf("Total: %d\n----------------------------\n", getListSize(start));
}

void cleanUp(Bunny* start){

	Bunny* freeMe = start;
	Bunny* holdMe = NULL;

	while(freeMe != NULL){
		holdMe = freeMe->next;
		free(freeMe);
		freeMe = holdMe;
	}
}