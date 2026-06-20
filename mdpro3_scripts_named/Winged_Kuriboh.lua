--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 羽翼栗子球  (ID: 57116033)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 4260
--
-- Effect Text:
-- ①：场上的这张卡被破坏送去墓地的场合发动。这个回合，自己受到的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--ハネクリボー
function c57116033.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57116033,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c57116033.con)
	e1:SetOperation(c57116033.op)
	c:RegisterEffect(e1)
end
function c57116033.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY)
end
function c57116033.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
