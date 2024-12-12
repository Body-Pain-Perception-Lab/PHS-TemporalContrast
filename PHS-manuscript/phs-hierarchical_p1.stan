//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// ordered beta function
functions{
  
  real ord_beta_reg_lpdf(real y, real mu, real phi, real cutzero, real cutone) {

    vector[2] thresh;
    thresh[1] = cutzero;
    thresh[2] = cutzero + exp(cutone);

  if(y==0) {
      return log1m_inv_logit(mu - thresh[1]);
    } else if(y==1) {
      return log_inv_logit(mu  - thresh[2]);
    } else {
      return log_diff_exp(log_inv_logit(mu   - thresh[1]), log_inv_logit(mu - thresh[2])) +
                beta_lpdf(y|exp(log_inv_logit(mu) + log(phi)),exp(log1m_inv_logit(mu) + log(phi)));
    }
  }
  
  real induced_dirichlet_lpdf(real nocut, vector alpha, real phi, int cutnum, real cut1, real cut2) {
    int K = num_elements(alpha);
    vector[K-1] c = [cut1, cut1 + exp(cut2)]';
    vector[K - 1] sigma = inv_logit(phi - c);
    vector[K] p;
    matrix[K, K] J = rep_matrix(0, K, K);

    if(cutnum==1) {

    // Induced ordinal probabilities
    p[1] = 1 - sigma[1];
    for (k in 2:(K - 1))
      p[k] = sigma[k - 1] - sigma[k];
    p[K] = sigma[K - 1];

    // Baseline column of Jacobian
    for (k in 1:K) J[k, 1] = 1;

    // Diagonal entries of Jacobian
    for (k in 2:K) {
      real rho = sigma[k - 1] * (1 - sigma[k - 1]);
      J[k, k] = - rho;
      J[k - 1, k] = rho;
    }

    // divide in half for the two cutpoints

    // don't forget the ordered transformation

      return   dirichlet_lpdf(p | alpha)
           + log_determinant(J) + cut2;
    } else {
      return(0);
    }
  }
}

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; //number of trials
  int S; //number of subjects
  array[N] int S_id; //subject identifier
  
  array[N] int phs; //input - phs
  vector[N] tcf; //input - contrast
  //vector[S] age_z; //normliased age of subject
}

// The parameters accepted by the model.
// subject level with normal distribution around the parameters
parameters {
  // phs
  vector[4] mus_phs;
  vector<lower=0>[4] sigmas_phs;
  matrix[4,S] difs_phs;
  
  // age
  //vector[2] mus_age;
}

//transformed parameters for the model
// check that this is correct with Jesper
transformed parameters {
  vector[N] p;
  
  // intercepts and slopes for each subject
  // phs
  vector[S] a_phs = exp(to_vector(mus_phs[1]+(difs_phs[1,])*sigmas_phs[1]));
  vector[S] b_phs = exp(to_vector(mus_phs[2]+(difs_phs[2,])*sigmas_phs[2]));
  vector[S] g_phs = to_vector(inv_logit(mus_phs[3]+(difs_phs[3,])*sigmas_phs[3])/2);
  vector[S] l_phs = to_vector(inv_logit(mus_phs[4]+(difs_phs[4,])*sigmas_phs[4])/2);
  
  // logistic function for each subject
  for (n in 1:N){
    p[n] = g_phs[S_id[n]]+(1-g_phs[S_id[n]]-l_phs[S_id[n]])*(inv_logit(b_phs[S_id[n]]*(tcf[n]-a_phs[S_id[n]]))); //log_probit function
    //rtP[n] = a_rt[S_id[n]]+b_rt[S_id[n]]*p[n];
    //cP[n] = a_conf[S_id[n]]+b_conf[S_id[n]]*p[n];
    }
  
}

// The model to be estimated. 
model {
  // phs priors
  mus_phs[1] ~ normal(4,.5); //mu
  sigmas_phs[1] ~ normal(1,.5); 

  mus_phs[2] ~ normal(-2,1.5); //beta
  sigmas_phs[2] ~ normal(0,1);

  mus_phs[3] ~ normal(-5,1); //guess
  sigmas_phs[3] ~ normal(0,1);

  mus_phs[4] ~ normal(0,1); //lapse
  sigmas_phs[4] ~ normal(0,1);

  to_vector(difs_phs) ~ std_normal(); //subject differentials
  
  // age priors
  //mus_age ~ normal(0,0.3);
  
  // estimating phs and rt
  for(n in 1:N){
    phs[n] ~ bernoulli(p[n]);
    //log_rt[n] ~ normal(rtP[n], sigma_rt[S_id[n]]);
    //conf[n] ~ ord_beta_reg(cP[n], phi_conf[S_id[n]], c0_conf[S_id[n]], c1_conf[S_id[n]]);
  }
}

