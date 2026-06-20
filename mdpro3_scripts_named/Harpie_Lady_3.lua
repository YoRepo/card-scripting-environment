--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 鹰身女郎3  (ID: 54415063)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 1400
-- Setcode: 100
--
-- Effect Text:
-- 这张卡的卡名当作「鹰身女郎」使用。和这张卡发生战斗的对方怪兽，此怪兽在对方的2个回合内攻击宣言不能。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ3
function c54415063.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c54415063.operation)
	c:RegisterEffect(e1)
end
function c54415063.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	bc:RegisterEffect(e1)
end
