--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑羽-银盾之密史脱拉  (ID: 46710683)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Winged Beast
-- Level 2
-- ATK 100 | DEF 1800
-- Setcode: 51
--
-- Effect Text:
-- 场上存在的这张卡被破坏送去墓地的场合，这个回合自己受到的战斗伤害只有1次变成0。
--[[ __CARD_HEADER_END__ ]]

--BF－銀盾のミストラル
function c46710683.initial_effect(c)
	--change damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46710683,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c46710683.condition)
	e1:SetOperation(c46710683.operation)
	c:RegisterEffect(e1)
end
function c46710683.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c46710683.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
