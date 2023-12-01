import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public class Main {

	public static void main(String[] args) throws InterruptedException {
		Scanner sc = new Scanner(System.in);
		/*System.out.println("Bienvenido a esta aventura. Pulsa enter para empezar.");
		String nombreJugador = sc.nextLine();
		System.out.println("Como se llamara tu jugador.");
		nombreJugador = sc.nextLine();
	    System.out.println("Hola "+nombreJugador+" tu aventura empieza ya.");
	    System.out.print("Cargando. . .");
	    TimeUnit.SECONDS.sleep(1);
	    System.out.println();*/
		PrimerCamino primerCamino = new PrimerCamino();
		
		  System.out.println("Estas apunto de adentrarte a un bosque ¿qué haces?\n1.Adentrarse.\n2.No adentrarse.");
	        primerCamino.primeraDecision(sc.nextLine()); //Esto envia el valor a la clase
	        
	}

}
