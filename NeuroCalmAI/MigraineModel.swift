//
//  MigraineModel.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import Foundation

struct MigraineType: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let details: String
    let symbol: String
}

let migraineTypes: [MigraineType] = [
    MigraineType(title: "Migraine with Aura", description: "Visual disturbances before severe headache.", details: "Migraines with aura involve sensory disturbances known as 'aura' that occur before the headache itself. These disturbances are caused by cortical spreading depression, an event where a wave of electrochemical activity sweeps across the brain's cortex, disrupting normal neural activity. This leads to visual, sensory, or speech disturbances. Triptans are effective because they target serotonin receptors, helping constrict dilated blood vessels in the brain, a common feature in migraines. This constriction helps reduce the transmission of pain signals. Beta-blockers work by decreasing the activity of the nerves that trigger an increase in heart rate and blood pressure, reducing overall stress on the vascular system. Antiepileptics, like valproate and topiramate, help stabilize nerve cell membranes and manage the excitability of neurons to prevent the initiation of CSD.", symbol: "waveform.path.ecg"),
    MigraineType(title: "Migraine without Aura", description: "Most common type, involving moderate to severe pain.", details: "The most common type of migraine, this involves severe headaches without preceding sensory disturbances. The headaches typically arise from the inflammation and dilation of blood vessels in the brain, influenced by the trigeminovascular system. This system includes the trigeminal nerve, which becomes overly sensitive and reactive during a migraine, causing pain. NSAIDs (Nonsteroidal Anti-Inflammatory Drugs) alleviate the inflammation around these blood vessels, while triptans help by constricting them and blocking the release of inflammatory neuropeptides that exacerbate headache symptoms. Antidepressants and antihypertensives stabilize neurotransmitter levels and blood pressure, which can help reduce the frequency of migraine attacks by maintaining a more stable vascular environment.", symbol: "brain.head.profile"),
    MigraineType(title: "Chronic Migraine", description: "Headaches occur on 15+ days per month.", details: "This type of migraine is marked by headaches occurring on 15 or more days per month. It is associated with central sensitization, where the nervous system becomes overly sensitive to minor pain stimuli, lowering the threshold for pain and making the individual more susceptible to headaches. Botox injections help by blocking the release of certain neurotransmitters involved in pain pathways, effectively reducing the perception of pain. Topiramate works by stabilizing the electrical activity of neurons and reducing the responsiveness of the nervous system to pain signals. Beta-blockers are used to prevent fluctuations in blood vessel diameter, which can trigger headaches.", symbol: "clock.arrow.circlepath"),
    MigraineType(title: "Hemiplegic Migraine", description: "Rare and involves temporary paralysis.", details: "This rare form of migraine is characterized by temporary paralysis and other severe neurological symptoms, often resembling a stroke. These symptoms are linked to genetic mutations that affect ion channels, proteins that regulate the flow of ions like calcium and potassium across cell membranes, essential for neuron function. Malfunctioning ion channels lead to inappropriate excitation or inhibition of neuronal activity. Calcium channel blockers are used to normalize the function of these channels, thereby stabilizing the activity of nerve cells and preventing the severe symptoms associated with hemiplegic migraine.", symbol: "staroflife.fill"),
    MigraineType(
            title: "Retinal Migraine",
            description: "Temporary vision loss or blindness in one eye.",
            details: """
            Retinal migraine involves recurring bouts of visual impairment in one eye, often accompanied by or followed by a migraine headache. This condition is caused by spasms in the retinal blood vessels, reducing blood flow to the eye. The precise mechanisms leading to these spasms may include changes in nerve control or abnormal responses within the vessel walls. Aspirin is used to improve blood flow by thinning the blood and preventing clot formation, which could exacerbate the spasms. Preventive treatments such as beta-blockers and calcium channel blockers regulate the tone and responsiveness of blood vessels, reducing the likelihood of spasms and maintaining better blood flow to the retina.
            """,
            symbol: "eye.fill"
        )
    ]


