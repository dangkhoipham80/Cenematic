/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

/**
 *
 * @author admin
 */
import java.security.SecureRandom;

public class SoNgauNhien {

    // A verification code is a credential: java.util.Random is seeded
    // predictably, so codes could be guessed from a couple of observed values.
    private static final SecureRandom RANDOM = new SecureRandom();

    /** Six-digit verification code, zero-padded so it is always 6 characters. */
    public static String getSoNgauNhien() {
        return String.format("%06d", RANDOM.nextInt(1000000));
    }
}
