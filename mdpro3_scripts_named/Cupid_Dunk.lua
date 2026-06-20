--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 篮球小爱神  (ID: 69526976)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1800 | DEF 600
--
-- Effect Text:
-- ①：这张卡不会被和除持有比这张卡高的等级的怪兽以外的怪兽的战斗破坏。
-- ②：自己准备阶段才能发动。这张卡的等级上升1星。
--[[ __CARD_HEADER_END__ ]]

--ロー・キューピット
function c69526976.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c69526976.indval)
	c:RegisterEffect(e1)
	--level up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c69526976.lvcon)
	e2:SetTarget(c69526976.lvtg)
	e2:SetOperation(c69526976.lvop)
	c:RegisterEffect(e2)
end
function c69526976.indval(e,c)
	return not c:IsLevelAbove(e:GetHandler():GetLevel()+1)
end
function c69526976.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c69526976.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(1) end
end
function c69526976.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
