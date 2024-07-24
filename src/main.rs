// src: https://doc.rust-lang.ru/book/ch02-00-guessing-game-tutorial.html

use std::io;
use rand::Rng;
use std::cmp::Ordering;

fn main() {
    println!("================================");
    println!("Guess the number!");
    println!("================================");

    let secret_number = rand::thread_rng().gen_range(1..=100);
    println!("Plese input your guess.");

    let mut guess_count: u32 = 0;
    
    loop {
        let mut guess = String::new();
        guess_count += 1;
        io::stdin()
            .read_line(&mut guess)
            .expect("Fialed to read line :(");
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win. You guessed it on the {guess_count} attempt!");
                break;
            },
        }
    }
}
