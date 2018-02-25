package relearning;
import java.util.*;
import java.util.stream.*;
public class FunctionalProgrammingTest {

	public static void main(String[] args) {
		////////////////////TPS 1////////////////////////////////
		//		List<String> someList = new ArrayList<String>();
		//		someList.add("Barb");
		//		someList.add("Cal");
		//		someList.add("Abe");
		//		someList.add("Fred");
		//		someList.add("Dan");
		//
		//		List<String> sortNames = someList.stream().filter(
		//				(s) ->{
		//					String upper = s.toUpperCase();
		//					if(s.substring(0,1).compareTo("D")<0){
		//						return true;
		//					}
		//					else
		//						return false;
		//				}
		//		).collect(Collectors.toCollection(ArrayList::new));
		//		Collections.sort(sortNames, (s1, s2)->s1.compareTo(s2));
		//			System.out.println(sortNames);

		/////////////////////////TPS 2////////////////////////////////
		List<String> someList = new ArrayList<String>();
		someList.add("Barb");
		someList.add("Cal");
		someList.add("Abe");
		someList.add("Fred");
		someList.add("Dan");
		someList.add("John");
		someList.add("Joel");

		List<String> sortNames = someList.stream().filter(
				(s) ->{
					String upper = s.toUpperCase();
					if(upper.substring(0,1).equals("J")){
						return true;
					}
					else
						return false;
				}
				).collect(Collectors.toCollection(ArrayList::new));
		System.out.println(sortNames);
	}
}
