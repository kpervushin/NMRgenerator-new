function sn=calc_sn_resolution(filename, td, in0, R2eff)
%% calculate Signal to noise and resolution (digital resolution) for
%% indirectly sampled dimension
% filename - the name of txt file with the precomputed chem shift evolution function
% td - number of sampled points
% in0, total time increment
% R2eff - effective reklaxation rate of the evolving spin state(s)
% Usage example from hmqc:
% calc_sn_resolution('cs_evolution_0.035.txt',100,0.000167*2,100)
% Example of locally available shape:
% calc_sn_resolution('cs_evolution_0.04.txt', 256, 0.00004, 1.)
%% Read cs_evolution function
wavefile = fopen(filename, 'r');
if wavefile<0
    error(['calc_sn_resolution: ' filename ' !does not exist or could not be opened!']);
else
    ;%disp(['calc_sn_resolution: opened chem shift evolution function ' filename]);
end;

%% Read the file
%textscan(wavefile, '#%s','commentStyle','#');
waveform = textscan(wavefile, '%f %f');
fclose(wavefile);

 


%% Extract amplitudes and timerun
sampled_time=cell2mat(waveform(1))';
sampled_amplitudes=cell2mat(waveform(2))';
% normalize
sampled_amplitudes=sampled_amplitudes/max(sampled_amplitudes);
cs_npoints=length(sampled_amplitudes);
cs_integral=simps(sampled_amplitudes)/cs_npoints;



%% Interpolate evolution function

for k=1:td
    timepoints(k)=k*in0;
end %for k=1:td

func_points = interp1(sampled_time,sampled_amplitudes,timepoints,'cubic'); 
%plot(sampled_time,sampled_amplitudes,'o',timepoints,func_points)
%plot(sampled_time,sampled_amplitudes)
%plot(timepoints,func_points)

%% construct FID and fft it. 
% apodization function, ssb=2, SIN or QSIN
x=1:td;
ssb=cos(x*pi/2/td);
MI= 64*64; % so many trials to compute s/n
 for m=1:MI
% random noise
rn = (random('Normal',0,1,1,td)+i*random('Normal',0,1,1,td))*0.1;   %add 10% noise to real part of the complex time domain
noise_rmsd=norm(rn)/sqrt(td); %/sqrt(2)

% fid
for k=1:td
    fid(k)=(func_points(k)*exp(-R2eff*k*in0)+rn(k))*ssb(k);
end %for k=1:td
%plot(timepoints,fid)

%1/a

%SI=2048;
SI=td*8;
spec=fftshift(fft(fid,SI)); 
freq=1:SI;

%plot(freq,spec)


peak_hight(m)=max(real(spec));
baseline_in_spectrum(m)=sum(spec(1:SI/4))/(SI/4);
%disp(['baseline_in_spectrum ' num2str(real(baseline_in_spectrum(m)))])
spec=spec-sum(spec(1:SI/4))/(SI/4);
noise_in_spectrum(m)=norm(spec(1:SI/4)/sqrt(SI/4)); %take left quater of the spectrum
sig_to_noise(m)=(max(real(spec)) )/noise_in_spectrum(m);        % compute signal to noise
%traverse spectrum at 1/2 peak_hight
spec_width(m)=-1;
for k=1:SI
    if((real(spec(k))>= peak_hight(m)/2) && (spec_width(m)<0) ) 
        spec_width(m)=2*(SI/2-k)*(1/in0/SI);
         %disp(['SI/2 ' num2str(SI/2) ' k: ' num2str(k)])
    end;
end %for k=1:SI
%disp(['Sig max: ' num2str(peak_hight(m)) '  Noise rmsd: ' num2str(noise_in_spectrum(m))   ' Linewidth (Hz): ' num2str(spec_width(m))  ' S/N: ' num2str(sig_to_noise(m)) ]);

 end % for m=1:32
p1_av=sum(peak_hight)/MI; p1_rmsd = norm(peak_hight-p1_av)/sqrt(MI);
p2_av=sum(noise_in_spectrum)/MI; p2_rmsd = norm(noise_in_spectrum-p2_av)/sqrt(MI);
p3_av=sum(spec_width)/MI; p3_rmsd = norm(spec_width-p3_av)/sqrt(MI);
p4_av=sum(sig_to_noise)/MI; p4_rmsd = norm(sig_to_noise-p4_av)/sqrt(MI);

%plot(timepoints,real(fid))
plot(freq/in0/SI-0.5/in0,real(spec));
disp(['TD ' num2str(td) ' Sig max: ' num2str(p1_av) ' +/-' num2str(p1_rmsd) '  Noise rmsd: ' num2str(p2_av) ' +/-' num2str(p2_rmsd)   ' Linewidth (Hz): ' num2str(p3_av) ' +/-' num2str(p3_rmsd)  ' S/N: ' num2str(p4_av) ' +/-' num2str(p4_rmsd) ' S/N/td: ' num2str(p4_av/td) ' t1max: ' num2str(in0*td)]);

end