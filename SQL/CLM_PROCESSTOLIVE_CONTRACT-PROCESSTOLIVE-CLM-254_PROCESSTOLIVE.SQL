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
	SET @EventId = '8f7a60df-dc2c-40e9-ab53-f6e2cff5dfe5';
	SET @AppId = 245;
	SET @DocumentEntity = 'CLM';
	SET @EventName = 'ProcessToLive';
	SET @IsActive = 1;
	SET @OnPre = 1

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[Events]
			WHERE (
					[EventId] = @EventId
					OR (
						[AppId] = @AppId
						AND [EventName] = @EventName
						AND [DocumentEntity] = @DocumentEntity
						)
					)
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
		WHERE (
				[EventId] = @EventId
				OR (
					[AppId] = @AppId
					AND [EventName] = @EventName
					AND [DocumentEntity] = @DocumentEntity
					)
				);

		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[Events]
				WHERE (
						[EventId] = @EventId
						AND [AppId] = @AppId
						AND [EventName] = @EventName
						AND [DocumentEntity] = @DocumentEntity
						AND [EventName] = @EventName
						AND [IsActive] = @IsActive
						AND [OnPre] = @OnPre
						)
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

	/* Camunda */
	SELECT @EventConfigId = 'bb4c03f3-12eb-4442-a79d-48046a718dab'
	SELECT @EventConfigurationType = 'Camunda'
	SET @EventMomentId = 2;
	SET @IsActive = 1;
	SET @Sequence = 1;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[EventConfigurations]
			WHERE (
					[EventConfigurationId] = @EventConfigId
					OR (
						[EventId] = @EventId
						AND [BPC] = @BPC
						AND [EventConfigurationType] = @EventConfigurationType
						)
					)
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
			)
	END
	ELSE
	BEGIN
		SELECT @EventConfigId = [EventConfigurationId]
		FROM [dbo].[EventConfigurations]
		WHERE (
				[EventConfigurationId] = @EventConfigId
				OR (
					[EventId] = @EventId
					AND [BPC] = @BPC
					AND [EventConfigurationType] = @EventConfigurationType
					)
				);

		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[EventConfigurations]
				WHERE (
						[EventConfigurationId] = @EventConfigId
						AND [EventId] = @EventId
						AND [BPC] = @BPC
						AND [EventConfigurationType] = @EventConfigurationType
						AND [EventMomentId] = @EventMomentId
						AND [Sequence] = @Sequence
						AND [IsActive] = @IsActive
						)
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
			WHERE [EventConfigurationId] = @EventConfigId
		END
	END;

	SET @BPMEngineId = '96c7f17e-7b35-460e-97ec-ec86eb8f86f0';
	SET @ProcessName = 'CLM_PROCESSTOLIVE_CONTRACT-PROCESSTOLIVE-CLM-254';
	SET @MessageName = '';

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].[BPMEngineConfiguration]
			WHERE (
					[EventConfigurationId] = @EventConfigId
					OR [BPMEngineId] = @BPMEngineId
					)
			)
	BEGIN
		INSERT INTO [dbo].[BPMEngineConfiguration] (
			[BPMEngineId]
			,[EventConfigurationId]
			,[ProcessName]
			,[MessageName]
			,[Version]
			,[IsActive]
			,[CreatedOn]
			,[CreatedBy]
			,[ModifiedOn]
			,[ModifiedBy]
			)
		VALUES (
			@BPMEngineId
			,@EventConfigId
			,@ProcessName
			,@MessageName
			,NULL
			,1
			,getdate()
			,'SYSTEM'
			,NULL
			,NULL
			)
	END
	ELSE
	BEGIN
		IF NOT EXISTS (
				SELECT 1
				FROM [dbo].[BPMEngineConfiguration]
				WHERE [EventConfigurationId] = @EventConfigId
					AND [BPMEngineId] = @BPMEngineId
					AND [ProcessName] = @ProcessName
					AND (
						@MessageName IS NULL
						OR [MessageName] = @MessageName
						)
				)
		BEGIN
			UPDATE [dbo].[BPMEngineConfiguration]
			SET [ProcessName] = @ProcessName
				,[MessageName] = @MessageName
				,[IsActive] = @IsActive
				,[ModifiedOn] = getdate()
				,[ModifiedBy] = 'SYSTEM'
			WHERE (
					[EventConfigurationId] = @EventConfigId
					AND [BPMEngineId] = @BPMEngineId
					);
		END
	END;
END;
GO

