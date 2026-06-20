--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 邪遗式人鱼风灵  (ID: 76372778)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 4
-- ATK 2100 | DEF 1600
-- Setcode: 58
--
-- Effect Text:
-- 4星怪兽×2
-- 这张卡战斗破坏对方怪兽的场合，那次伤害计算后可以把这张卡1个超量素材取除，破坏的那只怪兽不送去墓地回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・メロウガイスト
function c76372778.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76372778,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c76372778.condition)
	e1:SetCost(c76372778.cost)
	e1:SetOperation(c76372778.operation)
	c:RegisterEffect(e1)
end
function c76372778.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not bc:IsType(TYPE_TOKEN)
		and bc:GetLeaveFieldDest()==0 and bc:GetDestination()~=LOCATION_DECK
end
function c76372778.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c76372778.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetCondition(c76372778.recon)
		e1:SetValue(LOCATION_DECKSHF)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
	end
end
function c76372778.recon(e)
	local c=e:GetHandler()
	return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_BATTLE)
end
