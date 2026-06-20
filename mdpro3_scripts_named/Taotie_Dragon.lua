--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 饕餮龙  (ID: 82566662)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Wyrm
-- ATK 2500 | LINK
--
-- Effect Text:
-- 从额外卡组特殊召唤的怪兽2只以上
-- ①：这张卡得到作为这张卡的连接素材的怪兽种类的以下效果。
-- ●融合：战斗阶段中对方不能把怪兽的效果发动。
-- ●同调：自己主要阶段中对方不能把魔法·陷阱卡的效果发动。
-- ●超量：自己的主要阶段以及战斗阶段中对方不能把墓地的卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--トウテツドラゴン
function c82566662.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c82566662.matfilter,2)
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c82566662.regcon)
	e1:SetOperation(c82566662.regop)
	c:RegisterEffect(e1)
end
function c82566662.matfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c82566662.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c82566662.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterial():FilterCount(Card.IsLinkType,nil,TYPE_FUSION)>0 then
		--activate limit - fusion -> monster
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetTargetRange(0,1)
		e1:SetCondition(c82566662.condition1)
		e1:SetValue(c82566662.aclimit1)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(82566662,0))
	end
	if c:GetMaterial():FilterCount(Card.IsLinkType,nil,TYPE_SYNCHRO)>0 then
		--activate limit - synchro -> spell/trap
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ACTIVATE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetTargetRange(0,1)
		e2:SetCondition(c82566662.condition2)
		e2:SetValue(c82566662.aclimit2)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(82566662,1))
	end
	if c:GetMaterial():FilterCount(Card.IsLinkType,nil,TYPE_XYZ)>0 then
		--activate limit - XYZ -> grave
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetCode(EFFECT_CANNOT_ACTIVATE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		e3:SetTargetRange(0,1)
		e3:SetCondition(c82566662.condition3)
		e3:SetValue(c82566662.aclimit3)
		c:RegisterEffect(e3)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(82566662,2))
	end
end
function c82566662.condition1(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c82566662.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c82566662.condition2(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or ph==PHASE_MAIN2) and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c82566662.aclimit2(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c82566662.condition3(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or ph==PHASE_MAIN2 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE))
		and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c82566662.aclimit3(e,re,tp)
	return re:GetActivateLocation()==LOCATION_GRAVE
end
