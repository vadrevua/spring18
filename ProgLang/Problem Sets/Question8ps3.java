package relearning;

import java.awt.List;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.*;
import java.util.stream.*;

public class Question8ps3 {

	public String name;
	public String league;
	public String goals;
	public String spg;
	public String pp;
	public String psp;
	public String aw;

	public Question8ps3(String cName,String cLeague,String cGoals,String cSPG,String cPP,String cPSP,String cAW){
		name = cName;
		league = cLeague;
		goals = cGoals;
		spg = cSPG;
		pp = cPP;
		psp = cPSP;
		aw = cAW;
	}

	static ArrayList<Question8ps3> teams = new ArrayList<Question8ps3>();

	public static void main(String[] args) throws IOException {
		loadFiles();
		System.out.println("Part A");
		teams.forEach((Question8ps3 temp) ->
			{System.out.println("Team Name: " +temp.name + "\tLeague Name: " + temp.league);});

		System.out.println("Part B");
		teams.stream().filter((Question8ps3 s) ->
			Integer.parseInt(s.goals)<5).forEach((Question8ps3 temp) ->
			{System.out.println("Team Name: " +temp.name + "\tLeague Name: " + temp.league+ "\tGoals Scored: " + temp.goals);});

		System.out.println("Part C");
		teams.stream() //
	    .mapToInt(i -> Integer.parseInt(i.goals)) //
	    .average() //
	    .ifPresent(avg -> System.out.println("Average is " + avg));
	}





	public static void loadFiles() throws IOException{
		File soccer = new File("C:/Users/Aditya/workspace/relearning/src/SoccerStats.txt");
		String line = null;
		try {
			FileReader fileReader = new FileReader(soccer);
			BufferedReader bufferedReader = new BufferedReader(fileReader);

			while((line = bufferedReader.readLine()) != null) {
				String val[] = line.split(",");
	            teams.add(new Question8ps3(val[0],val[1],val[2],val[3],val[4],val[5],val[6]));
			}
			bufferedReader.close();
		}
		catch(FileNotFoundException e){
			System.out.println("Not read");
		}
	}


}
