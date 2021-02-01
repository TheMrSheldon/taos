
auto& cgaData = *reinterpret_cast<char(*)[][250]>((void*)0xB8000);

int main() {
	cgaData[0][0] = 'H';
	cgaData[0][1] = 'B';
	cgaData[0][2] = 'E';
	cgaData[0][3] = 'B';
	cgaData[0][4] = 'L';
	cgaData[0][5] = 'B';
	cgaData[0][6] = 'L';
	cgaData[0][7] = 'B';
	cgaData[0][8] = 'O';
	cgaData[0][9] = 'B';
	cgaData[0][10] = ' ';
	cgaData[0][11] = 'B';
	cgaData[0][12] = 'W';
	cgaData[0][13] = 'B';
	cgaData[0][14] = 'O';
	cgaData[0][15] = 'B';
	cgaData[0][16] = 'R';
	cgaData[0][17] = 'B';
	cgaData[0][18] = 'L';
	cgaData[0][19] = 'B';
	cgaData[0][20] = 'D';
	cgaData[0][21] = 'B';
	while(true);
	return 0;
}