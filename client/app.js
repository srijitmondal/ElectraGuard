const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS"; // Replace with your deployed contract address
const contractABI = [
  // Replace with your contract's ABI
];

let web3;
let votingContract;

window.onload = async function () {
  if (typeof window.ethereum !== "undefined") {
    web3 = new Web3(window.ethereum);
    await ethereum.request({ method: "eth_requestAccounts" });

    votingContract = new web3.eth.Contract(contractABI, contractAddress);

    const candidates = await votingContract.methods.getCandidates().call();
    const candidatesDiv = document.getElementById("candidates");

    candidates.forEach((candidate, index) => {
      const candidateElement = document.createElement("div");
      candidateElement.className = "candidate";
      candidateElement.innerHTML = `
        <h3>${candidate.name}</h3>
        <button onclick="vote(${index})">Vote</button>
      `;
      candidatesDiv.appendChild(candidateElement);
    });
  } else {
    alert("Please install MetaMask!");
  }
};

async function vote(candidateIndex) {
  const accounts = await web3.eth.getAccounts();
  await votingContract.methods.vote(candidateIndex).send({ from: accounts[0] });
  alert("Vote cast successfully!");
}
