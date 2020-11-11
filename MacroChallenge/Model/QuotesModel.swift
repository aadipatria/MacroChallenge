//
//  QuotesModel.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 11/11/20.
//

import Foundation

struct Quotes {
    static let quoteList: [String] = [
        "“Together with a culture of work, there must be a culture of leisure as gratification. To put it another way: people who work must take the time to relax, to be with their families, to enjoy themselves, read, listen to music, play a sport.” - Pope Francis",
        "“Relaxation is the prerequisite for that inner expansion that allows a person to express the source of inspiration and joy within.” - Deepak Chopra",
        "“Learn to relax. Your body is precious, as it houses your mind and spirit. Inner peace begins with a relaxed body.” - Norman Vincent Peale",
        "“Sometimes we just need to put down our phones, close our eyes, and take a few deep breaths. Ideas are often in flight patterns around our brains, just waiting for clearance to land.” - Sam Harrison",
        "“We will be more successful in all our endeavors if we can let go of the habit of running all the time, and take little pauses to relax and re-center ourselves. And we’ll also have a lot more joy in living.” - Thich Nhat Hanh",
        "“Your mind will answer most questions if you learn to relax and wait for the answer.” - William S. Burroughs",
        "“Relax and refuse to let worry and stress rule your life. There is always a solution to every problem. Things will work out for you when you take time to relax, refresh, restore and recharge your soul.” - Lailah Gifty Akita",
        "“As important as it is to have a plan for doing work, it is perhaps more important to have a plan for rest, relaxation, self-care, and sleep.” - Akiroq Brost",
        "“The only time I waste is time I spend doing something that, in my gut, I know I shouldn’t. If I choose to spend time playing video games or sleeping in, then it’s time well spent, because I chose to do it. I did it for a reason - to relax, to decompress, or to feel good, and that was what I wanted to do.” - Simon Sinek",
        "“Your calm mind is the ultimate weapon against your challenges. So, relax.” - Bryant McGill",
        "“If a man insisted always on being serious, and never allowed himself a bit of fun and relaxation, he would go mad or become unstable without knowing it.” - Herodotus",
        "“The breaks you take from work pay you back manifold when you return because you come back with a fresher mind and newer thinking. Some of your best ideas come when you’re on vacation.” - Gautam Singhania",
        "“Stop a minute, right where you are. Relax your shoulders, shake your head and spine like a dog shaking off cold water. Tell that imperious voice in your head to be still.” - Barbara Kingsolver",
        "“The more relaxed you are, the better you are at everything: the better you are with your loved ones, the better you are with your enemies, the better you are at your job, the better you are with yourself.” - Bill Murray",
        "“It’s a good idea always to do something relaxing prior to making an important decision in your life.” - Paulo Coelho",
        "“Every now and then go away, have a little relaxation, for when you come back to your work your judgment will be surer.” - Leonardo da Vinci",
        "“The mind should be allowed some relaxation, that it may return to its work all the better for the rest.” - Seneca",
        "“The happiness we seek cannot be found through grasping, trying to hold on to things. It cannot be found through getting serious and uptight about wanting things to go in the direction we think will bring happiness. We are always taking hold of the wrong end of the stick. The point is that the happiness we seek is already here, and it will be found through relaxation and letting go rather than through struggle.” -Pema Chodron",
        "“No matter how much pressure you feel at work, if you could find ways to relax for at least five minutes every hour, you’d be more productive.” - Dr. Joyce Brothers",
        "“During periods of relaxation after concentrated intellectual activity, the intuitive mind seems to take over and can produce the sudden clarifying insights which give so much joy and delight.” - Fritjof Capra",
    ]
    
    static func getRandQuotes() -> String {
        let randNumber = Int.random(in: 0..<20)
        
        var quote = quoteList[randNumber]
        
        let lastIndex: String.Index
        lastIndex = quote.lastIndex(of: "”")!
        let indexAft = quote.index(after: lastIndex)
        quote.insert("\n", at: indexAft)
        
        return quote
    }
}
