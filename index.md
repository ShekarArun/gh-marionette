# Portfolio

## About Me

<div style="display: flex; align-items: center; gap: 20px; margin-bottom: 30px;">
  <img src="https://github.com/ShekarArun.png" style="width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 3px solid #0366d6;">
  <div>
    <h3>Hello! I'm Arun Shekar</h3>
    <p>I'd like to make a better world with the power of technology!</p>
    <div style="margin-top: 10px;">
      <a href="https://github.com/ShekarArun" target="_blank" style="text-decoration: none; margin-right: 15px;">
        <img src="https://img.shields.io/badge/GitHub-%23181717.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
      </a>
      <a href="https://www.linkedin.com/in/arun-shekar/" target="_blank" style="text-decoration: none; margin-right: 15px;">
        <img src="https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
      </a>
    </div>
  </div>
</div>

## Terraform-Generated Repositories

<p>Last updated: Mar 28, 2025 at 15:47</p>

<table>
  <thead>
    <tr>
      <th>Repository</th>
      <th>Environment</th>
      <th>Type</th>
      <th>Created</th>
      <th>Status</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
    %{ for repo in repositories }
    <tr>
      <td><strong>${repo.name}</strong></td>
      <td><span style="display: inline-block; padding: 3px 8px; border-radius: 3px; background-color: ${repo.environment == "prd" ? "#d73a4a" : "#2188ff"}; color: white;">${repo.environment}</span></td>
      <td>${repo.type}</td>
      <td>${repo.created_at}</td>
      <td>
        %{ if repo.is_active }
        <span style="color: #28a745;">●</span> Active
        %{ else }
        <span style="color: #d73a4a;">●</span> Inactive
        %{ endif }
      </td>
      <td>
        <a href="https://github.com/${github_username}/${repo.name}" target="_blank" style="text-decoration: none; margin-right: 10px;">
          <img src="https://img.shields.io/badge/GitHub-181717?style=flat&logo=github" alt="GitHub">
        </a>
        %{ if repo.has_pages }
        <a href="https://${github_username}.github.io/${repo.name}/" target="_blank" style="text-decoration: none;">
          <img src="https://img.shields.io/badge/Website-0366d6?style=flat&logo=github-pages" alt="Website">
        </a>
        %{ else }
        N/A
        %{ endif }
      </td>
    </tr>
    %{ endfor }
  </tbody>
</table>

## Repository Statistics

<div style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 30px;">
  <div style="flex: 1; min-width: 250px; padding: 15px; border: 1px solid #e1e4e8; border-radius: 6px;">
    <h3>Environment Distribution</h3>
    <ul>
      <li><strong>Development:</strong> ${dev_count} repositories</li>
      <li><strong>Production:</strong> ${prod_count} repositories</li>
    </ul>
  </div>
  
  <div style="flex: 1; min-width: 250px; padding: 15px; border: 1px solid #e1e4e8; border-radius: 6px;">
    <h3>Repository Types</h3>
    <ul>
      <li><strong>Frontend:</strong> ${frontend_count} repositories</li>
      <li><strong>Backend:</strong> ${backend_count} repositories</li>
      <li><strong>Infrastructure:</strong> ${infra_count} repositories</li>
    </ul>
  </div>
</div>

## Latest Activity

<table>
  <thead>
    <tr>
      <th>Repository</th>
      <th>Last Updated</th>
      <th>Recent Actions</th>
    </tr>
  </thead>
  <tbody>
    %{ for activity in recent_activities }
    <tr>
      <td><strong>${activity.repo_name}</strong></td>
      <td>${activity.last_updated}</td>
      <td>${activity.action_description}</td>
    </tr>
    %{ endfor }
  </tbody>
</table>

---

<footer style="text-align: center; margin-top: 50px; color: #586069; font-size: 14px;">
  <p>Generated with Terraform on ${timestamp}</p>
  <p>© ${current_year} ${full_name} • All Rights Reserved</p>
</footer>