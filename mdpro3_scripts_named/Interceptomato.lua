--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 阻碍番茄  (ID: 19113101)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 2
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 把墓地的这张卡从游戏中除外才能发动。这个回合，自己受到的效果伤害变成0。这个效果在对方回合才能发动。
--[[ __CARD_HEADER_END__ ]]

--プリベントマト
function c19113101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19113101,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c19113101.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c19113101.operation)
	c:RegisterEffect(e1)
end
function c19113101.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c19113101.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c19113101.damval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c19113101.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
