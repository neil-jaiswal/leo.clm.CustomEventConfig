GO

DECLARE @EventId AS UNIQUEIDENTIFIER;
DECLARE @EventConfigId AS UNIQUEIDENTIFIER;
DECLARE @BPC AS VARCHAR(500);
DECLARE @AppId AS INT;
DECLARE @EventName AS VARCHAR(100);
DECLARE @EventConfigurationType AS VARCHAR(100);
DECLARE @RuleEngineConfigurationId AS UNIQUEIDENTIFIER;
DECLARE @BPMEngineId AS UNIQUEIDENTIFIER;
DECLARE @DocumentEntity AS VARCHAR(100);
DECLARE @EventMomentId AS INT;
DECLARE @BusinessCase AS VARCHAR(100);
DECLARE @DocumentGroup AS VARCHAR(100);
DECLARE @EventTrigger AS VARCHAR(100);
DECLARE @Scope AS VARCHAR(100);
DECLARE @ProcessName AS VARCHAR(100);
DECLARE @MessageName AS VARCHAR(100);
DECLARE @Version AS INT;
DECLARE @OnPre AS BIT;
DECLARE @IsActive AS BIT;
DECLARE @ExecuteAllRules AS BIT;
DECLARE @Sequence AS INT;

SET @BPC = '197250';

BEGIN
	SET @EventId = '3d959ab6-3b41-4bdb-95f4-a5b8bfbde204';
	SET @AppId = 245;
	SET @DocumentEntity = 'CLM';
	SET @EventName = 'CLMReviewDone';
	SET @IsActive = 1;
	SET @OnPre = 1

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[Events]
			WHERE ([EventId] = @EventId OR ([AppId] = @AppId AND [EventName] = @EventName AND [DocumentEntity] = @DocumentEntity))
			)
	BEGIN
		INSERT INTO [dbo].[Events] (
			[EventId]
			,[AppId]
			,[DocumentEntity]
			,[EventName]
			,[IsActive]
			,[CreatedOn]
			,[CreatedBy]
			,[ModifiedOn]
			,[ModifiedBy]
			,[OnPre]
			)
		VALUES (
			@EventId
			,@AppId
			,@DocumentEntity
			,@EventName
			,@IsActive
			,getdate()
			,'SYSTEM'
			,NULL
			,NULL
			,@OnPre
			)
	END
	ELSE
	BEGIN
		SELECT @EventId = [EventId]
		FROM [dbo].[Events]
		WHERE ([EventId] = @EventId OR ([AppId] = @AppId AND [EventName] = @EventName AND [DocumentEntity] = @DocumentEntity));

		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[Events]
				WHERE ([EventId] = @EventId AND [AppId] = @AppId AND [EventName] = @EventName AND [DocumentEntity] = @DocumentEntity AND [EventName] = @EventName AND [IsActive] = @IsActive AND [OnPre] = @OnPre)
				)
		BEGIN
			UPDATE [dbo].[Events]
			SET [AppId] = @AppId
				,[DocumentEntity] = @DocumentEntity
				,[EventName] = @EventName
				,[IsActive] = @IsActive
				,[ModifiedOn] = getdate()
				,[ModifiedBy] = 'SYSTEM'
				,[OnPre] = @OnPre
			WHERE [EventId] = @EventId
		END
	END;

	/* Rule */
	SET @EventConfigId = '3d959ab6-3b41-4bdb-95f4-a5b8bfbde204';
	SET @EventConfigurationType = 'Rule';
	SET @EventMomentId = 1;
	SET @IsActive = 1;
	SET @Sequence = 1;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[EventConfigurations]
			WHERE ([EventConfigurationId] = @EventConfigId OR ([EventId] = @EventId AND [BPC] = @BPC AND [EventConfigurationType] = @EventConfigurationType))
			)
	BEGIN
		INSERT INTO [dbo].[EventConfigurations] (
			[EventConfigurationId]
			,[EventId]
			,[BPC]
			,[EventMomentId]
			,[EventConfigurationType]
			,[Sequence]
			,[IsActive]
			,[IsSync]
			,[CreatedOn]
			,[CreatedBy]
			,[ModifiedOn]
			,[ModifiedBy]
			)
		VALUES (
			@EventConfigId
			,@EventId
			,@BPC
			,@EventMomentId
			,@EventConfigurationType
			,@Sequence
			,@IsActive
			,1
			,getdate()
			,'SYSTEM'
			,NULL
			,NULL
			);
	END
	ELSE
	BEGIN
		SELECT @EventConfigId = [EventConfigurationId]
		FROM [dbo].[EventConfigurations]
		WHERE ([EventConfigurationId] = @EventConfigId OR ([EventId] = @EventId AND [BPC] = @BPC AND [EventConfigurationType] = @EventConfigurationType));

		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[EventConfigurations]
				WHERE ([EventConfigurationId] = @EventConfigId AND [EventId] = @EventId AND [BPC] = @BPC AND [EventConfigurationType] = @EventConfigurationType AND [EventMomentId] = @EventMomentId AND [Sequence] = @Sequence AND [IsActive] = @IsActive)
				)
		BEGIN
			UPDATE [dbo].[EventConfigurations]
			SET [EventId] = @EventId
				,[BPC] = @BPC
				,[EventMomentId] = @EventMomentId
				,[EventConfigurationType] = @EventConfigurationType
				,[Sequence] = @Sequence
				,[IsActive] = @IsActive
				,[IsSync] = 1
				,[ModifiedOn] = getdate()
				,[ModifiedBy] = 'SYSTEM'
			WHERE [EventConfigurationId] = @EventConfigId;
		END
	END;

	SET @RuleEngineConfigurationId = 'e1aa46c0-7f3d-458a-8182-de1d18db2e68';
	SET @DocumentGroup = 'clm';
	SET @EventTrigger = 'review';
	SET @ExecuteAllRules = 1
	SET @Version = NULL

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[RuleEngineConfiguration]
			WHERE ([EventConfigurationId] = @EventConfigId OR [RuleEngineConfigurationId] = @RuleEngineConfigurationId)
			)
	BEGIN
		INSERT INTO [dbo].[RuleEngineConfiguration] (
			[RuleEngineConfigurationId]
			,[EventConfigurationId]
			,[BusinessCase]
			,[DocumentGroup]
			,[EventTrigger]
			,[Scope]
			,[Version]
			,[ExecuteAllRules]
			,[IsActive]
			,[CreatedOn]
			,[CreatedBy]
			,[ModifiedOn]
			,[ModifiedBy]
			)
		VALUES (
			@RuleEngineConfigurationId
			,@EventConfigId
			,NULL
			,@DocumentGroup
			,@EventTrigger
			,NULL
			,@Version
			,@ExecuteAllRules
			,@IsActive
			,getdate()
			,'SYSTEM'
			,NULL
			,NULL
			);
	END
	ELSE
	BEGIN
		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[RuleEngineConfiguration]
				WHERE [EventConfigurationId] = @EventConfigId AND [RuleEngineConfigurationId] = @RuleEngineConfigurationId AND [DocumentGroup] = @DocumentGroup AND [EventTrigger] = @EventTrigger AND [Scope] = @Scope AND [Version] = @Version
				)
		BEGIN
			UPDATE [dbo].[RuleEngineConfiguration]
			SET [BusinessCase] = NULL
				,[DocumentGroup] = @DocumentGroup
				,[EventTrigger] = @EventTrigger
				,[Scope] = NULL
				,[Version] = @Version
				,[ExecuteAllRules] = @ExecuteAllRules
				,[IsActive] = @IsActive
				,[ModifiedOn] = getdate()
				,[ModifiedBy] = 'SYSTEM'
			WHERE ([EventConfigurationId] = @EventConfigId AND [RuleEngineConfigurationId] = @RuleEngineConfigurationId);
		END
	END;
END;
GO

