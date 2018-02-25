package relearning;
import java.util.*;
import java.util.stream.*;
public class JNamesOnly {

	public static void main(String[] args) {
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
